# ─────────────────────────────────────────────
# ALIASES
# ─────────────────────────────────────────────

# General
alias c='clear'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=2 --long --icons --git'
alias md='mkdir -p'
alias rd='rm -rf'
alias v='$EDITOR'
alias wifi='nmtui'
alias copy='wl-copy'
alias oc='opencode'
alias r='rmpc'

alias mkdir='mkdir -p'
alias ping='ping -c 10'
alias vim='$EDITOR'
alias tmux='tmux -u'
alias t='tmux -u'

# Power
abbr shutdown 'systemctl poweroff'
abbr soft-reboot 'sudo systemctl soft-reboot'
abbr hibernate 'qs -c noctalia-shell ipc call lockScreen lock && systemctl hibernate'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'

# asciinema
alias rec='asciinema rec -c'
alias play='asciinema play -i 2'
alias upload='asciinema upload'

# Recording
alias wf-rec='wf-recorder -f ~/Videos/rec-$(date +%Y%m%d-%H%M%S).mp4'

# Info
alias last-updated='grep -i "full system upgrade" /var/log/pacman.log | tail -n 1'
alias nlof='~/.local/bin/fzf_listoldfiles.sh'

# ─────────────────────────────────────────────
# ABBREVIATIONS
# ─────────────────────────────────────────────

# Quick shortcuts
abbr -a n nvim
abbr -a lg lazygit
abbr -a x exit
abbr -a nd 'npm run dev'
abbr -a open 'dolphin .'
abbr -a chx 'chmod +x'
abbr -a folders 'du -h --max-depth=1' # Folder sizes one level deep

# tmux
abbr -a tmuxk 'tmux kill-session'
abbr ss sesh-pick

# System info
abbr -a cache ' sudo du -sh /var/cache/pacman/pkg ~/.cache/yay ~/.cache/paru'

# Package management
abbr -a update      'sudo pacman -Syu'                                             # Full system upgrade
abbr -a update-grub 'sudo grub-mkconfig -o /boot/grub/grub.cfg'                   # Regenerate grub config
abbr -a cleanup     'sudo pacman -Rns $(pacman -Qdtq)'                             # Remove orphaned packages
abbr -a showpkg     'pacman -Qi'                                                   # Show installed package info
abbr -a mirrorfix   'sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist'        # Update to fastest mirrors
abbr -a pacclean    'sudo paccache -r'                                             # Keep 3 newest pkg versions, delete rest
abbr -a paccleanall 'sudo paccache -r -c /var/cache/pacman/pkg -u'                 # Remove cached uninstalled pkgs
abbr -a cleanc 'sudo pacman -Sc && paru -Sc && yay -Sc' # Nuclear cache wipe — use sparingly

# AUR fuzzy search
abbr -a yayf  "yay -Slq | strings | grep -E '^[a-zA-Z0-9_.+-]+\$' | fzf --multi --layout=reverse --ansi --preview 'yay -Sii {1}' --preview-window=down:75% --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' | xargs -ro yay -S"
abbr -a paruf "yay --color=never -Slq | grep -E '^[a-zA-Z0-9_.+-]+\$' | fzf --multi --layout=reverse --ansi --preview 'paru -Sii {1}' --preview-window=down:75% --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' | xargs -ro paru -S"
