
################################################################
# name:get_pgpass
get_pgpass <- function(database, host, user, remote = FALSE, savePassword = FALSE){

  linux <- LinuxOperatingSystem()
  if(linux){
    fileName <- "~/.pgpass"
  } else {
    directory <- Sys.getenv("APPDATA")
    fileName <- file.path(directory, "postgresql", "pgpass.conf")
  }
  ## passwordTable <- get_passwordTable(fileName = fileName)
  exists <- file.exists(fileName)
  if(!exists & linux){
      sink('~/.pgpass')
      cat('hostname:port:database:username:password\n')
      sink()
  }
   
  if (!exists & !linux){
    if(!file.exists(file.path(directory, "postgresql"))) dir.create(file.path(directory, "postgresql"))
  } else {
    passwordTable <- read.table(fileName, sep = ":", stringsAsFactors=FALSE)
    #return(passwordTable)
  }

  if(exists('passwordTable')){
    hostColumn <- 1
    databaseColumn <- 3
    userColumn <- 4
    passwordColumn <- 5

    recordIndex <- which(passwordTable[,hostColumn] == host &
    passwordTable[,databaseColumn] == database & passwordTable[,userColumn] == user)

    if (length(recordIndex > 0) > 0){
      pwd <- passwordTable[recordIndex, passwordColumn]
      pwd <- as.character(pwd)

    } else {
      pwd <- getPassword(remote = remote)
    }
  } else {
    pwd <- getPassword(remote = remote)
    recordIndex <- NULL
  }
  record <- c(V1 = host, V2 = "5432", V3 = database, V4 = user, V5 = pwd)
  #record <- paste(host, ":5432:*:",  user,":",  pgpass, collapse = "", sep = "")
  record <- t(record)
  #TODO get user ok here, also on linux need to add
  "WARNING: You have opted to save your password. It will be stored in plain text in your project files and in your home directory on Unix-like systems, or in your user profile on Windows. If you do not want this to happen, please press the Cancel button."

  #savePassword = TRUE
  if (savePassword & length(recordIndex > 0) == 0){

    if (!exists("passwordTable")){
      passwordTable <- as.data.frame(record)
    } else {
      passwordTable = rbind(passwordTable, record)
    }
    write.table(x = passwordTable, file = fileName, sep = ":", eol = "\r\n", row.names = FALSE, col.names = FALSE, quote = FALSE)
  }

  return (record)
}
