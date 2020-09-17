# paste0(basename(tempfile()),"_test_pts_in_ply")
postgis_extract_points_in_polygon <- function(
  points_lyr = "air_pollution_monitors.ap_monitor_locations_master"
  ,
  points_lyr_geom_col = "geom_gda94"
  ,
  poly_lyr = "abs_ste.ste_2011_aus"
  ,
  poly_lyr_geom_col = "geom"
  ,
  out_table = NULL
){
sql_txt <- paste0("
select pts.*
into ",out_table,"
from ",points_lyr," pts, 
  ",poly_lyr," ply
where st_within(pts.",points_lyr_geom_col,", ply.",poly_lyr_geom_col,")
")
if(!is.null(out_table)){
sql_txt <- paste0("drop table if exists ",out_table,";\n", sql_txt)
}
# cat(sql_txt)
sql_txt
}
