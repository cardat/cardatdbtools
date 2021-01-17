# Function to create change log table for daily data for a single state and year in long format
# This assumes a connection to the database and that it inherits from the master table
create_data_daily_table_change_log <- function(state, year) {
  #state<-'act'
  #year<-1979
  state_lower <- tolower(state)
  state_upper <- toupper(state)
  tbl_name <- sprintf("air_pollution_monitors_change_log.ap_monitor_data_daily_%s_%s_cl",state_lower,year)
  
  ## Create the table
  dbSendQuery(ch, sprintf('CREATE TABLE %s () INHERITS (air_pollution_monitors_change_log.ap_monitor_data_daily_master_cl);',tbl_name))
  ## Add constraints
  dbSendQuery(ch,sprintf("ALTER table %s ADD CONSTRAINT ap_monitor_data_daily_%s_%s_state_year_check CHECK (state in (\'%s\') AND (year in (%s)));",tbl_name,state_lower,year,state_upper,year))
  fkey<-sprintf("ap_monitor_data_%s_%s_station_id_fkey",state,yr)
  ## Add indices to table
 dbSendQuery(ch, sprintf('CREATE index ap_monitor_data_daily_%s_%s_variable_index on %s (variable);',state_lower,year,tbl_name))
 dbSendQuery(ch, sprintf('CREATE index ap_monitor_data_daily_%s_%s_stn_id_index on %s (station_id);',state_lower,year,tbl_name))
 dbSendQuery(ch, sprintf('CREATE index ap_monitor_data_daily_%s_%s_stn_name_index on %s (station);',state_lower,year,tbl_name))

}
## Test
#create_data_daily_table_change_log('vic',1979)
