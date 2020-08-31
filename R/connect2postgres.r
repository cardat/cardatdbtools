
#################
# connect2postgres

connect2postgres <- function(hostip=NA,db=NA,user=NA, p=NA, os = 'linux', pgutils = c('c:/pgutils')){
 if(is.na(hostip)){
 hostip=readline('enter hostip: ')
 } 
 if(is.na(db)){
 db=readline('enter db: ')
 }
 if(is.na(user)){
 user=readline('enter user: ')
 }
 if(is.na(p)){
 pwd=readline(paste('enter password for user ',user, ': ',sep=''))
 } else {
 pwd <- p
 }
 #if(os == 'linux'){
  if (!require(RPostgreSQL)) install.packages('RPostgreSQL', repos='http://cran.csiro.au'); require(RPostgreSQL)
  con <- dbConnect(PostgreSQL(),host=hostip, user= user, password=pwd, dbname=db)
#  } else { 
#   if (!require(RJDBC)) install.packages('RJDBC'); require(RJDBC) 
#   # This downloads the JDBC driver to your selected directory if needed
#   if (!file.exists(file.path(pgutils,'postgresql-8.4-701.jdbc4.jar'))) {
#   dir.create(pgutils,recursive =T)
#   download.file('http://jdbc.postgresql.org/download/postgresql-8.4-701.jdbc4.jar',file.path(pgutils,'postgresql-8.4-701.jdbc4.jar'),mode='wb')
#   }
#   # connect
#   pgsql <- JDBC( 'org.postgresql.Driver', file.path(pgutils,'postgresql-8.4-701.jdbc4.jar'))
#   con <- dbConnect(pgsql, paste('jdbc:postgresql://',hostip,'/',db,sep=''), user = user, password = pwd)
#  }
 # clean up
 rm(pwd)
 return(con)
 }
 #  ch <- connect2postgres()
 # enter password at console
