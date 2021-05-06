#### This function returns monthly avereages based on daily averages from the hourly averages table in CAR's national air pollution monitoring database.

## parameters:
## var = 'pm25', 
## The pollutant or meteorolgical variable - this can be in the format "'pm25','no2','rain'" for multiple variables
## state = "all", 
## The state(s). If 'all' then all states. Multiple states can be done in the same format as var e.g. "'qld','nsw','act'"
## threshold = 0.7,
## The threshold is the minimum % of hourly readings in a day needed to calculate an average (this sholud be 0 < threshold <= 1)
##year = "all"
## The year(s) Multiple years

cardat_ap_daily_averages <- function(
  var = 'pm25', 
  state = "all", 
  threshold = 0.7,
  year = "all"
)
  
  {
  if (state=='all'){
    states <- ''
  } else {
    states <- sprintf("AND d.state in ('%s')", toupper(state))
  }
  if (year=='all'){
    years <- ''
  } else {
    years <- sprintf('AND d.year in (%s)', year)
  }
  sql <- sprintf("
  
 
SELECT l.state, l.station, l.lat, l.lon, d.year,d.date, d.variable, avg(d.value) as daily_av, d.units, d.measurement_method, count(*) as number_of_readings
    FROM air_pollution_monitors.ap_monitor_locations_master as l, air_pollution_monitors.ap_monitor_data_master d
    WHERE d.station = l.station
    AND d.state = l.state
    AND d.variable in ('%s')
    %s
    %s
    GROUP BY l.state, l.station, l.lat, l.lon, d.year, d.date, d.variable, d.units, d.measurement_method
    HAVING count(*)>=%s*24;
    ", var, states, years, threshold)
  
  print("With thanks to NSW DPIE, EPA Victoria, SA EPA, NT EPA, EPA Tasmania, ACT Health, Qld DES, WA DWER for provision of the air pollution monitoring data in this database.")
  print("Please note that this query will take a few minutes to complete.")
  return(sql)                
}

#### Test the function
## connect to the db
##ch<-connect2postgres("swish4.tern.org.au","postgis_car","christy_geromboux")
## generate sql for query
##sql<-cardat_ap_daily_averages(var='no2',state='NSW',year='2019')
##dat<-dbGetQuery(ch,sql)

