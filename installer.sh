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
    bash "$SCRIPT_DIR/scripts/install/required_packages.sh"
    bash "$SCRIPT_DIR/scripts/deploy/deploy_ssh.sh"
    bash "$SCRIPT_DIR/scripts/install/desktop.sh"
    bash "$SCRIPT_DIR/scripts/deploy/deploy_desktop.sh"
    bash "$SCRIPT_DIR/scripts/install/utils.sh"
    bash "$SCRIPT_DIR/scripts/deploy/deploy_utils.sh"
    bash "$SCRIPT_DIR/scripts/misc/chromium.sh"
    bash "$SCRIPT_DIR/scripts/install/dev_tools.sh"
    #bash "$SCRIPT_DIR/scripts/misc/work.sh"
    bash "$SCRIPT_DIR/scripts/misc/spicetify.sh"
    bash "$SCRIPT_DIR/scripts/misc/pwa.sh"
    bash "$SCRIPT_DIR/scripts/install/user_apps.sh"
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
run_step "Install Required Packages (only skip if not run for the first time)" "scripts/install/required_packages.sh"
run_step "Deploy SSH Key" "scripts/deploy/deploy_ssh.sh"
run_step "Install Desktop" "scripts/install/desktop.sh"
run_step "Copy Desktop Configs" "scripts/deploy/deploy_desktop.sh"
run_step "Install Utils" "scripts/install/utils.sh"
run_step "Copy Util Configs" "scripts/deploy/deploy_utils.sh"
run_step "Install Chromium" "scripts/misc/chromium.sh"
run_step "Install Dev Tools" "scripts/install/dev_tools.sh"
#run_step "Install Work related Apps" "scripts/misc/work.sh"
run_step "Install Spotify & Spicetify" "scripts/misc/spicetify.sh"
run_step "Install PWAs" "scripts/misc/pwa.sh"
run_step "Install user apps" "scripts/install/user_apps.sh"

# Banner
echo -e "${GREEN}"
figlet "Done"
echo -e "${NONE}"
