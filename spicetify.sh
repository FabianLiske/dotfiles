#!/bin/bash
set -euo pipefail

sudo pacman -Sy spotify-launcher --noconfirm
yay -S spicetify-cli --noconfirm

mkdir -p "$HOME/.config/spicetify/Themes"
cp "$HOME/dotfiles/themes/spicetify/config-xpui.ini" "$HOME/.config/spicetify/"


git clone https://github.com/spicetify/spicetify-themes.git /tmp/spicetify-themes

cp -r "/tmp/spicetify-themes/*" "$HOME/.config/spicetify/Themes/"

spicetify backup apply