#!/bin/bash
set -euo pipefail

##################
### ROOT CHECK ###
##################

if [ "$(id -u)" = 0 ]; then
    echo ":: This script shouldn't be run as root."
    exit 1
fi

clear
GREEN='\033[0;32m'
NONE='\033[0m'

echo -e "${GREEN}"
figlet "Spicetify"
echo -e "${NONE}"

sudo pacman -Sy spotify-launcher --noconfirm
yay -S spicetify-cli --noconfirm

mkdir -p "$HOME/.config/spicetify/Themes"
cp "$HOME/dotfiles/configs/themes/spicetify/config-xpui.ini" "$HOME/.config/spicetify/"


git clone https://github.com/spicetify/spicetify-themes.git /tmp/spicetify-themes

cp -r "/tmp/spicetify-themes/"* "$HOME/.config/spicetify/Themes/"

echo -e "${GREEN}"
figlet "Attention!"
echo -e "${NONE}"
echo "Run Spotify once, then 'spicetify backup apply' after installation script finished."

read -n 1 -r -p "Press ENTER to continue..."
