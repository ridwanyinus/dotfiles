# -----------------------------------------------------
# INIT
# -----------------------------------------------------
set -U fish_greeting ""

# -----------------------------------------------------
# EDITOR
# -----------------------------------------------------
set -Ux EDITOR nvim
set -Ux LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
# -----------------------------------------------------
# PATH
# -----------------------------------------------------
set -U fish_user_paths /usr/lib/ccache/bin/
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin/
set -U fish_user_paths $fish_user_paths $HOME/.local/bin/

# Amp CLI
fish_add_path /home/ridwan/.amp/bin
# Spicetify (Spotify customizer)
fish_add_path /home/ridwan/.spicetify
# Deno
fish_add_path /home/ridwan/.deno/env

# -----------------------------------------------------
# FZF
# -----------------------------------------------------
# Key bindings
fzf --fish | source

# Use fd as default search command (include hidden, exclude .git)
set -Ux FZF_DEFAULT_COMMAND "fd -H -E --strip-cwd-prefix '.git'"

# Default appearance options
set -Ux FZF_DEFAULT_OPTS (printf '%s ' \
    '--style=full' \
    '--info=hidden' \
    '--ansi' \
    '--pointer=👉' \
    '--gutter=" "' \
    '--color=current-bg:-1' \
    '--color=current-fg:blue' \
    '--color=gutter:-1' \
    '--color=header-bg:-1' \
    '--color=header-border:cyan' \
    '--color=hl+:yellow' \
    '--color=hl:yellow' \
    '--color=input-border:yellow' \
    '--color=list-border:blue' \
    '--color=pointer:blue' \
    '--color=preview-border:cyan' | string collect)

# Keybinding-specific options
# ctrl-t: file picker with preview
set -gx FZF_CTRL_T_OPTS "--tmux 80% --preview '~/.local/bin/fzf-preview.sh {}'"
# alt-c: directory picker with tree preview
set -gx FZF_ALT_C_OPTS "--tmux 80% --preview 'eza --icons=always --tree --color=always {} | head -200'"
# ctrl-r: history picker with clipboard support
set -gx FZF_CTRL_R_OPTS "
  --tmux bottom,30%
  --preview-window hidden
  --header-label ''
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# -----------------------------------------------------
# ZOXIDE (smart cd)
# -----------------------------------------------------
zoxide init fish | source

# -----------------------------------------------------
# YAZI (file manager - cd on exit)
# -----------------------------------------------------
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# -----------------------------------------------------
# SESH (tmux session manager)
# -----------------------------------------------------
set -gx SESH_TMUX_OPTS "-u"
