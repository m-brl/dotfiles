#!/bin/bash

led=`cat /sys/class/leds/input3::numlock/brightness`

if [ $led -eq 0 ]; then
    notify-send "Num Lock is off"
else
    notify-send "Num Lock is on"
fi
