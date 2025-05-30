#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"

# Environment Variables
export PATH=$PATH:/home/faba/.spicetify
export XCURSOR_THEME=catppuccin-macchiato-lavender-cursors
export XCURSOR_SIZE=24

# Aliases
alias dc="cd .."