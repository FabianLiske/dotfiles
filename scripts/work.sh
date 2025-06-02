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

mkdir -p "$HOME/.local/share/applications"

cp "$HOME/dotfiles/configs/apps/teams/teams-pwa.desktop" "$HOME/.local/share/applications/teams-pwa.desktop"