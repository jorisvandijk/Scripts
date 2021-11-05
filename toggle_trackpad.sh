#!/bin/bash

device=18
state=`xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$"`

if [ $state == '1' ];then
    xinput --disable $device && notify-send -i emblem-nowrite "Touchpad" "Disabled"
else
    xinput --enable $device && notify-send -i input-touchpad "Touchpad" "Enabled"
fi
