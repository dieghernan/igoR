#' Recode membership categories
#'
#' @name igo_recode_igoyear
#' @rdname igo_recode
#'
#' @description
#' Converts the numerical membership codes in [igo_year_format3],
#' [state_year_format3] and [igo_dyadic()] into [factors][base::factor]. Use
#' [igo_recode_igoyear()] with values from [igo_year_format3],
#' [igo_recode_stateyear()] with values from [state_year_format3] and
#' [igo_recode_dyadic()] with values from [igo_dyadic()].
#'
#' @param x A numerical value or vector of values to recode.
#'
#' @returns
#' A [factor][base::factor] with the recoded membership categories.
#'
#' @family recode helpers
#'
#' @examples
#' data("igo_year_format3")
#'
#' # Recode memberships for some states.
#' library(dplyr)
#'
#' samp <- igo_year_format3 %>%
#'   select(ioname:year, spain, france) %>%
#'   filter(year > 2000) %>%
#'   as_tibble()
#'
#' glimpse(samp)
#'
#' # Recode the membership columns.
#' samp %>%
#'   mutate(
#'     spain = igo_recode_igoyear(spain),
#'     france = igo_recode_igoyear(france)
#'   ) %>%
#'   glimpse()
#'
#' @encoding UTF-8
#' @export
igo_recode_igoyear <- function(x) {
  igo_hlp_recode(x, what = "igoyear")
}

#' @name igo_recode_stateyear
#' @rdname igo_recode
#' @export
igo_recode_stateyear <- function(x) {
  igo_hlp_recode(x, what = "stateyear")
}

#' @name igo_recode_dyadic
#' @rdname igo_recode
#' @export
igo_recode_dyadic <- function(x) {
  levs <- c(
    "No Joint Membership",
    "Joint Full Membership",
    "Missing data",
    "State Not System Member",
    NA
  )

  coded <- vapply(
    x,
    function(y) {
      yc <- as.character(y)
      switch(yc,
        "0" = "No Joint Membership",
        "1" = "Joint Full Membership",
        "-9" = "Missing data",
        "-1" = "State Not System Member",
        NA_character_
      )
    },
    FUN.VALUE = character(1)
  )

  factor(coded, levels = levs, exclude = NULL)
}

# Preserve factor levels while recoding membership values.
igo_hlp_recode <- function(x, what = "igoyear") {
  nodata <- ifelse(
    what == "igoyear",
    "State Not System Member",
    "IGO Not In Existence"
  )

  levs <- c(
    "No Membership",
    "Full Membership",
    "Associate Membership",
    "Observer",
    "Missing data",
    nodata,
    NA
  )

  coded <- vapply(
    x,
    function(y) {
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
    },
    FUN.VALUE = character(1)
  )

  factor(coded, levels = levs, exclude = NULL)
}
