#!/usr/bin/env bash
notify-send --urgency=CRITICAL "Started battery listener"
while true; do
  bat_lvl=$(cat /sys/class/power_supply/BAT0/capacity)
  if [ "$bat_lvl" -le 15 ]; then
    notify-send --urgency=CRITICAL -t 30000 "Battery Low" "Level: ${bat_lvl}%" # 30 Seconds
    sleep 320 # Wait 5 minutes
  else
    sleep 180 # 3 minutes
  fi
done
