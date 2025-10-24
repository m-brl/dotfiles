#!/bin/bash

mode="$1"
if [[ -z "$mode" ]]; then
    mode="auto"
fi

case "$mode" in
    "day")
        swww img $HOME/.config/sway/assets/background_day.jpg
    ;;
    "night")
        swww img $HOME/.config/sway/assets/background_night.jpg
    ;;
    "auto")
        hour=$((10#$(date +%H)))
        if [[ $hour -ge 8 && $hour -lt 21 ]]; then
            swww img $HOME/.config/sway/assets/background_day.jpg
        else
            swww img $HOME/.config/sway/assets/background_night.jpg
        fi
    ;;
    *)
    echo -e "\033[31mInvalid mode\033[0m"
esac
