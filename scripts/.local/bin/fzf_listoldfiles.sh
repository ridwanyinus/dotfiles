#!/usr/bin/env bash
# Opens recent Neovim files using fzf.
#
# Setup:
#   fish:  alias nlof='bash ~/.local/bin/nlof.sh'  (in config.fish)
#   bash:  alias nlof='bash ~/.local/bin/nlof.sh'  (in .bashrc)

set -euo pipefail

readonly PREVIEW_LINE_LIMIT=500

_die() {
    echo "[nlof] error: $*" >&2
    exit 1
}

_get_oldfiles() {
    # No -u NONE — let nvim load real config so shada/oldfiles work correctly
    nvim --headless \
        +'lua io.write(table.concat(vim.v.oldfiles,"\n").."\n"); io.flush()' \
        +qa 2>/dev/null ||
        _die "failed to read oldfiles from Neovim. Is nvim installed?"
}

_filter_valid_files() {
    while IFS= read -r file; do
        [[ "$file" == \[* ]] && continue
        [[ -f "$file" ]] && printf '%s\n' "$file"
    done
}

_pick_with_fzf() {
    fzf --multi \
        --preview "bat -n --color=always --line-range=:${PREVIEW_LINE_LIMIT} {} 2>/dev/null \
               || echo 'preview unavailable'" \
        --height=70% \
        --layout=default \
        --info=inline-right
}

list_oldfiles() {
    local -a valid_files
    mapfile -t valid_files < <(_get_oldfiles | _filter_valid_files)

    if [[ ${#valid_files[@]} -eq 0 ]]; then
        _die "no valid recent files found."
    fi

    local -a selected
    mapfile -t selected < <(printf '%s\n' "${valid_files[@]}" | _pick_with_fzf || true)

    if [[ ${#selected[@]} -gt 0 ]]; then
        nvim "${selected[@]}"
    fi
}

list_oldfiles
