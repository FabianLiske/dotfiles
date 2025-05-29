#!/bin/bash
set -euo pipefail

#############
### SETUP ###
#############

# Path Vars
SRC="$HOME/dotfiles/configs"
CONF="$HOME/.config"

# Ensure target directory
mkdir -p "$CONF"

###############
### DESKTOP ###
###############

# Hypr
ln -sf "$SRC/desktop/hypr" "$CONF/hypr"

# Wallpapers
ln -sf "$SRC/desktop/wallpaper" "$CONF/wallpaper"

# Waybar
ln -sf "$SRC/desktop/waybar" "$CONF/waybar"

# Wofi
ln -sf "$SRC/desktop/wofi" "$CONF/wofi"

##############
### EDITOR ###
##############

##################
### MONITORING ###
##################

# btop
ln -sf "$SRC/monitoring/btop" "$CONF/btop"

# Fastfetch
ln -sf "$SRC/monitoring/fastfetch" "$CONF/fastfetch"

#############
### SHELL ###
#############

# bashrc
ln -sf "$SRC/shell/.bashrc" "$HOME/.bashrc"

# git
ln -sf "$SRC/shell/.gitconfig" "$HOME/.gitconfig"

# Starship
ln -sf "$SRC/shell/starship.toml" "$CONF/starship.toml"

################
### TERMINAL ###
################

# Kitty
ln -sf "$SRC/terminal/kitty" "$CONF/kitty"