#!/bin/bash
set -euo pipefail

mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.local/share/fonts"
mkdir -p "$HOME/.icons"

cp -r "$HOME/dotfiles/configs/monitoring/btop" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/monitoring/fastfetch" "$HOME/.config/"

echo "Dotfiles copied!"
