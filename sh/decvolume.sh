#! /usr/bin/zsh

value=$(($(pamixer --get-volume)-2))
min=0

if [ $value -ge $min ]
then
  pamixer --set-volume $value
fi
