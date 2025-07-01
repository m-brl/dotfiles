#!/bin/bash

led=`cat /sys/class/leds/input3::capslock/brightness`

if [ $led -eq 0 ]; then
    notify-send "Caps Lock" "Caps Lock is off"
else
    notify-send "Caps Lock" "Caps Lock is on"
fi
