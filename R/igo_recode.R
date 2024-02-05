#' Helper functions to recode categories
#'
#' @description
#' These functions convert the numerical code of [igo_year_format3] and
#' [state_year_format3] into [factors][base::factor].
#'
#' - [igo_recode_igoyear()] is intended to work with values on
#'   [igo_year_format3].
#' - [igo_recode_stateyear()] is intended to work with values on
#'   [state_year_format3].
#' - [igo_recode_dyadic()] is intended to work with values on
#'   [igo_dyadic()].
#' @rdname igo_recode
#' @name igo_recode_igoyear
#' @param x Numerical value (or vector of values) to recode.
#'
#' @export
#'
#' @return
#' The recoded values as [factors][base::factor].
#'
#' @family datasets
#'
#' @examples
#' data("igo_year_format3")
#'
#' # Recode memberships for some countries
#'
#' library(dplyr)
#'
#' samp <- igo_year_format3 %>%
#'   select(ioname:year, spain, france) %>%
#'   filter(year > 2000) %>%
#'   as_tibble()
#'
#' glimpse(samp)
#'
#' # Recode
#' samp %>%
#'   mutate(
#'     spain = igo_recode_igoyear(spain),
#'     france = igo_recode_igoyear(france)
#'   ) %>%
#'   glimpse()
#'
igo_recode_igoyear <- function(x) {
  igo_hlp_recode(x, what = "igoyear")
}

#' @rdname igo_recode
#' @name  igo_recode_stateyear
#' @export
igo_recode_stateyear <- function(x) {
  igo_hlp_recode(x, what = "stateyear")
}

#' @rdname igo_recode
#' @name  igo_recode_dyadic
#' @export
igo_recode_dyadic <- function(x) {
  levs <- c(
    "No Joint Membership", "Joint Full Membership", "Missing data",
    "State Not System Member", NA
  )

  coded <- vapply(x, function(y) {
    yc <- as.character(y)
    switch(yc,
      "0" = "No Joint Membership",
      "1" = "Joint Full Membership",
      "-9" = "Missing data",
      "-1" = "State Not System Member",
      NA_character_
    )
  }, FUN.VALUE = character(1))

  factor(coded, levels = levs, exclude = NULL)
}


# Helper, vectorised switch with factors
igo_hlp_recode <- function(x, what = "igoyear") {
  nodata <- ifelse(what == "igoyear", "State Not System Member",
    "IGO Not In Existence"
  )

  levs <- c(
    "No Membership", "Full Membership", "Associate Membership",
    "Observer", "Missing data", nodata, NA
  )

  coded <- vapply(x, function(y) {
    yc <- as.character(y)
    switch(yc,
      "0" = "No Membership",
      "1" = "Full Membership",
      "2" = "Associate Membership",
      "3" = "Observer",
      "-9" = "Missing data",
      "-1" = nodata,
      NA_character_
    )
  }, FUN.VALUE = character(1))

  factor(coded, levels = levs, exclude = NULL)
}
