#!/bin/bash
#
# Usage: Check if an application s currently running
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

read -p "Which appliction would you like to check? : " application

if pgrep -x $application > /dev/null
then
    echo
    echo -e "$application is running!"
else    
    echo
    echo -e "$application is not running!"
fi
