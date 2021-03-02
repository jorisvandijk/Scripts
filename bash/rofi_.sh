#!/bin/bash
#
# Usage: Test on how to make a custom Rofi menu
#
# Dotfile by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

### Options ###
OPT1="Lock"

# Variable passed to rofi
options="$OPT1\n"

chosen="$(echo -e "$options" | rofi -dmenu)"
[[ -z $chosen ]] && exit
case $chosen in
    $OPT1)
        i3lock -c 000000
        ;;
esac