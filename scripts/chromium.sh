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

sudo mkdir -p /etc/chromium/policies/managed/

sudo cp ./configs/desktop/chromium/extensions.json /etc/chromium/policies/managed/extensions.json
