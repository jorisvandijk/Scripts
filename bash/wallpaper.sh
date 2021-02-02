#!/bin/bash
#
# Usage: Unsplash wallpaper changer
#
# Dotfile by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later           

# Add "bindsym $mod+a $e ~/Scripts/bash/wallpaper.sh new" to i3 config
# to enable changing the random Unspash wallpaper.

# Add "exec_always --no-startup-id ~/Scripts/bash/wallpaper.sh boot" to
# the i3 config to enable random Unsplah wallpaper at boot.
              
KEYWORDS="painting, art"                  

case $1 in
  new)
    wget "https://source.unsplash.com/random/1920x1080/?nature" -4 -O "$HOME/Pictures/wallpaper.jpg"
    feh --bg-fill "$HOME/Pictures/wallpaper.jpg"
    ;;
    boot)
    sleep 2
    wget "https://source.unsplash.com/random/1920x1080/?$KEYWORDS" -4 -O "$HOME/Pictures/wallpaper.jpg"
    feh --bg-fill "$HOME/Pictures/wallpaper.jpg"
    ;;
esac