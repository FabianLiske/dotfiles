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
figlet "Misc Apps"
echo -e "${NONE}"

sudo pacman -Sy \
    discord \
    obs-studio \
    --noconfirm

#yay -S \
#    spicetify-cli \
#    --noconfirm