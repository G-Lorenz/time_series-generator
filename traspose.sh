#!/usr/bin/bash

for i in active confirmed deaths recovered
do
	for ts in ../covid19-time_series/rows/$i/*
	do
		title=$(echo $ts | sed 's/rows/cols/g')
		./traspose.awk $ts > $title
	done
done
