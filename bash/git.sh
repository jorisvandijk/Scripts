#!/bin/bash
#
# Usage: Automate pushing files to GitLab with git.
#        Bash variant after the Python one.
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

C='\033[1;35m' # Color
NC='\033[0m'   # No Color

# List all git status 
echo -e "\n${C}Dotfiles${NC}"
cd ~/Dotfiles/ && git status

echo -e "\n${C}Scripts${NC}"
cd ~/Scripts/ && git status

echo -e "\n${C}Kee${NC}"
cd ~/Documents/Kee/ && git status

echo -e "\n${C}Wallpapers${NC}"
cd ~/Pictures/wallpapers/ && git status

echo -e "\n${C}Notes${NC}"
cd ~/Documents/Notes/ && git status

echo -e "\n${C}FreeTube${NC}"
cd ~/.config/FreeTube/ && git status

echo
read -n 1 -s -r -p "Press any key to continue, or CTRL+C to cancel."

# Create a menu with options
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Gitlab.com/jorisvndijk"
TITLE="Push changes"
MENU="Which repository would you like to edit? :"

OPTIONS=(1 "Dotfiles"
         2 "Scripts"
         3 "Kee"
         4 "Notes"
         5 "Wallpapers"
         6 "FreeTube")

CHOICE=$(dialog --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

case $CHOICE in
        1)
            echo "You chose Option 1"
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;
esac
