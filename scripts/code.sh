#!/usr/bin/env bash
set -euo pipefail

# Dependencies: curl, jq, figlet, yay
for cmd in curl jq figlet yay; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "ERROR: '$cmd' not found. Please install it first."; exit 1;
  }
done

# Colors
GREEN='\033[0;32m'; NONE='\033[0m'
info(){ echo -e "${GREEN}→${NONE} $*"; }

#–– Install base packages ––
info "Packages"
figlet "Packages"
info "Installing base-devel & git…"
sudo pacman -Sy --noconfirm --needed base-devel git

#–– Install VS Code ––
info "VS Code"
figlet "VS Code"
info "Installing proprietary VS Code…"
yay -Sy --noconfirm --needed visual-studio-code-bin

# Refresh shell so `code` is immediately available
hash -r

# Verify `code` CLI
if ! command -v code >/dev/null 2>&1; then
  echo "ERROR: 'code' CLI not found after installation." >&2
  exit 1
fi

#–– Extensions ––
EXTENSIONS=(
  "catppuccin.catppuccin-vsc-icons"
  "catppuccin.catppuccin-vsc"
  "ms-azuretools.vscode-docker"
  "ms-vscode-remote.remote-containers"
)

info "Extensions"
figlet "Extensions"
COUNT=0
for EXT in "${EXTENSIONS[@]}"; do
  COUNT=$((COUNT+1))
  info "Installing [$COUNT/${#EXTENSIONS[@]}]: $EXT"
  code --install-extension "$EXT" --force \
    || echo "WARNING: failed to install $EXT"
done

#–– Copy user settings ––
info "Config"
figlet "Config"
TARGET_DIR="$HOME/.config/Code/User"
mkdir -p "$TARGET_DIR"
cp "$HOME/dotfiles/configs/apps/vscode/settings.json" "$TARGET_DIR/settings.json"

info "Done."  
