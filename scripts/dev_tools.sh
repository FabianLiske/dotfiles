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

for cmd in figlet yay; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "ERROR: '$cmd' not found. Please install it first."; exit 1;
  }
done

# make yay faster - do not use compression
sudo sed -i "s/PKGEXT=.*/PKGEXT='.pkg.tar'/g" /etc/makepkg.conf
sudo sed -i "s/SRCEXT=.*/SRCEXT='.src.tar'/g" /etc/makepkg.conf

echo -e "${GREEN}"
figlet "Dev Tooling"
echo -e "${NONE}"

PKG_FILE="$HOME/dotfiles/packages/dev_tools.txt"
mapfile -t PKGS < <(grep -Ev '^\s*#' "$PKG_FILE")
sudo pacman -Sy --noconfirm --needed "${PKGS[@]}"

AUR_FILE="$HOME/dotfiles/packages/dev_tools-yay.txt"
if [[ -f "$AUR_FILE" ]]; then
  mapfile -t AUR_PKGS < <(grep -Ev '^\s*#' "$AUR_FILE")
  yay -Sy --noconfirm --needed "${AUR_PKGS[@]}"
fi

# Refresh shell so `code` is immediately available
hash -r

# Verify `code` CLI
if ! command -v code >/dev/null 2>&1; then
  echo "ERROR: 'code' CLI not found after installation." >&2
  exit 1
fi

# VS Code extensions
EXTENSIONS=(
  "catppuccin.catppuccin-vsc-icons"
  "catppuccin.catppuccin-vsc"
  "ms-azuretools.vscode-docker"
  "ms-vscode-remote.remote-containers"
  "tomoki1207.pdf"
)

echo -e "${GREEN}"
figlet "Extensions"
echo -e "${NONE}"

COUNT=0
for EXT in "${EXTENSIONS[@]}"; do
  COUNT=$((COUNT+1))
  echo -e "${GREEN}→${NONE} Installing [$COUNT/${#EXTENSIONS[@]}]: $EXT"
  code --install-extension "$EXT" --force || echo "WARNING: failed to install $EXT"
done

# Copy user settings
echo -e "${GREEN}"
figlet "Config"
echo -e "${NONE}"
TARGET_DIR="$HOME/.config/Code/User"
mkdir -p "$TARGET_DIR"
cp "$HOME/dotfiles/configs/apps/vscode/settings.json" "$TARGET_DIR/settings.json"

sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER

# cleanup
echo -e "${GREEN}"
figlet "Cleanup"
echo -e "${NONE}"
sudo pacman -Rns $(pacman -Qtdq) --noconfirm
yay -Sc --noconfirm

echo -e "${GREEN}"
figlet "Done"
echo -e "${NONE}"

