#!/bin/bash
# ==============================================================================
# ZEN BROWSER BACKUP & SYNC (git)
# ==============================================================================

set -euo pipefail


# === CONFIG ===
# local loading dock and git workspace
backup_root="$HOME/backups/zenbrowser"
repo_dir="$backup_root/git_repo"
# replace with your private git repository url
repo_url="git@github.com:username/zen-backups.git"

# === PROFILE DETECTION ===
detect_profile() {
    # scans for the zen profile directory
    profile_path=$(find "$HOME/.zen" "$HOME/.var/app/io.github.zen_browser.zen/.zen" -maxdepth 4 -name "places.sqlite" 2>/dev/null | head -n 1 | sed 's|/places.sqlite||')
    
    if [[ -z "$profile_path" ]]; then
        echo "error: no zen profile found."
        exit 1
    fi
    echo "$profile_path"
}

# === CORE FUNCTIONS ===
check_browser_closed() {
    if pgrep -x "zen" > /dev/null || pgrep -x "zen-bin" > /dev/null; then
        echo "error: zen browser is currently running. please close it before continuing."
        exit 1
    fi
}

backup() {
    check_browser_closed
    selected_profile=$(detect_profile)
    echo "starting backup from: $selected_profile"

    # setup directories
    mkdir -p "$repo_dir"
    if [ ! -d "$repo_dir/.git" ]; then
        echo "initializing repository..."
        git clone "$repo_url" "$repo_dir" || (cd "$repo_dir" && git init)
    fi

    # 1. copy data (history, passwords, tabs)
    cp "$selected_profile/places.sqlite" "$repo_dir/"
    cp "$selected_profile/cookies.sqlite" "$repo_dir/" 2>/dev/null
    cp "$selected_profile/key4.db" "$repo_dir/"
    cp "$selected_profile/logins.json" "$repo_dir/"
    cp "$selected_profile/sessionstore.jsonlz4" "$repo_dir/" 2>/dev/null

    # 2. copy rice (visuals and extensions)
    # copies the chrome folder (css/themes) and extensions
    rm -rf "$repo_dir/chrome" "$repo_dir/extensions"
    cp -r "$selected_profile/chrome" "$repo_dir/" 2>/dev/null || mkdir -p "$repo_dir/chrome"
    cp -r "$selected_profile/extensions" "$repo_dir/" 2>/dev/null || mkdir -p "$repo_dir/extensions"

    # 3. sanitize settings (prevents crashes on other machines)
    if [ -f "$selected_profile/prefs.js" ]; then
        cp "$selected_profile/prefs.js" "$repo_dir/user.js"
        # remove absolute home paths and file urls
        sed -i '/\/home\//d' "$repo_dir/user.js"
        sed -i '/file:\/\//d' "$repo_dir/user.js"
        
        # force enable custom stylesheets for the rice to work
        echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$repo_dir/user.js"
        echo 'user_pref("svg.context-properties.content.enabled", true);' >> "$repo_dir/user.js"
    fi

    # 4. push to cloud
    cd "$repo_dir"
    git add .
    git commit -m "sync: $(date +'%y-%m-%d %h:%m:%s')"
    git push origin main || git push origin master
    echo "backup and sync complete."
}

restore() {
    check_browser_closed
    selected_profile=$(detect_profile)
    echo "starting restore to: $selected_profile"

    if [ ! -d "$repo_dir/.git" ]; then
        echo "error: local git repository not found. run backup first or clone your repo to $repo_dir."
        exit 1
    fi

    # 1. pull latest from cloud
    cd "$repo_dir"
    git pull origin main || git pull origin master

    # 2. restore data
    cp "$repo_dir/places.sqlite" "$selected_profile/"
    cp "$repo_dir/key4.db" "$selected_profile/"
    cp "$repo_dir/logins.json" "$selected_profile/"
    [ -f "$repo_dir/cookies.sqlite" ] && cp "$repo_dir/cookies.sqlite" "$selected_profile/"
    [ -f "$repo_dir/sessionstore.jsonlz4" ] && cp "$repo_dir/sessionstore.jsonlz4" "$selected_profile/"

    # 3. restore rice and extensions (clean wipe of existing folders first)
    rm -rf "$selected_profile/chrome"
    rm -rf "$selected_profile/extensions"
    
    [ -d "$repo_dir/chrome" ] && cp -r "$repo_dir/chrome" "$selected_profile/"
    [ -d "$repo_dir/extensions" ] && cp -r "$repo_dir/extensions" "$selected_profile/"
    
    # 4. apply sanitized settings
    [ -f "$repo_dir/user.js" ] && cp "$repo_dir/user.js" "$selected_profile/"

    echo "restore complete. you can now open zen browser."
}

# === MAIN ===
case "${1:-}" in
    backup)
        backup
        ;;
    restore)
        restore
        ;;
    *)
        echo "usage: $0 {backup|restore}"
        exit 1
        ;;
esac
