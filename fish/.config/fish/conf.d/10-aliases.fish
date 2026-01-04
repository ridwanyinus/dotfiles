# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

# -----------------------------------------------------
# General
# -----------------------------------------------------
alias c='clear'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=2 --long --icons --git'
alias md='mkdir -p'
alias rd='rmdir'

alias shutdown='systemctl poweroff'
alias hibernate='qs -c noctalia-shell ipc call lockScreen lock && systemctl suspend-then-hibernate'
alias v='$EDITOR'
alias vim='$EDITOR'
alias wifi='nmtui'
alias copy='wl-copy'


# -----------------------------------------------------
# FZF 
# -----------------------------------------------------

# called from ~/scripts/
alias nlof="~/.local/bin/fzf_listoldfiles.sh"

# -----------------------------------------------------
# Lazygit
# -----------------------------------------------------
alias lg="lazygit"

# -----------------------------------------------------
# Git
# -----------------------------------------------------
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# -----------------------------------------------------
# asciinema
# -----------------------------------------------------
alias rec 'asciinema rec -c'
alias play 'asciinema play -i 2'
alias upload 'asciinema upload'

# wf-recorder
alias wf-rec='wf-recorder -f ~/Videos/rec-$(date +%Y%m%d-%H%M%S).mp4'
