# Source all helper scripts
for f in "$HOME/dotfiles/bashrc/helpers/"*; do
    [ -f "$f" ] && source "$f"
done

export PATH=$PATH:/home/ridwan/.spicetify
. "/home/ridwan/.deno/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
