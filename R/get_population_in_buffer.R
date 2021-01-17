
get_population_in_buffer <- function(
  points_lyr = "air_pollution_monitors.ap_monitor_locations_master"
  ,
  points_lyr_geom_col = "geom_albers"
  ,
  poly_lyr = "abs_mb.mb_2016_aus_albers"
  ,
  poly_lyr_geom_col = "geom"
  ,
  radius = 100
  ,
  out_table = NULL
){
  sql_txt <- paste0("
select points_lyr.*
into ",out_table,"
from ",points_lyr," as points_lyr;
alter table ",out_table," add column pop_count numeric;
alter table ",out_table," add column buffered_pt_geom geometry;
update ",out_table," set buffered_pt_geom = ST_buffer(",out_table,".",points_lyr_geom_col,", ",radius,");
select poly_lyr.*
into temp_intersections
from ",out_table," pts, 
  ",poly_lyr," poly_lyr
where st_intersects(pts.",points_lyr_geom_col,", poly_lyr.",poly_lyr_geom_col,") and not st_within(poly_lyr.",poly_lyr_geom_col, ", pts.buffered_pt_geom)
union all select poly_lyr.*
from ",out_table," pts, 
  ",poly_lyr," ply
where st_within(pts.",points_lyr_geom_col,", poly_lyl.",poly_lyr_geom_col,");
update ",out_table," set pop_count

)
  if(!is.null(out_table)){
    sql_txt <- paste0("drop table if exists ",out_table,";", sql_txt)
  }
#  print(sql_txt)
  sql_txt
}
