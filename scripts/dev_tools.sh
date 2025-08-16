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

# make yay faster - do not use compression
sudo sed -i "s/PKGEXT=.*/PKGEXT='.pkg.tar'/g" /etc/makepkg.conf
sudo sed -i "s/SRCEXT=.*/SRCEXT='.src.tar'/g" /etc/makepkg.conf

echo -e "${GREEN}"
figlet "Dev Tooling"
echo -e "${NONE}"

PKG_FILE="$HOME/dotfiles/packages/dev_tools.txt"
mapfile -t PKGS < <(grep -Ev '^\s*#' "$PKG_FILE")
sudo pacman -Sy "${PKGS[@]}" --noconfirm

#yay -S \
#    --noconfirm

sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER

# cleanup
echo -e "${GREEN}"
figlet "Cleanup"
echo -e "${NONE}"
sudo pacman -Rns $(pacman -Qtdq) --noconfirm
yay -Sc --noconfirm

echo -e "${GREEN}"
figlet "Done"
echo -e "${NONE}"

