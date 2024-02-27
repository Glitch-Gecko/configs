#!/bin/bash
sleep $1
swww init & swww img /home/nicolas/.config/hypr/wallpapers/$2 && echo $wallpaper > /tmp/current_wall
hyprctl keyword windowrule "workspace unset,firefox"
sleep 1
hyprctl keyword windowrule "workspace unset,kitty"
~/.config/hypr/easyrp
