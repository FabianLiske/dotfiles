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

# make yay faster - do not use compression
sudo sed -i "s/PKGEXT=.*/PKGEXT='.pkg.tar'/g" /etc/makepkg.conf
sudo sed -i "s/SRCEXT=.*/SRCEXT='.src.tar'/g" /etc/makepkg.conf



# Hyprland packages
# TODO: separate out groups of packages into individual files

echo -e "${GREEN}"
figlet "Hyprland"
echo -e "${NONE}"

sudo pacman -Sy \
    brightnessctl \
    chromium \
    hyprland \
    hyprland-qtutils \
    hyprlock \
    hypridle \
    hyprpaper \
    kitty \
    libnotify \
    mako \
    networkmanager \
    network-manager-applet \
    pavucontrol \
    pipewire \
    pipewire-pulse \
    playerctl \
    qt5-wayland \
    qt6-wayland \
    sddm \
    starship \
    thunar \
    thunar-archive-plugin \
    thunar-volman \
    waybar \
    wireplumber \
    wl-clipboard \
    wofi \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    xorg-xwayland \
    --noconfirm

yay -S \
    catppuccin-cursors-macchiato \
    wlogout \
    --noconfirm

sudo systemctl enable NetworkManager
sudo systemctl enable sddm

# cleanup
echo -e "${GREEN}"
figlet "Cleanup"
echo -e "${NONE}"
sudo pacman -Rns $(pacman -Qtdq) --noconfirm
yay -Sc --noconfirm

echo -e "${GREEN}"
figlet "Done"
echo -e "${NONE}"

echo
echo "DONE! Please reboot your system!"
