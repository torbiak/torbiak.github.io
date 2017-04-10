#!/bin/bash
set -euo pipefail

terms=(
    terminator
    alacritty
    konsole-256color
    gnome-256color
    kitty
    st-256color
    xterm-256color
    vte-256color
)
for t in "${terms[@]}"; do
    setab=$(tput -T"$t" setab) || continue
    [[ "$setab" = *'%t10%p1%{8}%-%d'* ]] && bright_bg=yes || bright_bg=no
    echo "$t $bright_bg"
done
