#! /usr/bin/zsh

volume_lvl=$(pulsemixer --get-volume | awk '{ print $1 }')
if [ $(pulsemixer --get-mute) = 1 ]; then
  volume_mute=1
elif [ $(pulsemixer --get-mute) = 0 ]; then
  volume_mute=0
fi
date=$(date | awk '{print $1, $2, $3, "|", $7}')
time=$(date | awk '{ print $4 }')

while [ 1 ]; do
  while [ "$time" = "$(date | awk '{ print $4 }')" ]; do
    if [ $volume_lvl -ne $(pulsemixer --get-volume | awk '{ print $1 }') ]; then
      break
    elif [ $volume_mute -ne $(pulsemixer --get-mute) ]; then
      break
    fi
    sleep 0.1
  done
  volume_lvl=$(pulsemixer --get-volume | awk '{ print $1}')
  volume_mute=$(pulsemixer --get-mute)
  if [ $volume_lvl -le 10 -a $volume_lvl -ge 0 ]; then
    if [ $volume_mute = 1 ]; then
      volume_ico=" "
    else
      volume_ico=" "
    fi
  elif [ $volume_lvl -gt 10 -a $volume_lvl -le 50 ]; then
    if [ $volume_mute = 1 ]; then
      volume_ico=" "
    else
      volume_ico=" "
    fi
  elif [ $volume_lvl -gt 50 ]; then
    if [ $volume_mute = 1 ]; then
      volume_ico=" "
    else
      volume_ico=" "
    fi
  fi
  date=$(date | awk '{print $1, $2, $3, " ", $6}')
  time=$(date | awk '{ print $4 }')
  xsetroot -name "󰇙  $volume_ico $volume_lvl%  󰇙  $date  󰇙  $time  󰇙"
done
