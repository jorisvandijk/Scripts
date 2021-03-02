#!/bin/bash
#
# Usage: Notify-send current system info, called from the
#        i3 config file by bindsym.
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

if [[ $(cd $HOME/Scripts/; git status --porcelain) ]]; then one="Scripts " 
fi
if [[ $(cd $HOME/Dotfiles/; git status --porcelain) ]]; then two="Dotfiles " 
fi
if [[ $(cd $HOME/Documents/Kee/; git status --porcelain) ]]; then three="Kee " 
fi
#if [[ $(cd $HOME/.config/FreeTube/; git status --porcelain) ]]; then four="FreeTube " 
#fi
if [[ $(cd $HOME/Pictures/wallpapers/; git status --porcelain) ]]; then five="Wallpapers " 
fi
if [[ $(cd $HOME/Documents/Notes/; git status --porcelain) ]]; then six="Notes " 
fi

repo=$one$two$three$five$six

notify-send -u critical -t 15000 "$(
    echo $(date +"%A %-d %B %Y"; echo " - "; date +"%R")
    echo
    echo $(echo "Battery at"; acpi | awk '{print substr($4, 1, length($4)-1)}')
    echo
    list=$(checkupdates)
    if [[ $list = "" ]]; then
        echo $(pacman -Qq | wc -l; echo "packages installed and no updates")
    else
        IFS=$'\n'
    for i in $list
    do
        pacnum=$((pacnum+1))
    done
    if [[ $pacnum -eq 1 ]]; then
        echo $(pacman -Qq | wc -l; echo -e "packages installed with $pacnum update!")
    else
        echo $(pacman -Qq | wc -l; echo -e "packages installed with $pacnum updates!")
    fi
    fi
    echo
    if [[ $repo ]]; then
        echo -e "Repository changes in $repo"
    else 
        echo "All repositories are up to date!"
    fi
    echo
    echo $(df -h | grep /dev/nvme0n1p2 | awk '{print $4}'; echo " free space")
    echo $(free -h | grep Mem | awk '{print $4}'; echo " free memory")
    echo
    echo $(echo "Connected to"; iwgetid -r;)
    echo
    spotify=$(python $HOME/Scripts/python/spotify.py)
    if [[ $spotify = "" ]]; then
        echo "No song is currently playing"
    else
        echo $(echo "Listening to "; echo "$spotify")
    fi 
)"
