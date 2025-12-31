from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)

LEFT_HALF_CIRCLE = ""
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


def _draw_right_status(screen: Screen, is_last: bool, draw_data: DrawData) -> int:
    if not is_last:
        return 0

    draw_attributed_string(Formatter.reset, screen)

    cell = _get_battery_cell()
    length = 3 + len(cell["icon"]) + len(cell["text"])

    # exact same alignment as your old calendar cell
    screen.cursor.x = screen.columns - length

    default_bg = as_rgb(int(draw_data.default_bg))
    inactive_bg = as_rgb(int(draw_data.inactive_bg))
    inactive_fg = as_rgb(int(draw_data.inactive_fg))

    screen.cursor.bg = default_bg

    # powerline separator
    screen.cursor.fg = inactive_bg
    screen.draw(LEFT_HALF_CIRCLE)

    # icon
    screen.cursor.bg = inactive_bg
    screen.cursor.fg = inactive_fg
    screen.draw(cell["icon"])

    # text
    screen.cursor.bg = default_bg
    screen.cursor.fg = inactive_fg
    screen.draw(f" {cell['text']} ")

    return screen.cursor.x


def _redraw_tab_bar(_) -> None:
    tm = get_boss().active_tab_manager
    if tm:
        tm.mark_tab_bar_dirty()


timer_id = None


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

    draw_tab_with_powerline(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )

    _draw_right_status(screen, is_last, draw_data)
    return screen.cursor.x
