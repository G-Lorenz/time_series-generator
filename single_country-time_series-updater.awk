#!/usr/bin/awk -f

BEGIN {OFS=","
        FS="," }
title1="../covid19-time_series/rows/confirmed/temp_time_series_covid_19_confirmed_" country ".csv"
title2="../covid19-time_series/rows/deaths/temp_time_series_covid_19_deaths_" country ".csv"
title3="../covid19-time_series/rows/recovered/temp_time_series_covid_19_recovered_" country ".csv"
title4="../covid19-time_series/rows/active/temp_time_series_covid_19_active_" country ".csv"

($4==country && NR!=1) {
        print $8 > title1
        print $9 > title2
        print $10 > title3
        print $11 > title4
}
