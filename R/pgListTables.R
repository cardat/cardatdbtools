
################################################################
# name:pgListTables
pgListTables <- function(conn, schema, table=NA, match = TRUE)
{
  if(!is.na(table) & match == TRUE)
  {
    tables <- dbGetQuery(conn,
                         paste("select   c.relname, nspname
                       FROM pg_catalog.pg_class c
                       LEFT JOIN pg_catalog.pg_namespace n
                       ON n.oid = c.relnamespace
                       where (c.relkind IN ('r','','v'))
                        and (nspname = '",schema,"' and relname like '",table,"')", sep = "")
    )
  } else if(!is.na(table) & match == FALSE) {    
    tables <- dbGetQuery(conn,
                         paste("select   c.relname, nspname
                       FROM pg_catalog.pg_class c
                       LEFT JOIN pg_catalog.pg_namespace n
                       ON n.oid = c.relnamespace
                       where (c.relkind IN ('r','','v'))
                        and (nspname = '",schema,"' and relname like '%",table,"%')", sep = "")
    )
  } else {
    tables <- dbGetQuery(conn,
                         paste("select   c.relname, nspname
                       FROM pg_catalog.pg_class c
                       LEFT JOIN pg_catalog.pg_namespace n
                       ON n.oid = c.relnamespace
                       where (c.relkind IN ('r','','v'))
                        and (nspname = '",schema,"')", sep = "")
    )
  }

#   tables <- tables[grep(schema,tables$nspname),]
#    tables <- tables[grep(table, tables$relname),]
  if(nrow(tables) > 0)
    {
      tables <- tables[order(tables$relname),]
    }

  return(tables)
}
