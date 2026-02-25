from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.tab_bar import DrawData, ExtraData, Formatter, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int

opts = get_options()

ICON = "   "
ICON_FG = as_rgb(color_as_int(opts.color0))
ICON_BG = as_rgb(color_as_int(opts.color10))
INACTIVE_FG = as_rgb(color_as_int(opts.color15))

LEFT_SEP = ""
RIGHT_SEP = ""
ICON_SEP_COLOR_FG = as_rgb(color_as_int(opts.color10))
ICON_SEP_COLOR_BG = as_rgb(color_as_int(opts.background))

# Battery configuration
CHARGING_ICON = "󰚥 "
UNPLUGGED_ICONS = {
    10: "󰂃 ",
    20: "󰁻 ",
    30: "󰁼 ",
    40: "󰁽 ",
    50: "󰁾 ",
    60: "󰁿 ",
    70: "󰂀 ",
    80: "󰂁 ",
    90: "󰂂 ",
    100: "󱟢 ",
}
REFRESH_TIME = 1

timer_id = None


def _get_battery_cell() -> dict:
    cell = {"icon": "", "text": ""}
    try:
        with open("/sys/class/power_supply/BAT0/status") as f:
            status = f.read().strip()
        with open("/sys/class/power_supply/BAT0/capacity") as f:
            percent = int(f.read())

        if status == "Charging":
            cell["icon"] = CHARGING_ICON
        else:
            cell["icon"] = UNPLUGGED_ICONS[
                min(UNPLUGGED_ICONS, key=lambda x: abs(percent - x))
            ]
        cell["text"] = f"{percent}%"
    except FileNotFoundError:
        cell["text"] = "Err"
    return cell


def _redraw_tab_bar(_) -> None:
    tm = get_boss().active_tab_manager
    if tm:
        tm.mark_tab_bar_dirty()


def __draw_icon(screen: Screen, index: int) -> int:
    if index != 1:
        return 0
    icon_fg, icon_bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg = ICON_FG
    screen.cursor.bg = ICON_BG
    screen.draw(ICON)
    screen.cursor.fg = ICON_SEP_COLOR_FG
    screen.cursor.bg = ICON_SEP_COLOR_BG
    screen.draw(RIGHT_SEP)
    screen.cursor.fg, screen.cursor.bg = icon_fg, icon_bg
    end = screen.cursor.x
    return end


def __draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    max_tab_length: int,
    index: int,
    extra_data: ExtraData,
) -> int:
    tab_bg = screen.cursor.bg
    default_bg = as_rgb(int(draw_data.default_bg))
    inactive_fg = as_rgb(int(draw_data.inactive_fg))
    if extra_data.next_tab:
        next_tab_bg = as_rgb(draw_data.tab_bg(extra_data.next_tab))
    else:
        next_tab_bg = default_bg

    # If active tab, match skull icon colors
    if tab.is_active:
        tab_bg = ICON_BG
        screen.cursor.bg = ICON_BG
        screen.cursor.fg = ICON_FG
    else:
        screen.cursor.fg = default_bg

    screen.draw(RIGHT_SEP)
    if not tab.is_active:
        screen.cursor.fg = INACTIVE_FG
    draw_title(draw_data, screen, tab, index, max_tab_length)
    screen.cursor.fg = tab_bg
    screen.cursor.bg = default_bg
    screen.draw(RIGHT_SEP)
    screen.cursor.fg = tab_bg
    screen.cursor.bg = next_tab_bg
    end = screen.cursor.x
    return end


def _draw_battery(screen: Screen, draw_data: DrawData, is_last: bool) -> int:
    if not is_last:
        return screen.cursor.x

    cell = _get_battery_cell()
    # Account for wide characters (icons are 2 cols) + spaces
    length = 3 + len(cell["icon"]) + len(cell["text"])

    default_bg = as_rgb(int(draw_data.default_bg))
    inactive_bg = as_rgb(int(draw_data.inactive_bg))
    inactive_fg = as_rgb(int(draw_data.inactive_fg))

    # Position at right side
    screen.cursor.x = screen.columns - length
    screen.cursor.bg = default_bg

    # Draw powerline separator
    screen.cursor.fg = inactive_bg
    screen.draw(LEFT_SEP)

    # Draw battery icon
    screen.cursor.bg = inactive_bg
    screen.cursor.fg = inactive_fg
    screen.draw(cell["icon"])

    # Draw percentage
    screen.cursor.bg = default_bg
    screen.cursor.fg = inactive_fg
    screen.draw(f" {cell['text']}")

    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id

    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)

    # Reserve space for battery on last tab
    if is_last:
        battery_width = 8  # Approximate width: icon(3) + text(4) + space(1)
        max_title_length = max(0, max_title_length - battery_width)

    __draw_icon(screen, index)
    end = __draw_tab(draw_data, screen, tab, max_title_length, index, extra_data)

    # Draw battery on last tab after all tabs are drawn
    if is_last:
        _draw_battery(screen, draw_data, is_last)

    return end
