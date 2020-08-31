
################################################################
# name:connect2postgres2
connect2postgres2 <- function(database, host=NA, user = NA)
{
if(!require(fgui)) install.packages("fgui", repos='http://cran.csiro.au'); require(fgui)
  if(is.na(host) | is.na(user))
  {
    # try to find unique record for that database
    passwordTable <- get_passwordTable()
    recordIndex <- which(passwordTable$V3 == database)
    if(length(recordIndex) == 1)
      {
        pgpass <- passwordTable[recordIndex,]
      } else {

      # if not found then ask the user for ip and uname
      pgpass <- guiv(get_pgpass,
                    argOption=list(savePassword=c("TRUE","FALSE")))
    }
      ch <- connect2postgres(hostip = pgpass[1], db=database,
                            user=pgpass[4], p = pgpass[5])

  } else {
   pgpass <- get_pgpass(database = database, host = host, user = user)
   ch <- connect2postgres(hostip = host, db=database,
                          user=user, p = pgpass[5])
  }

   return(ch)
}
