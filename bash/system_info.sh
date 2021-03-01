#!/bin/bash
#
# Usage: Notify-send current system info, called from the
#        i3 config file by bindsym.
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

cd $HOME/Scripts/
if [[ $(git status --porcelain) ]]; then
    one="Scripts "
fi

cd $HOME/Dotfiles/
if [[ $(git status --porcelain) ]]; then
    two="Dotfiles "
fi

cd $HOME/Documents/Kee/
if [[ $(git status --porcelain) ]]; then
    three="Kee "
fi

cd $HOME/.config/FreeTube/
if [[ $(git status --porcelain) ]]; then
    four="FreeTube "
fi

cd $HOME/Pictures/wallpapers/
if [[ $(git status --porcelain) ]]; then
     five="Wallpapers "
fi

cd $HOME/Documents/Notes/
if [[ $(git status --porcelain) ]]; then
    six="Notes "
fi

repo=$one$two$three$four$five$six

notify-send -u critical -t 15000 "$(
    echo "Current time"
    date +"%R";
    echo
    echo "Current date"
    date +"%A %d %B %Y"
    echo
    echo "Battery"
    acpi | awk '{print $4, $5, $6, $7}'
    echo
    echo "Number of installed packages"
    pacman -Qq | wc -l
    echo
    CULIST=$(checkupdates)
    if [[ $CULIST = "" ]]; then
    echo "All packages are up to date!"
    else
    IFS=$'\n'
    for i in $CULIST
    do
    pacnum=$((pacnum+1))
    done
    echo "Number of package updates"
    echo "$pacnum"
    fi
    echo
    if [[ $repo ]]; then
    echo -e "Repository changes in\n$repo"
    else 
    echo "All repositories are up to date!"
    fi
    echo
    echo "Free memory";
    free -h | grep Mem | awk '{print $4}'
    echo
    echo "Free space";
    df -h | grep /dev/nvme0n1p2 | awk '{print $4}'
    echo
    echo "Connected to";
    iwgetid -r
    echo


    SPOTIFY=$(python $HOME/Scripts/python/spotify.py)
    if [[ $SPOTIFY = "" ]]; then
    echo "No songs currently playing"
    else
    echo "Currently playing"
    python $HOME/Scripts/python/spotify.py
    fi
    
)"
