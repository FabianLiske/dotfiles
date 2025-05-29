#!/bin/bash
set -euo pipefail

mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.local/share/fonts"
mkdir -p "$HOME/.icons"

cp -r "$HOME/dotfiles/configs/desktop/hypr" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/desktop/icons/default" "$HOME/.icons/"
cp -r "$HOME/dotfiles/configs/desktop/wallpaper" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/desktop/waybar" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/desktop/wofi" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/desktop/fonts/." "$HOME/.local/share/fonts/"
cp -r "$HOME/dotfiles/configs/monitoring/btop" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/monitoring/fastfetch" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/terminal/kitty" "$HOME/.config/"

cp "$HOME/dotfiles/configs/shell/starship.toml" "$HOME/.config/"
cp "$HOME/dotfiles/configs/shell/.bashrc" "$HOME/"
cp "$HOME/dotfiles/configs/shell/.gitconfig" "$HOME/"
cp "$HOME/dotfiles/configs/desktop/gtk/gtkrc-2.0" "$HOME/.gtkrc-2.0"
cp "$HOME/dotfiles/configs/desktop/gtk/settings.ini" "$HOME/.config/gtk-3.0/"

fc-cache -fv

echo "Dotfiles copied!"