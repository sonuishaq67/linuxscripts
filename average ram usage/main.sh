#!/bin/bash
x=0
y=0
avg=0
temp=$(neofetch | grep Memory | cut -c39- | cut -d "M" -f1)
	y=$((y + temp))
	$((x++)) 
	avg= $((y / x)) 
echo $avg
