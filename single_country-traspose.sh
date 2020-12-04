#!/usr/bin/bash

country=$1
for i in active confirmed deaths recovered
do
	ts="../covid19-time_series/rows/$i/time_series_covid_19_${i}_$country.csv"
	title=$(echo $ts | sed 's/rows/cols/g')
	./traspose.awk $ts > $title
done
