#!/bin/bash
#
# Usage: Jorisify my fresh Arch install
#
# !!! DO NOT RUN THIS SCRIPT, IT'LL DESTROY YOUR SYSTEM!!!
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# Check directory
if [[ $PWD == $HOME/jorisify ]]; then
    echo "In correct directory."; echo
    else clear; echo "Please run this script from within the Jorisify repository directory. Aborting!"; exit
fi

# Check for pkglist.txt
FILE=pkglist.txt
if [[ -f "$FILE" ]]; then
    echo "$FILE present."; echo
    else clear; echo "pkglist.txt is missing. Aborting!"; exit
fi

# Check for pkglist_aur.txt
FILE=pkglist_aur.txt
if [[ -f "$FILE" ]]; then
    echo "$FILE present."; echo
    else clear; echo "pkglist_aur.txt is missing. Aborting!"; exit
fi

# Warn user of dangers
if dialog --stdout --title "Warning!" \
--backtitle "Jorisify" --yesno "This script does irreversable damage to your system! \
are you sure you want to continue?" 10 50; then clear
else
clear
echo "Installation aborted."
exit
fi

# Get root privileges
printf '%s\n' "$(dialog --title "Root/Sudo password" --backtitle "Jorisify" --output-fd 1 --passwordbox "Please enter root password:" 10 40)" | sudo -Svp ''
clear

# Install needed applications
sudo pacman -Syyu --noconfirm firefox xclip xfce4-terminal

nohup xfce4-terminal -e "$HOME/jorisify/bin.sh" &
killall xterm