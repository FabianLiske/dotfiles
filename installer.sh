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

# Schritt 1: Komplettinstallation anbieten
echo
read -p ">> Run all scripts? [y/N] " all

if [[ "$all" =~ ^[YyJj] ]]; then
    echo -e "\nStart Full Installation ..."
    bash "$SCRIPT_DIR/scripts/required_packages.sh"
    bash "$SCRIPT_DIR/scripts/desktop.sh"
    bash "$SCRIPT_DIR/scripts/deploy_desktop.sh"
    bash "$SCRIPT_DIR/scripts/utils.sh"
    bash "$SCRIPT_DIR/scripts/deploy_utils.sh"
    bash "$SCRIPT_DIR/scripts/chromium.sh"
    bash "$SCRIPT_DIR/scripts/code.sh"
    bash "$SCRIPT_DIR/scripts/work.sh"
    #bash "$SCRIPT_DIR/scripts/spicetify.sh"
    echo -e "\nFull Installation done. Reboot."
    exit 0
fi

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
run_step "Install Required Packages (only skip if not run for the first time)" "scripts/required_packages.sh"
run_step "Install Desktop" "scripts/desktop.sh"
run_step "Copy Desktop Configs" "scripts/deploy_desktop.sh"
run_step "Install Utils" "scripts/utils.sh"
run_step "Copy Util Configs" "scripts/deploy_utils.sh"
run_step "Install Chromium" "scripts/chromium.sh"
run_step "Install VSCode with Extensions" "scripts/code.sh"
run_step "Install Work related Apps" "scripts/work.sh"
#run_step "Install Spotify & Spicetify" "scripts/spicetify.sh"

# Banner
echo -e "${GREEN}"
figlet "Done"
echo -e "${NONE}"
