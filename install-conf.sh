#!/bin/bash

# Git
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

# Shell
mkdir -p ~/.config
ln -sf ~/dotfiles/shell/.bashrc ~/.bashrc
ln -sf ~/dotfiles/shell/starship.toml

# Terminal
mkdir -p ~/.config/alacritty

ln -sf ~/dotfiles/terminal/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf ~/dotfiles/terminal/catppuccin_macchiato.toml ~/.config/alacritty/catppuccin_macchiato.toml

# btop
mkdir -p ~/.config/btop

ln -sf ~/dotfiles/btop/btop.conf ~/.config/btop/btop.conf