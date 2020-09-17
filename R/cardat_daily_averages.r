cardat_daily_averages <- function(
  var = 'pm25', 
  ## The pollutant or meteorolgical variable - this can be in the format "'pm25','no2','rain'" for multiple variables
  state = "all", 
  ## The state(s). If 'all' then all states. Multiple states can be done in the same format as var e.g. "'qld','nsw','act'"
  threshold = 0.7,
  ## The threshold is the minimum % of hourly readings in a day needed to calculate an average (this sholud be 0 < threshold <= 1)
  year = "all"
  ## The year(s) Multiple years
)
  #### This function returns daily averages from the hourly averages table in CAR's national air pollution monitoring database.
  {
  if (state=='all'){
    states <- ''
  } else {
    states <- sprintf('and d.state in (%s)', toupper(state))
  }
  if (year=='all'){
    years <- ''
  } else {
    years <- sprintf('and d.year in (%s)', year)
  }
  sql <- sprintf("select l.state, l.station, l.lat, l.lon, d.date, d.variable, avg(d.value), d.units, d.measurement_method, count(*) as number_of_readings
    from air_pollution_monitors.ap_monitor_locations_master as l, air_pollution_monitors.ap_monitor_data_master d
    where d.station = l.station
    and d.state = l.state
    and d.variable in (%s)
    %s
    %s
    group by l.state l.station, l.lat, l.lon, d.date, d.variable, d.units, d.measurement_method, 
    having count(*)>=%s", var, state, years, threshold*24)
  print("With thanks to NSW DPIE, EPA Victoria, SA EPA, NT EPA, EPA Tasmania, ACT Health, Qld DES, WA DWER for provision of the air pollution monitoring data in this database.")
  print("Please note that this query will take a few minutes to complete.")
  return(sql)                
}
