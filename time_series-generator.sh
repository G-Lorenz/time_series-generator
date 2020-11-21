#!/usr/bin/bash

olddate=$(cat date.txt) #format: YYYY-MM-DD
secdate=$(date -d $olddate +%s) #date in seconds
enddate=$(date -dyesterday +%s) #yesterday. Substitute -dyesterday with desired "YYYY-MM-DD" time string

while [ $secdate -lt $enddate ] #loop from olddate to enddate
do
	engdate=$(date -d $olddate +%m-%d-%Y) #format MM-DD-YYYY
	filename="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/$engdate.csv"
	wget $filename -O a_tmpfile
	./time_series-updater.awk a_tmpfile
#	for i in active confirmed deaths recovered
#	do
		for ts_file in ../covid19-time_series/rows/active/temp_*
		do
			cleanfile=$(echo $ts_file | sed 's/ /\\ /g')
			oldtitle=$(echo $ts_file | sed 's/temp_//g')
			country=$(echo $oldtitle | sed 's/..\/covid19-time_series\/rows\/active\/time_series_covid_19_active_//g')
			country=$(echo $country | sed 's/.csv//g')
			cleantitle=$(echo $oldtitle | sed 's/ /\\ /g')
			if [ ! -f $cleantitle ]; then
				for i in active confirmed deaths recovered
				do
					tmp_title="../covid19-time_series/rows/$i/time_series_covid_19_${i}_$country.csv"
					cleantmp_title=$(echo $tmp_title | sed 's/ /\\ /g')
					echo Admin2,Province/State,Country/Region > $cleantmp_title
				done
				awk -v country="$country" -f ./template_generator.awk a_tmpfile
			else
				if [ $(($(wc -l <"$cleantitle")-1)) -lt $(wc -l <"$cleanfile") ]; then
					for i in active confirmed deaths recovered
					do
						tmp_title="../covid19-time_series/rows/$i/time_series_covid_19_${i}_$country.csv"
						cleantmp_title=$(echo $tmp_title | sed 's/ /\\ /g')
						errtitle="$cleantmp_title-err.csv" #mantain old title (logging)
						mv "$cleantmp_title" "$errtitle"
						echo Admin2,Province/State,Country/Region > $cleantmp_title
					done
					awk -v country="$country" -f ./template_generator.awk a_tmpfile
				fi
			fi
			for i in active confirmed deaths recovered
			do
				ts_file1="../covid19-time_series/rows/$i/temp_time_series_covid_19_${i}_$country.csv"
				cleanfile=$(echo $ts_file1 | sed 's/ /\\ /g')
				echo -e "$engdate\n""$(<$cleanfile)" > $cleanfile
				cleantmp_title=$(echo $cleanfile | sed 's/temp_//g')
				paste -d, $cleantmp_title $cleanfile > paste_tmpfile
				cp paste_tmpfile $cleantmp_title
			done
		done
	#done
	olddate=$(date +%Y%m%d -d "$olddate + 1 day")
	secdate=$(date -d $olddate +%s)
done

echo $olddate > date.txt
rm ../covid19-time_series/rows/active/temp_*
rm ../covid19-time_series/rows/confirmed/temp_*
rm ../covid19-time_series/rows/deaths/temp_*
rm ../covid19-time_series/rows/recovered/temp_*
rm a_tmpfile
