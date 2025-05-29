#!/bin/bash
set -euo pipefail

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local.share"
mkdir -p "$HOME/.icons"

cp -r "$HOME/dotfiles/configs/desktop/hypr" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/desktop/icons" "$HOME/.icons/"
cp -r "$HOME/dotfiles/configs/desktop/wallpaper" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/desktop/waybar" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/desktop/wofi" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/desktop/fonts" "$HOME/.local/share/"
cp -r "$HOME/dotfiles/configs/monitoring/btop" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/monitoring/fastfetch" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/terminal/kitty" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/shell/starship.toml" "$HOME/.config/"

cp "$HOME/dotfiles/configs/shell/.bashrc" "$HOME/"
cp "$HOME/dotfiles/configs/shell/.gitconfig" "$HOME/"

echo "Dotfiles copied!"