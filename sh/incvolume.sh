#! /usr/bin/zsh

value=$(($(pamixer --get-volume)+2))
max=100

if [ $value -le $max ]
then
  pamixer --set-volume $value
fi
