#! /usr/bin/zsh

value=$(($(cat /sys/class/backlight/nvidia_0/brightness)-2))
min=0

if [ $value -ge $min ]
then
  brightnessctl s $value
fi
