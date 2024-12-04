#! /bin/bash

value=$(($(cat /sys/class/backlight/nvidia_0/brightness)+2))
max=100

if [ $value -le $max ]; then
	brightnessctl s $value
fi
