#!/bin/bash

hour=$(date +"%H")
hour=$((hour))

pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
lower=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

filename=$1
filename=$(echo $filename | tr "${lower:0:26}" "${lower:$hour:26}" | tr "${upper:0:26}" "${upper:$hour:26}")

echo $pass > $filename.txt
