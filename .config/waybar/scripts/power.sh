#!/bin/bash

echo -e "scale=3\n$(cat /sys/class/power_supply/BAT0/power_now).0 / 1000000.0" | bc -l
