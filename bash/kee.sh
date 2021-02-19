#!/bin/bash
#
# Usage: Update Kee
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

cd $HOME/Documents/Kee/ || return
git pull  
keepassxc &
disown &&
exit

# Closing the terminal does not work yet!
# Have to search for a way to do this...