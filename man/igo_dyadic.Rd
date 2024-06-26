% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/igo_dyadic.R
\name{igo_dyadic}
\alias{igo_dyadic}
\title{Extract the joint membership of a pair of countries across IGOs}
\source{
\href{https://correlatesofwar.org/data-sets/IGOs/}{\strong{Codebook Version 3 IGO Data}} for full reference.
}
\usage{
igo_dyadic(country1, country2, year = 1816:2014, ioname = NULL)
}
\arguments{
\item{country1, country2}{A state of vector of states to be compared. It
could be any valid name or code of a state as specified on \link{states2016}.}

\item{year}{Year to be assessed, an integer or an array of year.}

\item{ioname}{Optional. \code{ioname} or vector of \code{ioname} corresponding to the
IGOs to be assessed. If \code{NULL} (the default), all IGOs would be extracted.
See codes on \code{\link[=igo_search]{igo_search()}}.}
}
\value{
A coded \code{\link[=data.frame]{data.frame}} representing the years and country dyad
(rows) and the IGOs selected (columns). See \strong{Details}.
}
\description{
Dyadic version of the data. The unit of observation is a dyad of countries.
It provides a summary of the joint memberships of two countries across IGOs
over time.
}
\details{
This function tries to replicate the information contained in the original
file distributed by The Correlates of War Project (\code{dyadic_format3.dta}).
That file is not included in this package due to its size.

The result is a \code{\link[=data.frame]{data.frame}} containing the common years of
the states selected via \verb{country1, country2, year} by rows.

An additional column \code{dyadid}, computed as \code{(1000*ccode1)+ccode2} is provided
in order to identify relationships.

For each IGO selected via \code{ioname} (or all if the default option has been
used) a column (using lowercase \code{ioname} as identifier) is provided with the
following code system:\tabular{lr}{
   \strong{Category} \tab \strong{Numerical Value} \cr
   No Joint Membership \tab 0 \cr
   Joint Full Membership \tab 1 \cr
   Missing data \tab -9 \cr
   State Not System Member \tab -1 \cr
}


See \code{\link[=igo_recode_dyadic]{igo_recode_dyadic()}} section for an easy way to recode the numerical
values into \link[base:factor]{factors}.

If one state in an IGO is a full member but the other is an associate member
or observer, that IGO is not coded as a joint membership.
}
\section{Differences with the original dataset}{
There are some differences on the results provided by this function and the
original dataset on some IGOs regarding the "Missing Data" (\code{-9}) and
"State Not System Member" (\code{-1}). However it is not clear how to fully
replicate those values.

See \href{https://correlatesofwar.org/data-sets/IGOs/}{\strong{Codebook Version 3 IGO Data}}
}

\examples{
usa_esp <- igo_dyadic("USA", "Spain")
nrow(usa_esp)
ncol(usa_esp)

dplyr::tibble(usa_esp)

# Using custom parameters
custom <- igo_dyadic(
  country1 = c("France", "Germany"), country2 = c("Sweden", "Austria"),
  year = 1992:1993, ioname = "EU"
)

dplyr::glimpse(custom)
}
\references{
Pevehouse, J. C., Nordstrom, T., McManus, R. W., & Jamison, A. S. (2020).
Tracking organizations in the world: The Correlates of War IGO Version 3.0
datasets. \emph{Journal of Peace Research, 57}(3), 492–503.
\doi{10.1177/0022343319881175}.
}
\seealso{
\link{state_year_format3},  \link{states2016}, \code{\link[=igo_search]{igo_search()}}.
}
