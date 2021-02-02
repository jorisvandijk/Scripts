#!/bin/bash
#
# Usage: Will change i3 theme
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

echo
echo -e "Let's change the i3 theme!"
echo 
echo -e "[1] Nord"
echo -e "[2] test"
echo
while true; do
    read -p $'\e[35m"Which theme would you like?" \e[0m: ' theme
    case $theme in
        [1]* ) 
            cat ~/Dotfiles/i3/.config/i3/[00][01]* >~/Dotfiles/i3/.config/i3/config
            i3-msg reload
            echo
            echo "Theme set!"
            echo ; break;;
        [2]* ) 
            cat ~/Dotfiles/i3/.config/i3/[00][02]* >~/Dotfiles/i3/.config/i3/config
            i3-msg reload
            echo
            echo "Theme set!"  
            echo ; break;;          
        * ) echo 
            echo -e "That's not a theme number."
            echo ; break;;
    esac
done