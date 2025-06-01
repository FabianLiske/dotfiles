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

echo "Start base services"
sudo systemctl enable sshd

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Banner
echo -e "${GREEN}"
echo "Module Installer"
echo -e "${NONE}"

run_step() {
    local description="$1"
    local script="$2"
    echo
    read -p ">> Run $description ? [y/N] " answer
    case "$answer" in
        [Yy]* )
            echo "Starting $script ..."
            bash "$SCRIPT_DIR/$script"
            ;;
        * )
            echo "Skipping $description."
            ;;
    esac
}

# Beispiel: Einzelne Schritte abfragen
run_step "Install Required Packages (only skip if not run for the first time)" "scripts/required_packages"
run_step "Install Desktop" "scripts/desktop.sh"
run_step "Copy Desktop Configs" "scripts/deploy_desktop.sh"
run_step "Install Utils" "scripts/utils.sh"
run_step "Copy Util Configs" "scripts/deploy_utils"
run_step "Install VSCode with Extensions" "scripts/code.sh"
run_step "Install Spotify & Spicetify" "scripts/spicetify.sh"

# Banner
echo -e "${GREEN}"
figlet "Done"
echo -e "${NONE}"