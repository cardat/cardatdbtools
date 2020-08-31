
\name{getPassword}
\alias{getPassword}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
getPassword
}
\description{
getPassword
}
\usage{
getPassword(remote = F)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{remote}{
%%     ~~Describe \code{remote} here~~
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
function (remote = F) 
{
  if(remote == F){
   pass <- askpass::askpass()
   return(pass)
 } else {
   pass <- readline('Type your password into the console: ')
   return(pass)
 }
}
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
