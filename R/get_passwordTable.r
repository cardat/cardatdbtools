
################################################################
# name:get_passwordTable
    get_passwordTable <- function(fileName)
    {
      linux <- LinuxOperatingSystem()
      if(linux)
      {
        fileName <- "~/.pgpass"
      } else
      {
        directory <- Sys.getenv("APPDATA")
        fileName <- file.path(directory, "postgresql", "pgpass.conf")
      }
  
      exists <- file.exists(fileName)
      if(!exists & linux)
      {
        sink('~/.pgpass')
        cat('hostname:port:database:username:password\n')
        sink()
      }
  
      if (exists)
      {
        passwordTable <- read.table(fileName, sep = ":", stringsAsFactors=FALSE)
        return(passwordTable)
      } 
  
    }
