#!/bin/bash
#
# Usage: Update Kee from an i3. See i3/config
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

cd $HOME/Documents/Kee/ || return
git pull  
keepassxc &
disown &&
exit