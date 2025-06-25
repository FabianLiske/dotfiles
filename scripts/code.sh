#!/bin/bash
set -euo pipefail

# Dependency check
for cmd in curl jq figlet yay; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "ERROR: '$cmd' not found. Please install it first."; exit 1;
  }
done

# Colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Banner: Packages
echo -e "${GREEN}"
figlet "Packages"
echo -e "${NONE}"

# Base packages for building AUR packages
sudo pacman -Sy --noconfirm --needed base-devel git

# Install proprietary VS Code from AUR
yay -Sy --noconfirm --needed visual-studio-code-bin

# Banner: Code Extensions
echo -e "${GREEN}"
figlet "Code Extensions"
echo -e "${NONE}"

# Extensions to install (Marketplace IDs)
EXTENSIONS=(
  "catppuccin.catppuccin-vsc-icons"
  "catppuccin.catppuccin-vsc"
  "ms-azuretools.vscode-docker"
  "ms-vscode-remote.remote-containers"
)

NUM_EXT=${#EXTENSIONS[@]}
COUNT=0

for EXT in "${EXTENSIONS[@]}"; do
  ((COUNT++))
  echo "Installing extension $COUNT/$NUM_EXT: $EXT"
  code --install-extension "$EXT" --force
done

echo "✅ All extensions installed."

# Banner: Config
echo -e "${GREEN}"
figlet "Config"
echo -e "${NONE}"

# Copy user settings
TARGET_DIR="$HOME/.config/Code/User"
mkdir -p "$TARGET_DIR"
cp "$HOME/dotfiles/configs/apps/vscode/settings.json" "$TARGET_DIR/settings.json"

echo "🎉 Done — enjoy coding with VS Code!"
