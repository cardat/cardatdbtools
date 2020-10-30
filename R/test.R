## Get the population in a 100m buffer from each of the NSW monitor stations

source("get_population_in_buffer.R")

connect2postgres()
test <- get_population_in_buffer(
  points_lyr = "air_pollution_monitors.ap_monitor_locations_nsw"
  ,
  points_lyr_geom_col = "geom_albers"
  ,
  poly_lyr = "abs_mb.mb_2011_nsw_albers"
  ,
  poly_lyr_geom_col = "geom"
  ,
  radius = 100
  ,
  out_table = "pop_in_buffer"
)
