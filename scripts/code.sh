#!/bin/bash
set -euo pipefail

# Download
wget -O "/tmp/icons.vsix" "https://open-vsx.org/api/Catppuccin/catppuccin-vsc-icons/1.21.0/file/Catppuccin.catppuccin-vsc-icons-1.21.0.vsix"
wget -O "/tmp/theme.vsix" "https://open-vsx.org/api/Catppuccin/catppuccin-vsc/3.17.0/file/Catppuccin.catppuccin-vsc-3.17.0.vsix"

code --install-extension "/tmp/icons.vsix"
code --install-extension "/tmp/theme.vsix"