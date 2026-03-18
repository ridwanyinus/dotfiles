#!/usr/bin/env bash
# Statusbar plugin for tmux — TPM entry point

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Export scripts path so statusbar #() calls can find them
tmux set -g @_sb_scripts "$CURRENT_DIR/scripts"

# Ensure scripts are executable
chmod +x "$CURRENT_DIR/scripts/"*.sh 2>/dev/null

tmux source-file "$CURRENT_DIR/statusbar_options.conf"
tmux source-file "$CURRENT_DIR/statusbar.conf"
