#!/bin/bash

echo "Removing symlinks for dotfiles..."

# Paths to your dotfiles
DOTFILES_DIR="$HOME/dotfiles"

# Remove symlinks for zsh, vim, and tmux based on folder structure
[ -L "$HOME/.zshrc" ] && rm "$HOME/.zshrc" && echo "Removed ~/.zshrc"
[ -L "$HOME/.vimrc" ] && rm "$HOME/.vimrc" && echo "Removed ~/.vimrc"
[ -L "$HOME/.tmux.conf" ] && rm "$HOME/.tmux.conf" && echo "Removed ~/.tmux.conf"

# Optional: Remove leftover directories (if any exist)
[ -d "$HOME/.vim" ] && rm -rf "$HOME/.vim" && echo "Removed ~/.vim directory"
[ -d "$HOME/.tmux" ] && rm -rf "$HOME/.tmux" && echo "Removed ~/.tmux directory"

echo "Dotfiles symlinks removed!"
