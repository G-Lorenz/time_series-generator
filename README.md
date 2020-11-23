# Time series generator

This tool fetch data from JHU's [daily reports](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports).

The time series generated could be found [here](https://github.com/G-Lorenz/covid19-time_series).

With little effort it could be adapted to every report that resembles JHU's.

## How to use
Write start date in date.txt. YYYYMMDD date format is required.
Then run `time_series-generator.sh`. Output is similar to JHU's [time series](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series).
If you are interested in fetching only one country's data, it is recommended to use `single_country-time_series-generator.sh`: the use is the same, but you have to pass country's name as argument, in the command line.
I find the JHU's time series uncomfortable, so I suggest you to use `traspose.sh` or directly `traspose.awk` to traspose rows with cols.

## Bugs
Country with spaces in the filename are not analized correctly. I try to 'clean' the paths with sed, but it doesn't work.
If the Country starts to provide the data for more provinces, the program lost memory of the old data.

## License
If you use this tool to generate time series published somewhere, please provide a link to this repo.

### Warranty
The software is provided "as is", without warranty of any kind.
