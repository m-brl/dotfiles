#!/usr/bin/env bash

title=$(playerctl metadata --format '{{title}}'  || echo "No media found" | sed -e 's/&/&amp;/g')
artist=$(playerctl metadata --format '{{artist}}' || echo "No artist" | sed -e 's/&/&amp;/g')
printf " 󰝚 %s %s - %s " "${frames[$index]}" "$title" "$artist"
