#' @title Extract Members of an IGO
#' @name igo_members
#' @description Extract all the countries belonging to an IGO on a specific
#' date.
#' @return A dataframe.
#' @seealso \code{\link{igo_year_format3}},
#' \code{\link{igo_search}}, \code{\link{state_year_format3}}.
#' @export
#'
#' @param ioname Any valid \code{ioname} of an IGO as specified on
#' \code{\link{igo_year_format3}}.
#' @param year Year to be assessed, an integer or an array of year.
#' If \code{NULL} the latest year available
#' of the IGO would be extracted.
#' @param status Character or vector with the membership status to be
#' extracted. See Details
#' on  \code{\link{state_year_format3}}.
#' @examples
#' # Composition on two different dates
#' igo_members("EU", year = 1993)
#' igo_members("EU")
#' igo_members("NAFTA", year = c(1995:1998))
#'
#' # Extract different status
#' igo_members("ACCT", status = c("Associate Membership", "Observer"))
#'
#' # States no members of the UN
#' igo_members("UN", status = "No Membership")
#'
#' # Use countrycodes package to get additional codes
#' if (requireNamespace("countrycode", quietly = TRUE)) {
#'   library(countrycode)
#'   EU <- igo_members("EU")
#'   EU$iso3c <- countrycode(EU$ccode, origin = "cown",
#'                           destination = "iso3c")
#'   EU$un.subregion <- countrycode(EU$ccode, origin = "cown",
#'                                  destination = "un.regionsub.name")
#'
#'   head(EU)
#' }

igo_members <- function(ioname,
                        year = NULL,
                        status = "Full Membership") {
  # Checks

  if (missing(ioname)) {
    stop("You must enter a value on 'ioname'")
  }

  df <- igoR::igo_year_format3

  if (!(ioname %in% df$ioname)) {
    stop(ioname, " is not a valid ioname. See igoR::igo_year_format3")
  }

  df <- df[df$ioname == ioname, ]
  interval <- c(min(df$year), max(df$year))

  if (is.null(year)) {
    year <- interval[2]
  }
  year <- sort(unique(as.integer(year)))
  yeardf <- data.frame(year = year,
                       check = NA)

  yeardf$check <- ifelse(yeardf$year %in% df$year,
                         TRUE,
                         FALSE)



  if (isFALSE(all(yeardf$check))) {
    warning(
      "The IGO requested is not available for year(s) ",
      paste0("'",
             as.character(yeardf[!yeardf$check, ]$year),
             "'", collapse = ", ")
    )
  }

  df <- df[df$year %in% year, c("year", "ioname", "orgname")]

  if (nrow(df) == 0) {
    stop(
      "year(s) ",
      paste0("'",
             as.character(yeardf[!yeardf$check, ]$year),
             "'", collapse = ", "),
      " not valid for ",
      ioname,
      " date should be any year between ",
      interval[1],
      " and ",
      interval[2]
    )
  }


  # End checks

  helpdf <- data.frame(
    category = c(
      "No Membership",
      "Full Membership",
      "Associate Membership",
      "Observer",
      "Missing Data"
    ),
    value = c(0, 1, 2, 3, -9),
    stringsAsFactors = FALSE
  )

  checkstatus <- match(status, helpdf$category)
  if (isTRUE(anyNA(checkstatus))) {
    warning(
      "status ",
      paste0("'", status[is.na(checkstatus)], "'", collapse = ", "),
      " not valid. Valid values are ",
      paste0("'", helpdf$category, collapse = "', "),
      "'"
    )
  }

  # Extract countries
  cntries <- igoR::state_year_format3
  cntries <-
    cntries[cntries$year %in% year, tolower(c("ccode", "state",
                                              "year",
                                              ioname))]

  colnames(cntries) <- c("ccode", "state", "year", "value")
  cntries$ioname <- as.character(ioname)
  codestatus <- helpdf[helpdf$category %in% status, ]
  cntriesend <- merge(cntries, codestatus)
  cntriesend <- merge(cntriesend, df)

  # Names
  dfnames <- igoR::cow_country_codes[,c("ccode", "statenme")]
  cntriesend <- merge(cntriesend, dfnames)

  # Rearrange columns
  rearcol <- unique(c("ioname",
                      "ccode",
                      "state",
                      "statenme",
                      "year",
                      colnames(cntriesend)))

  cntriesend <- cntriesend[, rearcol]

  # Extra check
  if (nrow(cntriesend) == 0) {
    stop("Parameters selected return an empty result")
  }

  cntriesend <- cntriesend[order(cntriesend$state), ]
  cntriesend <- cntriesend[order(cntriesend$year), ]
  rownames(cntriesend) <- NULL

  return(cntriesend)
}
