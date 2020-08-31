
\name{connect2postgres}
\alias{connect2postgres}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
connect to a postgres db
}
\description{
connect to a postgres db
}
\usage{
connect2postgres(hostip = NA, db = NA, user = NA, p = NA, os = "linux", pgutils = c("/home/ivan/tools/jdbc", "c:/pgutils"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{hostip}{
%%     ~~Describe \code{hostip} here~~
}
  \item{db}{
%%     ~~Describe \code{db} here~~
}
  \item{user}{
%%     ~~Describe \code{user} here~~
}
  \item{p}{
%%     ~~Describe \code{p} here~~
}
  \item{os}{
%%     ~~Describe \code{os} here~~
}
  \item{pgutils}{
%%     ~~Describe \code{pgutils} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
ivanhanigan
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
\dontrun{
function (hostip = NA, db = NA, user = NA, p = NA, os = "linux", 
    pgutils = c("/home/ivan/tools/jdbc", "c:/pgutils")) 
{
    if (is.na(hostip)) {
        hostip = readline("enter hostip: ")
    }
    if (is.na(db)) {
        db = readline("enter db: ")
    }
    if (is.na(user)) {
        user = readline("enter user: ")
    }
    if (is.na(p)) {
        pwd = readline(paste("enter password for user ", user, 
            ": ", sep = ""))
    }
    else {
        pwd <- p
    }
    if (os == "linux") {
        if (!require(RPostgreSQL)) 
            install.packages("RPostgreSQL", repos = "http://cran.csiro.au")
        require(RPostgreSQL)
        con <- dbConnect(PostgreSQL(), host = hostip, user = user, 
            password = pwd, dbname = db)
    }
    else {
        if (!require(RJDBC)) 
            install.packages("RJDBC")
        require(RJDBC)
        if (!file.exists(file.path(pgutils, "postgresql-8.4-701.jdbc4.jar"))) {
            dir.create(pgutils, recursive = T)
            download.file("http://jdbc.postgresql.org/download/postgresql-8.4-701.jdbc4.jar", 
                file.path(pgutils, "postgresql-8.4-701.jdbc4.jar"), 
                mode = "wb")
        }
        pgsql <- JDBC("org.postgresql.Driver", file.path(pgutils, 
            "postgresql-8.4-701.jdbc4.jar"))
        con <- dbConnect(pgsql, paste("jdbc:postgresql://", hostip, 
            "/", db, sep = ""), user = user, password = pwd)
    }
    rm(pwd)
    return(con)
  }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
