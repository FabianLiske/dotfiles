#!/bin/bash
#set -euo pipefail

# Colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Banner
echo -e "${GREEN}"
figlet "Chromium"
echo -e "${NONE}"

sudo pacman -Sy chromium --noconfirm

sudo mkdir -p "/etc/chromium/policies/managed/"

sudo cp "$HOME/dotfiles/configs/apps/chromium/extensions.json" "/etc/chromium/policies/managed/extensions.json"
sudo cp "$HOME/dotfiles/configs/apps/chromium/preferences.json" "/etc/chromium/policies/managed/preferences.json"