# -----------------------------------------------------
# INIT
# -----------------------------------------------------

set -U fish_greeting ""

# -----------------------------------------------------
# Exports
# -----------------------------------------------------
set -Ux EDITOR nvim
set -Ux LANG en_US.UTF-8

set -U fish_user_paths /usr/lib/ccache/bin/
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin/
set -U fish_user_paths $fish_user_paths $HOME/.local/bin/

# Amp CLI
fish_add_path /home/ridwan/.amp/bin

fish_add_path /home/ridwan/.spicetify
fish_add_path /home/ridwan/.deno/env

# Set up fzf key bindings
fzf --fish | source
set -Ux FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND --exclude '**/node_modules' --exclude '**/.next' --exclude '**/dist' --exclude '**/build'"
set -Ux FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude '**/node_modules' --exclude '**/.next' --exclude '**/dist' --exclude '**/build'"
set -Ux FZF_DEFAULT_OPTS '--style full --border --padding 1,2 --border-label " Search " --input-label " Input " --header-label " File Type " --bind "focus:+transform-header:file --brief {}" --bind "result:transform-list-label:if [[ -z \$FZF_QUERY ]]; then echo \" \$FZF_MATCH_COUNT items \"; else echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"; fi" --bind "focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}" --preview "TERM=\$TERM KITTY_WINDOW_ID=\$KITTY_WINDOW_ID ~/.local/bin/fzf-preview.sh {}" --preview-window "right:50%:border-left" --height 50% --layout=default --color=hl:#2dd4bf --color=border:#aaaaaa,label:#cccccc --color=preview-border:#9999cc,preview-label:#ccccff --color=list-border:#669966,list-label:#99cc99 --color=input-border:#996666,input-label:#ffcccc --color=header-border:#6699cc,header-label:#99ccff'
set -Ux FZF_TAB_COLORS 'fg:#CDD6F4,bg:#1E1E2E,hl:#F38BA8,min-height=5'

# Setup fzf
set -Ux FZF_CTRL_T_OPTS "--preview '~/.local/bin/fzf-preview.sh {}'"
set -Ux FZF_ALT_C_OPTS "--preview 'eza --icons=always --tree --color=always {} | head -200'"

set -Ux FZF_CTRL_R_OPTS "
  --preview-window hidden
  --header-label ''
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
