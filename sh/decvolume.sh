#! /usr/bin/zsh

value=$(($(pulsemixer --get-volume | awk '{ print $1 }')-2))
min=0

if [ $value -ge $min ]; then
  pulsemixer --set-volume $value
fi
