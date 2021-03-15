#!/bin/bash
#
# Usage: Automate pushing files to Git repositories
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# Test if file is present
check(){
    FILE=$1
    if [[ -f "$FILE" ]]; then
        echo
    else
    echo "$1 is missing. Aborting!"; exit
    fi 
}

status(){
while read p; do
    echo -e "\e[32m$(basename -s .git `git config --get remote.origin.url`)\033[0m" 
    cd $HOME/$p && git status
    echo
done <repositories
}

changes(){
    PS3="Enter a number: "

    select character in Sheldon Leonard Penny Howard Raj
    do
        echo "Selected character: $character"
        echo "Selected number: $REPLY"
    done
}



check repositories 
#get_repos
changes
