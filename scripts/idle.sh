#!/usr/bin/env bash

exec swayidle -w \
    timeout 300 'gtklock -d -s "$HOME/.config/gtklock/style.css"' \
    timeout 301 'niri msg action power-off-monitors' \
    before-sleep 'gtklock -d -s "$HOME/.config/gtklock/style.css"'
