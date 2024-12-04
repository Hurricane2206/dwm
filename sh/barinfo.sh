#! /bin/bash

bl_level=$(cat /sys/class/backlight/nvidia_0/brightness)
bat_level=$(cat /sys/class/power_supply/BAT0/capacity)
volume_lvl=$(pulsemixer --get-volume | awk '{print $1}')
if [[ "$(pulsemixer --get-mute)" == "true" ]]; then
	volume_mute=true
elif [[ "$(pulsemixer --get-mute)" == "false" ]]; then
	volume_mute=false
fi
date=$(date | awk '{print $1, $2, $3, "|", $6}')
time=$(date | awk '{print $4, $5}')

while [ true ]; do
	while [ "$time" = "$(date | awk '{print $4, $5}')" ]; do
		if [ $bl_level -ne $(cat /sys/class/backlight/nvidia_0/brightness) ]; then
			break
		elif [ $volume_lvl -ne $(pulsemixer --get-volume | awk '{print $1}') ]; then
			break
		fi
		if [ "$volume_mute" != "$(pulsemixer --get-mute)" ]; then
			break
		fi
		sleep 0.1
	done
	bl_level=$(cat /sys/class/backlight/nvidia_0/brightness)
	if [ $bl_level -le 16 -a $bl_level -ge 0 ]; then
		bl_ico="󰃜 "
	elif [ $bl_level -le 30 -a $bl_level -gt 16 ]; then
		bl_ico="󰃛 "
	elif [ $bl_level -le 44 -a $bl_level -gt 16 ]; then
		bl_ico="󰃚 "
	elif [ $bl_level -le 58 -a $bl_level -gt 16 ]; then
		bl_ico="󰃝 "
	elif [ $bl_level -le 72 -a $bl_level -gt 16 ]; then
		bl_ico="󰃞 "
	elif [ $bl_level -le 86 -a $bl_level -gt 16 ]; then
		bl_ico="󰃟 "
	elif [ $bl_level -le 30 -a $bl_level -gt 16 ]; then
		bl_ico="󰃠 "
	fi
	bat_level=$(cat /sys/class/power_supply/BAT0/capacity)
	if [ $bat_level -le 25 -a $bat_level -gt 5 ]; then
		bat_ico=" "
	elif [ $bat_level -le 50 -a $bat_level -gt 25 ]; then
		bat_ico=" "
	elif [ $bat_level -le 75 -a $bat_level -gt 50 ]; then
		bat_ico=" "
	elif [ $bat_level -le 100 -a $bat_level -gt 75 ]; then
		bat_ico=" "
	else
		bat_ico=" "
	fi
	volume_lvl=$(pulsemixer --get-volume | awk '{print $1}')
	volume_mute=$(pulsemixer --get-mute)
	if [ $volume_lvl -le 10 -a $volume_lvl -ge 0 ]; then
		if [ $volume_mute = true ]; then
			volume_ico=" "
		else
			volume_ico=" "
		fi
	elif [ $volume_lvl -gt 10 -a $volume_lvl -le 50 ]; then
		if [ $volume_mute = true ]; then
			volume_ico=" "
		else
			volume_ico=" "
		fi
	elif [ $volume_lvl -gt 50 ]; then
		if [ $volume_mute = true ]; then
			volume_ico=" "
		else
			volume_ico=" "
		fi
	fi
	date=$(date | awk '{print $1, $2, $3, " ", $6}')
	time=$(date | awk '{ print $4, $5 }')
	xsetroot -name "󰇙  $volume_ico $volume_lvl%  󰇙  $bl_ico$bl_level%  󰇙  $date  󰇙  $time  󰇙  $bat_ico $bat_level%  󰇙"
done
