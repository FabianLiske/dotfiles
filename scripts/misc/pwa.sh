set -euo pipefail

##################
### ROOT CHECK ###
##################

if [ "$(id -u)" = 0 ]; then
    echo ":: This script shouldn't be run as root."
    exit 1
fi

mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"

echo "Setup Teams"
cp "$HOME/dotfiles/configs/apps/teams/teams-pwa.desktop" "$HOME/.local/share/applications/teams-pwa.desktop"

echo "Setup ArchRepo"
cp "$HOME/dotfiles/configs/apps/arch-repos/archrepo.desktop" "$HOME/.local/share/applications/archrepo.desktop"
cp "$HOME/dotfiles/configs/apps/arch-repos/archlinux.png" "$HOME/.local/share/icons/archlinux.png"

gtk-update-icon-cache ~/.local/share/icons