# Individual Installation Scripts

| Name | Purpose |
| --- | --- |
| [chromium.sh](/scripts/chromium.sh) | Installs Chromium with extensions and applies settings |
| [code.sh](/scripts/code.sh) | Installs VSCode and extensions and applies settings |
| [dekstop.sh](/scripts/desktop.sh) | Installs packages for the desktop environment |
| [deploy_desktop.sh](/scripts/deploy_desktop.sh) | Copies configuration files for the desktop |
| [utils.sh](/scripts/utils.sh) | Installs terminal utils |
| [deploy_utils.sh](/scripts/deploy_utils.sh) | Copies configuration files for terminal utils |
| [dev_tools.sh](/scripts/dev_tools.sh) | Installs development tools |
| [user_apps.sh](/scripts/user_apps.sh) | Installs user applciations |
| [pwa.sh](/scripts/pwa.sh) | Sets up Progressive Web Apps |
| [required_packages](/scripts/required_packages.sh) | Installs packages required for the other installation scripts |
| [spicetify.sh](/scripts/spicetify.sh) | Installs Spotify and Spicetify and copies the theme files |
| [work.sh](/scripts/work.sh) | Currently unused |

## To Do
- [ ] Move applciation lists to seperate files for easier maintenance
- [ ] Separate out scripts into direcotries by use
- [ ] Adjust README

## Notes
- The Plan:
    - Move Packages to unified lists, one for each package manager
    - The install Script just installs everything at once, the check for existing packages should not take too long