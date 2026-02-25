#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"

for dir in "$DOTFILES"/*/; do
  # Remove the symlinks created by stow
  stow -v -D -d "$DOTFILES" "$(basename "$dir")"
done
