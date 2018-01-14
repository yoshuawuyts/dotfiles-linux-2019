#!/bin/bash

BATPATH=/sys/class/power_supply/BAT0
bf="$(cat "$BATPATH/energy_full")"
bn="$(cat "$BATPATH/energy_now")"
level="$(( 100 * $bn / $bf ))"

if [ "$level" -lt 5 ]; then
  notify-send -u critical -a 'low-battery' 'Low Battery' "Battery at $level%"
elif [ "$level" -lt 15 ]; then
  notify-send -u normal -a 'low-battery' 'Low Battery' "Battery at $level%"
fi
