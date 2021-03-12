#!/bin/bash
#
# Usage: To either add or remove a (test) user for 
#        running tests within a VM.
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

echo -n "Would you like to [a]dd a user or [d]elete a user?: "
read make
if [ $make == a ]
then
    echo -n "Enter the username and press [ENTER]: "
    read name
    sudo useradd -m $name
    sudo passwd $name
    sudo usermod -aG wheel $name
elif [ $make == d ]
then
    echo -n "Enter the username and press [ENTER]: "
    read name
    sudo userdel -fr $name
else 
    echo "Wrong input!"
fi