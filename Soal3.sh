#!/bin/bash

for ((i=1;i<=28;i++))
do
	wget -a wget.log https://loremflickr.com/320/240/cat
	mv "cat" "pdkt_kusuma_$i"
done

