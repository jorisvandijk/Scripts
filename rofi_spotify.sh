#!/bin/bash
#
# Usage: Spotify Rofi menu
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
OPT1="play/pause"
OPT2="next song"
OPT3="previous song"

# Variable passed to rofi
options="$OPT1\n$OPT2\n$OPT3"

chosen="$(echo -e "$options" | rofi -dmenu -p "Spotify")"
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