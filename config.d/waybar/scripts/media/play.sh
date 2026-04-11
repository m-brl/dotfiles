#!/usr/bin/env bash

status=$(playerctl status)
if [[ "$status" == "Paused" ]]; then
    echo ' 󰐎 '
else
    echo ' 󰏤 '
fi
