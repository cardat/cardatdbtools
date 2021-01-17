#### This is for daily data

# Function to create table for pollutants data for a single state and year in long format
# This assumes a connection to the database and that it inherits from the master table
create_data_table_daily <- function(state, year) {
  source('scripts/functions/create_data_daily_table_change_log.R')
  state_lower <- tolower(state)
  state_upper <- toupper(state)
  tbl_name <- sprintf("air_pollution_monitors.ap_monitor_data_daily_%s_%s",state_lower,year)
  
  ## Create the table
  dbSendQuery(ch, sprintf('CREATE TABLE %s () INHERITS (air_pollution_monitors.ap_monitor_data_daily_master);',tbl_name))
  ## Add constraints
  dbSendQuery(ch,sprintf("ALTER table %s ADD CONSTRAINT ap_monitor_data_daily_%s_%s_unique_reading UNIQUE (station_id,station,state,year,date,variable,units,time_basis,measurement_method);",tbl_name,state_lower,year))
  dbSendQuery(ch,sprintf("ALTER table %s ADD CONSTRAINT ap_monitor_data_daily_%s_%s_id_unique UNIQUE (id);",tbl_name,state_lower,year))
  dbSendQuery(ch,sprintf("ALTER table %s ADD CONSTRAINT ap_monitor_data_daily_%s_%s_state_year_check CHECK (state in (\'%s\') AND (year in (%s)));",tbl_name,state_lower,year,state_upper,year))
  fkey<-sprintf("ap_monitor_data_daily_%s_%s_station_id_fkey",state,year)
  dbSendQuery(ch,sprintf("ALTER TABLE %s ADD CONSTRAINT ap_monitor_data_daily_%s_%s_station_id_fkey FOREIGN KEY (station_id) REFERENCES air_pollution_monitors.ap_monitor_locations_%s (station_id);",tbl_name, state_lower, year, state_lower))
  ## Add indices to table
  dbSendQuery(ch, sprintf('CREATE index ap_monitor_data_daily_%s_%s_variable_index on %s (variable);',state_lower,year,tbl_name))
  dbSendQuery(ch, sprintf('CREATE index ap_monitor_data_daily_%s_%s_stn_id_index on %s (station_id);',state_lower,year,tbl_name))
  dbSendQuery(ch, sprintf('CREATE index ap_monitor_data_daily_%s_%s_stn_name_index on %s (station);',state_lower,year,tbl_name))
  ## Create the change log table
  create_data_daily_table_change_log(state_lower,year)
  ## Create the triggers
  trig_name_1<-sprintf("ap_monitor_data_daily_%s_%s_update_cl_trigger",state_lower,year)
  trig_name_2<-sprintf("ap_monitor_data_daily_%s_%s_update_timpstamp_trigger",state_lower,year)
  dbSendQuery(ch,sprintf("CREATE TRIGGER %s BEFORE UPDATE ON %s FOR EACH ROW EXECUTE PROCEDURE copy_data_daily_to_change_log();",trig_name_1,tbl_name))
  dbSendQuery(ch,sprintf("CREATE TRIGGER %s BEFORE UPDATE ON %s FOR EACH ROW EXECUTE PROCEDURE update_change_timestamp();",trig_name_2,tbl_name))
  }
# test
# create_data_table_daily('act',1979)