#!/usr/bin/env bash

# Loop over all directories and stow them
for dir in */; do
    stow -v "$dir"
done
