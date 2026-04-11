#!/usr/bin/env bash

dnd=$(swaync-client -D)
if [[ "$dnd" == "true" ]]; then
    echo " <span color='#cba6f7'>󱏧</span> "
    exit 0
fi

status=$(swaync-client -c)
if [[ "$status" -eq 0 ]]; then
    echo " <span color='#cba6f7'>󰂚</span> "
else
    echo " <span color='#cba6f7'>󱅫</span> "
fi
