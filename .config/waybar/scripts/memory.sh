#!/bin/bash

res=$(free -m | grep Mem)

total=$(echo $res | awk '{print $2}')
total=$(printf "%.1f" $(bc -l <<< "($total) / 1024"))

used=$(echo $res | awk '{print $3}')
used=$(printf "%.1f" $(bc -l <<< "($used) / 1024"))

free=$(echo $res | awk '{print $4}')
free=$(printf "%.1f" $(bc -l <<< "($free) / 1024"))

cached=$(echo $res | awk '{print $6}')
cached=$(printf "%.1f" $(bc -l <<< "($cached) / 1024"))

total_used=$(printf "%.1f" $(bc -l <<< "($used + $cached)"))

text="${used}G/${total}G"
tooltip=$(echo -e "Used: ${used}G\nCached: ${cached}G\nFree: ${free}G")


jq --unbuffered --compact-output -n \
  --arg text "$text" \
  --arg tooltip "$tooltip" \
  '{
      "text": $text,
      "tooltip": $tooltip
  }'
