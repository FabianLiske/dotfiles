#!/bin/bash
#set -euo pipefail

# Dependency Check
for cmd in curl jq figlet; do
    command -v "$cmd" >/dev/null 2>&1 || {
        echo "ERROR: '$cmd' not found. Please install it."; exit 1;
    }
done

# Colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Banner
echo -e "${GREEN}"
figlet "Packages"
echo -e "${NONE}"

sudo pacman -Sy code --noconfirm

# Banner
echo -e "${GREEN}"
figlet "Code Extensions"
echo -e "${NONE}"

# Extensions to install
EXTENSIONS=(
    "Catppuccin/catppuccin-vsc-icons"
    "Catppuccin/catppuccin-vsc"
)

NUM_EXTENSIONS=${#EXTENSIONS[@]}
COUNT=0

for EXT in "${EXTENSIONS[@]}"; do
    ((COUNT++))
    echo "Installing Extension $COUNT/$NUM_EXTENSIONS: $EXT"
    
    # Get Extensions info
    API_URL="https://open-vsx.org/api/${EXT}/latest"
    JSON=$(curl -s "$API_URL")
    
    # Get download url for latest version
    DOWNLOAD_URL=$(jq -r ".files.download" <<< "$JSON")
    
    # Replace / with - in Filename
    SANITIZED_EXT="${EXT//\//-}"
    
    # Download and install extension
    curl -L --fail -o "/tmp/$SANITIZED_EXT.vsix" "$DOWNLOAD_URL"
    code --install-extension "/tmp/$SANITIZED_EXT.vsix" --force
    
done

echo "✅ All extensions installed."

# Banner
echo -e "${GREEN}"
figlet "Config"
echo -e "${NONE}"

mkdir -p "$HOME/.config/Code - OSS/User"
cp "$HOME/dotfiles/configs/apps/vscode/settings.json" "$HOME/.config/Code - OSS/User/settings.json"