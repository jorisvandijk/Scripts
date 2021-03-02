#!/bin/bash
#
# Usage: Test on how to make a custom Rofi menu
#
# Dotfile by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# Check if Spotify is running, if not launch it
if pgrep -x "spotify" > /dev/null
then
    echo "Running"
else
    (spotify) &
fi

### Options ###
OPT1="Play/Pause"
OPT2="Next song"
OPT3="Previous song"

# Variable passed to rofi
options="$OPT1\n$OPT2\n$OPT3"

chosen="$(echo -e "$options" | rofi -dmenu)"
[[ -z $chosen ]] && exit
case $chosen in
    $OPT1)
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
        ;;
    $OPT2)
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
        ;;
    $OPT3)
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
        ;;
esac

