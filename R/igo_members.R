#' Extract IGO membership records
#'
#' @name igo_members
#'
#' @description
#' Extracts state-level membership records for one or more IGOs and years.
#'
#' @param ioname An IGO identifier or vector of identifiers from
#'   [igo_year_format3]. Use [igo_search()] to find valid identifiers.
#' @param year An integer or vector of years to assess. If `NULL`, the latest
#'   available year for each IGO is used.
#' @param status A character vector of membership statuses to extract. See
#'   [state_year_format3] for valid statuses.
#'
#' @returns
#' A [`data.frame`][data.frame()] with one row per matching state, IGO, year and
#' membership status.
#'
#' @inherit igo_dyadic source references
#'
#' @seealso
#' [igo_year_format3], [igo_search()], [state_year_format3].
#'
#' @family membership functions
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' library(dplyr)
#' igo_members("EU", year = 1993) %>% as_tibble()
#' igo_members("EU") %>% as_tibble()
#' igo_members("NAFTA", year = c(1995:1998)) %>% as_tibble()
#'
#' # Extract multiple membership statuses.
#' igo_members("ACCT", status = c("Associate Membership", "Observer")) %>%
#'   as_tibble()
#'
#' # States that are not members of the UN.
#' igo_members("UN", status = "No Membership") %>%
#'   as_tibble()
#'
#' # Vectorized search.
#' igo_members(c("NAFTA", "EU"), year = 1993) %>%
#'   as_tibble() %>%
#'   arrange(state)
#'
#' # Use the countrycode package to add codes.
#' if (requireNamespace("countrycode", quietly = TRUE)) {
#'   library(countrycode)
#'   EU <- igo_members("EU")
#'   EU$iso3c <- countrycode(EU$ccode, origin = "cown", destination = "iso3c")
#'
#'   EU$continent <- countrycode(EU$ccode,
#'     origin = "cown",
#'     destination = "continent"
#'   )
#'
#'   tibble(EU)
#' }
igo_members <- function(ioname, year = NULL, status = "Full Membership") {
  # Require an explicit IGO identifier.
  if (missing(ioname)) {
    stop("`ioname` must be supplied.")
  }

  levls <- igo_status_levels(igo_recode_stateyear)
  igo_warn_invalid_status(status, levls)

  # Keep one lookup result for each IGO identifier.
  find_v <- lapply(ioname, igo_member_single, year = year, status = status)

  igo_bind_results(
    find_v,
    "No IGO membership records were found for the supplied arguments."
  )
}

igo_member_single <- function(ioname, year, status) {
  igo_db <- igoR::igo_year_format3

  igo_db <- igo_db[tolower(igo_db$ioname) %in% tolower(ioname), ]

  if (nrow(igo_db) == 0) {
    message("Unknown value for `ioname`: '", ioname, "'.")
    return(NULL)
  }

  if (is.null(year)) {
    year <- max(igo_db$year)
  }

  year <- sort(unique(year))
  ioname <- igo_db$ioname[1]

  # Build the requested IGO-year combinations.
  master_db <- expand.grid(
    ioname = ioname,
    year = year,
    stringsAsFactors = FALSE
  )

  igo_db2 <- merge(igo_db, master_db)[, c("ioname", "year", "orgname")]

  if (nrow(igo_db2) == 0) {
    dates <- range(igo_db$year, na.rm = TRUE)
    message(
      "IGO '",
      ioname,
      "' is available from ",
      paste0(dates, collapse = " to "),
      "."
    )
    return(NULL)
  }

  # Add state-level membership status.
  state_igo <- igoR::state_year_format3
  state_igo <- state_igo[, tolower(c("ccode", "state", "year", ioname))]
  colnames(state_igo) <- c("ccode", "state", "year", "value")
  state_igo$ioname <- as.character(ioname)
  state_igo$category <- igo_recode_stateyear(state_igo$value)

  # Join membership status to the requested IGO-year combinations.
  igo_w_year <- merge(igo_db2, state_igo)
  igo_w_year <- igo_w_year[igo_w_year$category %in% status, ]

  if (nrow(igo_w_year) == 0) {
    message(
      "No membership records for IGO '",
      ioname,
      "' matched the supplied arguments."
    )
    return(NULL)
  }

  # Add final state metadata.
  dfnames <- cow_cntr_codes(c("ccode", "statenme"))
  cntriesend <- merge(igo_w_year, dfnames)
  # Arrange columns for the public return value.
  rearcol <- unique(c(
    "ioname",
    "ccode",
    "state",
    "statenme",
    "year",
    "value",
    "category",
    "orgname"
  ))

  cntriesend <- cntriesend[, rearcol]
  cntriesend <- cntriesend[
    order(cntriesend$year, cntriesend$category, cntriesend$ccode),
  ]

  igo_reset_rows(cntriesend)
}


cow_cntr_codes <- function(col_names = names(states2016)) {
  df <- unique(igoR::states2016[, c("ccode", "stateabb", "statenme", "state")])
  df <- df[order(df$ccode), ]
  df[, intersect(col_names, names(df))]
}
