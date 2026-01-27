# Start SSH agent if not already running
if not set -q SSH_AUTH_SOCK; or not test -S $SSH_AUTH_SOCK
    eval (ssh-agent -c) >/dev/null
end

# Add private keys only (they don't have .pub extension)
for key in ~/.ssh/id_ed25519_github_main ~/.ssh/id_ed25519_github_secondary
    ssh-add -l | grep -q (basename $key) >/dev/null 2>&1; or ssh-add $key >/dev/null 2>&1
end

# 1. Define the function that fetches the last command
function last_history_item
    echo $history[1]
end

# 2. Create the abbreviation
abbr -a !! --position anywhere --function last_history_item

# Force cursor_block
fish_vi_key_bindings
