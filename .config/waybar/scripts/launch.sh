#!/bin/bash

waybar -c $HOME/.config/waybar/primary/config.jsonc -s $HOME/.config/waybar/primary/style.css &> /dev/null &!
waybar -c $HOME/.config/waybar/secondary/config.jsonc -s $HOME/.config/waybar/secondary/style.css &> /dev/null &!
