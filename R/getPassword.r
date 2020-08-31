
###########################################################################
# newnode: getPassword
getPassword <- function(remote = F){
  if(remote == F){
   pass <- askpass::askpass()
   return(pass)
 } else {
   pass <- readline('Type your password into the console: ')
   return(pass)
 }
}


# pwd <- getPassword()
