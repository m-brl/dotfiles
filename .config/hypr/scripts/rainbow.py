#!/usr/bin/env python3
import subprocess
import time

delay = 1

def set_border_color(lcolor_hex, rcolor_hex, angle):
    subprocess.run([
        'hyprctl', 'keyword', 'general:col.active_border', f'rgba({lcolor_hex}) rgba({rcolor_hex}) {angle}deg'
    ])
    print(angle)

try:
    while True:
        angle = (time.time() % 60) * 6
        set_border_color("33ccffee", "ff6677ee", angle)
        time.sleep(delay)
except KeyboardInterrupt:
    pass
