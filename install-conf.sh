#!/bin/bash

# Git
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

# Shell
ln -sf ~/dotfiles/shell/.bashrc ~/.bashrc

# Terminal
mkdir -p ~/.config/alacritty

ln -sf ~/dotfiles/terminal/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf ~/dotfiles/terminal/catppuccin_macchiato.toml ~/.config/alacritty/catppuccin_macchiato.toml