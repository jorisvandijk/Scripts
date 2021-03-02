#!/bin/bash
#
# Usage: Toggle keyboard
#
# Based on the script by mxdsp 
# https://askubuntu.com/questions/160945/is-there-a-way-to-disable-a-laptops-internal-keyboard
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# DO NOT RUN WITHOUT A WAY TO RE-ENABLE THE KEYBOARD i.e. external keyboard! 

fconfig=".keyboard" 
id=15 # use "xinput list" to find the keyboard id

if [ ! -f $fconfig ];
    then
        echo "Creating config file"
        echo "enabled" > $fconfig
        var="enabled"
    else
        read -r var< $fconfig
        echo "keyboard is : $var"
fi

if [ $var = "disabled" ];
    then
        notify-send -i $Icon "Enabling keyboard" \ "Internal keyboard is on";
        echo "enable keyboard"
        xinput enable $id
        echo "enabled" > $fconfig
    elif [ $var = "enabled" ]; then
        notify-send -i $Icoff "Disabling Keyboard" \ "Internal keyboard is off";
        echo "disable keyboard"
        xinput disable $id
        echo 'disabled' > $fconfig
fi