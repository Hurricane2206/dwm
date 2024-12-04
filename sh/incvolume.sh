#! /bin/bash

value=$(($(pulsemixer --get-volume | awk '{print $1}')+2))
max=100

if [ $value -le $max ]; then
	pulsemixer --set-volume $value
fi
