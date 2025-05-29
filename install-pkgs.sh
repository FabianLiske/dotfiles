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

#################
### FUNCTIONS ###
#################

# Check if package is installed
_isInstalledPacman() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# Install required packages
_installPackagesPacman() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            echo "${pkg} is already installed.";
            continue;
        fi;
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All pacman packages are already installed.";
        return;
    fi;
    printf "Package not installed:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

#########################
### REQUIRED PACKAGES ###
#########################

# Required packages for the installer
installer_packages=(
    "wget"
    "unzip"
    "gum"
    "figlet"
)

sudo pacman -Sy
echo

echo ":: Ensuring required packages are installed..."
_installPackagesPacman "${installer_packages[@]}";
echo

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
    waybar \
    wireplumber \
    wl-clipboard \
    wofi \
    xdg-desktop-portal-hyprland \
    xorg-xwayland \
    --noconfirm

yay -S \
    wlogout \
    catppuccin-cursors-macchiato \
    --noconfirm

echo -e "${GREEN}"
figlet "Useful Packages"
echo -e "${NONE}"

sudo pacman -Sy \
    btop \
    fastfetch \
    chromium \
    code \
    tree \
    thunar \
    thunar-archive-plugin \
    thunar-volman \
    --noconfirm

echo -e "${GREEN}"
figlet "Services"
echo -e "${NONE}"

sudo systemctl enable NetworkManager
sudo systemctl enable sddm
sudo systemctl enable sshd

#bash "$HOME/dotfiles/install-conf.sh"

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
