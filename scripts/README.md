# Installation and Deployment Scripts

## Install

| Script | Purpose |
| --- | --- |
| [required_packages.sh](/scripts/install/required_packages.sh) | Installs packages required for the other installation scripts |
| [desktop.sh](/scripts/install/desktop.sh) | Installs packages for the desktop environment |
| [utils.sh](/scripts/install/utils.sh) | Installs terminal utils |
| [dev_tools.sh](/scripts/install/dev_tools.sh) | Installs development tools and VS Code with extensions and settings |
| [user_apps.sh](/scripts/install/user_apps.sh) | Installs user applications |

## Deploy

| Script | Purpose |
| --- | --- |
| [deploy_ssh.sh](/scripts/deploy/deploy_ssh.sh) | Decrypts and copies the SSH key |
| [deploy_desktop.sh](/scripts/deploy/deploy_desktop.sh) | Copies configuration files for the desktop |
| [deploy_utils.sh](/scripts/deploy/deploy_utils.sh) | Copies configuration files for terminal utils |

## VPN Stuff
```bash
sudo visudo -f /etc/sudoers.d/waybar-wg
```
Then set 
```
faba ALL=(root) NOPASSWD: /usr/bin/systemctl start wg-quick@mullvad.service, /usr/bin/systemctl stop wg-quick@mullvad.service
```
Then copy this script and set perms

```bash
mkdir -p "$HOME/.local/bin"
cp ./configs/network/* ~/.local/bin/
chmod +x ~/.local/bin/vpnctl ~/.local/bin/vpnstatus
```


## Misc

| Script | Purpose |
| --- | --- |
| [chromium.sh](/scripts/misc/chromium.sh) | Installs Chromium with extensions and applies settings |
| [spicetify.sh](/scripts/misc/spicetify.sh) | Installs Spotify and Spicetify and copies the theme files |
| [pwa.sh](/scripts/misc/pwa.sh) | Sets up Progressive Web Apps |
| [work.sh](/scripts/misc/work.sh) | Currently unused |

## To Do

- [x] Move application lists to separate files for easier maintenance

