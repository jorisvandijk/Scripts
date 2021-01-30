#!/bin/bash
#
# Usage: Unsplash wallpaper changer
#
# Dotfile by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later             
              
KEYWORDS="painting, art"                  

case $1 in
  new)
    wget "https://source.unsplash.com/random/1920x1080/?$KEYWORDS" -4 -O "$HOME/Pictures/wallpaper.jpg"
    feh --bg-fill "$HOME/Pictures/wallpaper.jpg"
    ;;
    boot)
    sleep 2
    wget "https://source.unsplash.com/random/1920x1080/?$KEYWORDS" -4 -O "$HOME/Pictures/wallpaper.jpg"
    feh --bg-fill "$HOME/Pictures/wallpaper.jpg"
    ;;
esac