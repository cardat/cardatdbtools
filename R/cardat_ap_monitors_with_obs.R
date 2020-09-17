
cardat_ap_monitors_with_obs <- function(
  var = "o3"
  ,
  study_region_monitors = "fileb2f1bad353_test"
){
sql <- paste0("select
d.state, d.station,
l.lon, l.lat, l.altitude, min(d.year) as start_year, max(d.year) as most_recent_year
from (
select l_all.* 
from air_pollution_monitors.ap_monitor_locations_master l_all
right join
",study_region_monitors," l_stdy
on l_all.station = l_stdy.station 
and l_all.state = l_stdy.state
) l
left join
air_pollution_monitors.ap_monitor_data_master d
on l.state = d.state
and l.station = d.station
where d.variable = '",var,"'
and d.value is not null
group by d.state, d.station, l.lon, l.lat, l.altitude"
)
print("Please note that this query will take a few minutes to complete.")
return(sql)
}
