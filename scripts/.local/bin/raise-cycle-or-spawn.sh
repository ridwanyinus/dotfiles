#!/usr/bin/env bash
#######################################################################################
## Raise, Cycle, or Spawn                                                            ##
##                                                                                   ##
## A helper script for the niri window manager that implements                       ##
## “raise-or-run” behavior with window cycling.                                      ##
##                                                                                   ##
## Based on and improved from eXsoR65 script:                                        ##
## https://gist.github.com/eXsoR65/6c760854ea1187cd398b89b9ef5aa479                  ##
#######################################################################################
## Installation                                                                      ##
## ------------                                                                      ##
## 1. Place this script somewhere in your $PATH (e.g. ~/.local/bin),                 ##
##    make it executable, and remove the .sh extension:                              ##
##                                                                                   ##
##      chmod +x raise-cycle-or-spawn                                                ##
##                                                                                   ##
## Usage                                                                             ##
## -----                                                                             ##
## 2. Create a bind in your niri config with spawn-sh. This version only             ##
##    requires ONE argument. It will use that argument to fuzzy-match the app_id     ##
##    and, if no window is found, it will use it as the command to spawn.            ##
##                                                                                   ##
##    Example:                                                                       ##
##      Mod+B { spawn-sh "raise-cycle-or-spawn zen"; }                               ##
##      Mod+return { spawn-sh "raise-cycle-or-spawn kitty"; }                        ##
##                                                                                   ##
## Behavior                                                                          ##
## --------                                                                          ##
##   • If no matching window exists → spawn the application                          ##
##   • If one matching window exists → focus (raise) it                              ##
##   • If multiple matching windows exist → cycle focus between them                 ##
##   • Uses case-insensitive fuzzy matching for app_ids                              ##
#######################################################################################

set -euo pipefail

raise_or_cycle() {
  local search_term="$1"
  local tmp
  tmp="$(mktemp)"
  trap 'rm -f "$tmp"' EXIT

  # Get window list from niri
  if ! niri msg --json windows >"$tmp" 2>/dev/null; then
    return 1
  fi

  # Find IDs using case-insensitive 'contains'
  # It compares the lowercase app_id against your lowercase search term
  mapfile -t ids < <(jq -r --arg search "${search_term,,}" \
    '.[] | select(.app_id != null) | select(.app_id | ascii_downcase | contains($search)) | .id' <"$tmp")

  # If no windows found, return failure so we can spawn
  ((${#ids[@]})) || return 1

  local focused
  focused="$(jq -r '.[] | select(.is_focused) | .id' <"$tmp")"

  # Find the next window to cycle to
  local next_idx=0
  for ((i = 0; i < ${#ids[@]}; i++)); do
    if [[ "${ids[$i]}" == "$focused" ]]; then
      next_idx=$(((i + 1) % ${#ids[@]}))
      break
    fi
  done

  niri msg action focus-window --id "${ids[$next_idx]}"
  exit 0
}

# The single argument serves as both the search term and the executable
target="${1:-}"

if [[ -z "$target" ]]; then
  echo "Usage: $0 <app_name>" >&2
  exit 2
fi

# Map common commands to their actual app_ids
case "${target,,}" in
"zen-browser")
  search_term="zen"
  spawn_command="zen-browser"
  ;;
*)
  search_term="$target"
  spawn_command="$target"
  ;;
esac

# 1. Try to focus or cycle existing windows
if raise_or_cycle "$search_term"; then
  exit 0
fi
# 2. If no window matched, spawn the command
niri msg action spawn -- "$spawn_command"
