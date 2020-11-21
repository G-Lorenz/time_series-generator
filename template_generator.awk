#!/usr/bin/awk -f

BEGIN {OFS=","
        FS="," }
title1="../covid19-time_series/rows/confirmed/time_series_covid_19_confirmed_" country ".csv"
title2="../covid19-time_series/rows/deaths/time_series_covid_19_deaths_" country ".csv"
title3="../covid19-time_series/rows/recovered/time_series_covid_19_recovered_" country ".csv"
title4="../covid19-time_series/rows/active/time_series_covid_19_active_" country ".csv"

($4==country && NR!=1) {
        print $2,$3,$4 >> title1
        print $2,$3,$4 >> title2
        print $2,$3,$4 >> title3
        print $2,$3,$4 >> title4
}

