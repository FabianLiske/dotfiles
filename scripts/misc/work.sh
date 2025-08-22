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

echo "Setup for Davinci Resolve:"
echo "Install will fail, download Resolve from Website and place .zip in yay-cache."
echo "Then run yay -S davinci-resolve again"
yay -S davinci-resolve
