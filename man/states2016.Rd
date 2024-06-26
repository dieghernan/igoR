% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{states2016}
\alias{states2016}
\title{State System Membership (v2016)}
\format{
\code{\link[=data.frame]{data.frame}} with
243 rows. Relevant fields:
\itemize{
\item \strong{ccode}: COW country number.
\item \strong{stateabb}: COW state abbreviation (3 characters).
\item \strong{statenme}: COW state name.
\item \strong{styear...endday}: Fields to identify the beginning and the end of each
tenure.
\item \strong{version}: Data file version number.
\item \strong{state}: Abbreviated state name as appear in \link{state_year_format3}.
}
}
\source{
\href{https://correlatesofwar.org/data-sets/state-system-membership/}{State System Membership (v2016)},
The Correlates of War Project.
}
\description{
The list of states with COW abbreviations and ID numbers, plus the field
\code{state} from \link{state_year_format3}.
}
\details{
This data set contains the list of states in the international system as
updated and distributed by the Correlates of War Project.

These data sets identify states, their standard Correlates of War "country
code" or state number (used throughout the Correlates of War project data
sets), state abbreviations, and dates of membership as states and major
powers in the international system.

The Correlates of War project includes a state in the international system
from 1816-2016 for the following criteria:
\itemize{
\item \strong{Prior to 1920} the entity must have had a population greater than
500,000 and have had diplomatic missions at or above the rank of charge
d'affaires with Britain and France.
\item \strong{After 1920} the entity must be a member of the League of Nations or the
United Nations, or have a population greater than 500,000 and receive
diplomatic missions from two major powers.
}
}
\note{
\code{state} variable added to original data to help comparison across datasets
on this package.
}
\examples{
# example code
data("states2016")
dplyr::glimpse(states2016)
}
\references{
Correlates of War Project. 2017 "State System Membership List, v2016."
Online, \url{https://correlatesofwar.org/}.
}
\seealso{
Other datasets: 
\code{\link{igo_recode_igoyear}()},
\code{\link{igo_year_format3}},
\code{\link{state_year_format3}}
}
\concept{datasets}
