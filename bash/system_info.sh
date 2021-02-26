#!/bin/bash
#
# Usage: Notify-send current system info, called from the
#        i3 config file by bindsym.
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

notify-send -u critical -t 10000 "$(
    date;
    echo;
    acpi;
    echo;
    echo "Free memory:"; 
    free -h | grep Mem | awk '{print $4}';
    echo;
    echo "Free space:";
    df -h | grep /dev/nvme0n1p2 | awk '{print $4}';
    echo;
    echo "Connected to:";
    iwgetid -r
    )" 