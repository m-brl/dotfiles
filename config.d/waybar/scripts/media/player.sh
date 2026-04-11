#!/usr/bin/env bash

title=$((playerctl metadata --format '{{title}}' || echo "No media found") | sed -e 's/&/&amp;/g')
[[ ${#title} -gt 20 ]] && title="${title:0:17}..."
artist=$((playerctl metadata --format '{{artist}}' || echo "No artist") | sed -e 's/&/&amp;/g')
[[ ${#artist} -gt 20 ]] && artist="${artist:0:17}..."
printf " 󰝚 %s - %s " "$title" "$artist"
