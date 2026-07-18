#' Extract IGO membership records by state
#'
#' @name igo_state_membership
#'
#' @description
#' Extracts IGO membership records for one or more states and years.
#'
#' @inheritParams igo_search_states
#' @param year An integer or vector of years to assess. If `NULL`, the latest
#'   available year for each state is used.
#' @param status A character vector of membership statuses to extract from
#'   IGO-level state membership records. See [igo_year_format3] for valid
#'   statuses.
#'
#' @returns
#' A [`data.frame`][data.frame()] with one row per matching state, IGO-year and
#' membership status.
#'
#' @inherit igo_members source references
#'
#' @seealso
#' [igo_year_format3], [igo_search_states()], [states2016].
#'
#' @family membership functions
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#' # Memberships in selected years.
#' igo_state_membership("Spain", year = 1850)
#' igo_state_membership("Spain", year = 1870)
#' igo_state_membership("Spain", year = 1880:1882)
#'
#' # Use the latest available year.
#' igo_state_membership("ZAN")[, 1:7]
#'
#' # Search by state code.
#' igo_state_membership("2", year = 1865)
#'
#' # Extract multiple membership statuses.
#' igo_state_membership("kosovo", status = c(
#'   "Associate Membership", "Observer",
#'   "Full Membership"
#' ))
#'
#' # Vectorized search.
#' igo_state_membership(c("usa", "spain"), year = 1870:1871)
#'
#' # Use the countrycode package to add codes.
#' if (requireNamespace("countrycode", quietly = TRUE)) {
#'   library(countrycode)
#'   IT <- igo_state_membership("Italy", year = 1880)
#'   IT$iso3c <- countrycode(IT$ccode, origin = "cown", destination = "iso3c")
#'   head(IT)
#' }
igo_state_membership <- function(
  state,
  year = NULL,
  status = "Full Membership"
) {
  # Require an explicit state identifier.
  if (missing(state)) {
    stop("`state` must be supplied.")
  }

  df_states <- suppressWarnings(igoR::igo_search_states(state))

  if (is.null(df_states)) {
    warning(
      "Unknown values for `state`: ",
      paste0("'", state, "'", collapse = ", "),
      "."
    )
    return(invisible(NULL))
  }

  # Use state names that match `state_year_format3`.
  state_names <- as.character(df_states$state)

  levls <- igo_status_levels(igo_recode_igoyear)
  igo_warn_invalid_status(status, levls)

  # Keep one lookup result for each matched state.
  find_v <- lapply(
    state_names,
    igo_state_mmb_single,
    year = year,
    status = status
  )

  igo_bind_results(
    find_v,
    "No IGO membership records were found for the supplied arguments."
  )
}

igo_state_mmb_single <- function(state_names, year, status) {
  state_db <- igoR::state_year_format3

  state_db <- state_db[tolower(state_db$state) %in% tolower(state_names), ]

  if (is.null(year)) {
    year <- max(state_db$year)
  }

  year <- sort(unique(year))
  ccode <- state_db$ccode[1]

  # Build the requested country-year combinations.
  master_db <- expand.grid(ccode = ccode, year = year, stringsAsFactors = FALSE)

  igo_db2 <- merge(state_db, master_db)[, c("ccode", "year", "state")]

  if (nrow(igo_db2) == 0) {
    dates <- range(state_db$year, na.rm = TRUE)
    message(
      "State '",
      state_names,
      "' is available from ",
      paste0(dates, collapse = " to "),
      "."
    )
    return(NULL)
  }

  # Add IGO-level membership status for the state.
  state_igo <- igoR::igo_year_format3
  init_cols <- c(
    "ioname",
    "orgname",
    "year",
    "longorgname",
    "political",
    "social",
    "economic",
    state_names
  )

  state_igo <- state_igo[, tolower(init_cols)]
  colnames(state_igo) <- c(
    "ioname",
    "orgname",
    "year",
    "longorgname",
    "political",
    "social",
    "economic",
    "value"
  )
  state_igo$category <- igo_recode_igoyear(state_igo$value)

  # Join membership status to the requested country-year combinations.
  igo_w_year <- merge(igo_db2, state_igo)
  igo_w_year <- igo_w_year[igo_w_year$category %in% status, ]

  if (nrow(igo_w_year) == 0) {
    message(
      "No membership records for state '",
      state_names,
      "' matched the supplied arguments."
    )
    return(NULL)
  }

  # Add final state metadata.
  df_states <- igoR::igo_search_states(state_names)
  cntriesend <- merge(igo_w_year, df_states)

  # Arrange columns for the public return value.
  rearcol <- c(
    "ccode",
    "stateabb",
    "statenme",
    "state",
    "year",
    "ioname",
    "value",
    "category",
    "orgname",
    "longorgname",
    "political",
    "social",
    "economic"
  )

  cntriesend <- cntriesend[, rearcol]

  cntriesend <- cntriesend[
    order(cntriesend$year, cntriesend$category, cntriesend$ioname),
  ]

  igo_reset_rows(cntriesend)
}
