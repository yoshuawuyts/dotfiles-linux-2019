#!/bin/sh

clr_white='%{F#2d2d2d}'
clr_black='%{F#d3c0c8}'
clr_bg_white='%{B#2d2d2d}'
clr_bg_black='%{B#d3c0c8}'

tmux ls > /dev/null 2>&1
if [ $? -eq 0 ]; then
  session_name="$(tmux display-message -p '#S')"
  windows="$(tmux list-windows -F '#{window_index}')"
  window_number="$(tmux display-message -p '#I')"

  printf "%s    " "$session_name"
  for n in $windows; do
    if [ "$n" = "$window_number" ]; then
      printf "%s%s  %s  " "$clr_bg_black" "$clr_white" "$n"
    else
      printf "%s%s  %s  " "$clr_bg_white" "$clr_black" "$n"
    fi
  done
else
  printf 'tmux offline'
fi
