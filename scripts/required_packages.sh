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

PKG_FILE="$HOME/dotfiles/packages/required/required-pacman.txt"
mapfile -t PKGS < <(grep -Ev '^\s*#' "$PKG_FILE")
sudo pacman -Sy "${PKGS[@]}" --noconfirm

