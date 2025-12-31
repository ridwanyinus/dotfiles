#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"

# Loop over all directories in your dotfiles folder and unstow them
for dir in "$DOTFILES"/*/; do
    # Remove the symlinks created by stow
    stow -v -D -d "$DOTFILES" "$(basename "$dir")"
done
