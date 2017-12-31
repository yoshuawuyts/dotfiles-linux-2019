#!/bin/sh

city="Berlin"
location="638242" # berlin, someday we'll replace this with gpsd / gpspipe
uri="https://www.metaweather.com/api/location/$location/"

res="$(curl -s "$uri")"
if [ $? -ne 0 ]; then
  echo 'weather offline'
else
  weather="$(echo "$res" | jq '.consolidated_weather | .[0]')"
  state="$(echo "$weather" | jq '.weather_state_name' | sed 's/"//g')"
  temp="$(echo "$weather" | jq '.the_temp')"
  printf '%s   %.*f*   %s' "$city" 0 "$temp" "$state"
fi
