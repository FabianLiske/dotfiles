#!/bin/bash
set -euo pipefail

mkdir -p "$HOME/.config"

cp -r "$HOME/dotfiles/configs/monitoring/btop" "$HOME/.config/"
cp -r "$HOME/dotfiles/configs/monitoring/fastfetch" "$HOME/.config/"

echo "Dotfiles copied!"
