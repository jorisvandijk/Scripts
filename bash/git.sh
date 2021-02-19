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
echo -e "\n${C}Scripts${NC}"
cd ~/Scripts/ && git status

echo -e "\n${C}FreeTube${NC}"
cd ~/.config/FreeTube/ && git status

echo -e "\n${C}Wallpapers${NC}"
cd ~/Pictures/wallpapers/ && git status

echo -e "\n${C}Dotfiles${NC}"
cd ~/Dotfiles/ && git status

echo -e "\n${C}Notes${NC}"
cd ~/Documents/Notes/ && git status

echo -e "\n/home/joris/Documents/Kee/${C}Kee${NC}"
cd ~/Documents/Kee/ && git status

# Create a menu with options

# THE FOLLOWING DOES NOT WORK YET AND I AM TOO DRUNK TO FIX IT NOW
PS3='Which  repository would you like to update? : '
options=("1. Scripts" "2. Freetube" "3. Wallpapers" "4. Dotfiles" "5. Notes" "6. Kee" "quit")
select option in "${options[@]}"; do
    case $option in
        "1")
            FOLDER="$HOME/Scripts/"
            ;;
        "2")
            FOLDER="$HOME/.config/FreeTube/"
            ;;
        "3")
            FOLDER="$HOME/Pictures/wallpapers/"
            ;;
        "4")
            FOLDER="$HOME/Dotfiles"
            ;;
        "5")
            FOLDER="$HOME/Documents/Notes/"
            ;;
        "6")
            FOLDER="$HOME/Documents/Kee/"
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done
cd $folder
git status
PS3='What would you like to commit? : '
options=("All files" "Modified files" "A Specific file")
select option in "${options[@]}"; do
    case $option in
        "1")
            FOLDER="$HOME/Scripts/"
            ;;
        "2")
            FOLDER="$HOME/.config/FreeTube/"
            ;;
        "3")
            FOLDER="$HOME/Pictures/wallpapers/"
            ;;
        "4")
            FOLDER="$HOME/Dotfiles"
            ;;
        "5")
            FOLDER="$HOME/Documents/Notes/"
            ;;
        "6")
            FOLDER="$HOME/Documents/Kee/"
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done
