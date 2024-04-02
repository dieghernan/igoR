#' Extract memberships of a state
#'
#' @name igo_state_membership
#'
#' @description
#' Extract all the memberships of a state on a specific date.
#'
#' @return
#' A [`data.frame`][data.frame()].
#'
#' @seealso
#' [igo_year_format3], [igo_search_states()], [states2016].
#'
#' @export
#'
#' @inheritParams igo_search_states
#'
#' @param year Year to be assessed, an integer or an array of year. If `NULL`
#'   the latest year available of the state would be extracted.
#' @param status Character or vector with the membership status to be extracted.
#' See **Details** on [igo_year_format3].
#'
#' @examples
#' # Memberships on two different dates
#' igo_state_membership("Spain", year = 1850)
#' igo_state_membership("Spain", year = 1870)
#' igo_state_membership("Spain", year = 1880:1882)
#'
#' # Last year
#' igo_state_membership("ZAN")[, 1:7]
#'
#' # Use codes to get countries
#' igo_state_membership("2", year = 1865)
#'
#' # Extract different status
#' igo_state_membership("kosovo", status = c(
#'   "Associate Membership", "Observer",
#'   "Full Membership"
#' ))
#'
#' # Vectorized
#' igo_state_membership(c("usa", "spain"), year = 1870:1871)
#'
#' # Use countrycodes package to get additional codes
#' if (requireNamespace("countrycode", quietly = TRUE)) {
#'   library(countrycode)
#'   IT <- igo_state_membership("Italy", year = 1880)
#'   IT$iso3c <- countrycode(IT$ccode, origin = "cown", destination = "iso3c")
#'   head(IT)
#' }
igo_state_membership <- function(state, year = NULL,
                                 status = "Full Membership") {
  # Checks
  if (missing(state)) {
    stop("You must enter a value on 'state'")
  }

  df_states <- igoR::igo_search_states(state)

  if (is.null(df_states)) {
    warning(
      "state(s) ",
      paste0("'", state, "'", collapse = ", "),
      " not found in data base"
    )
    return(invisible(NULL))
  }

  # Extract state
  state_names <- as.character(df_states$state)

  levls <- levels(igo_recode_igoyear(1))
  levls <- levls[!is.na(levls)]
  checkstatus <- match(status, levls)
  if (isTRUE(anyNA(checkstatus))) {
    warning(
      "status ",
      paste0("'", status[is.na(checkstatus)], "'", collapse = ", "),
      " not valid. Valid values are ",
      paste0("'", levls, collapse = "', "), "'"
    )
  }

  # Find vectorized
  find_v <- lapply(state_names, igo_state_mmb_single,
    year = year,
    status = status
  )

  # Check results
  has_results <- vapply(find_v, is.null, logical(1))

  # Clean
  clean <- find_v[!has_results]
  if (length(clean) < 1) {
    warning("No states found with the required parameters")
    return(invisible(NULL))
  }

  end <- do.call("rbind", clean)
  rownames(end) <- NULL
  end
}

igo_state_mmb_single <- function(state_names, year, status) {
  state_db <- igoR::state_year_format3

  state_db <- state_db[tolower(state_db$state) %in% tolower(state_names), ]

  if (is.null(year)) {
    year <- max(state_db$year)
  }

  year <- sort(unique(year))
  ccode <- state_db$ccode[1]

  # Master db
  master_db <- expand.grid(
    ccode = ccode,
    year = year,
    stringsAsFactors = FALSE
  )

  igo_db2 <- merge(state_db, master_db)[, c("ccode", "year", "state")]

  if (nrow(igo_db2) == 0) {
    dates <- range(state_db$year, na.rm = TRUE)
    message(
      "state '", state_names, "' only alive between ",
      paste0(dates, collapse = " and ")
    )
    return(NULL)
  }

  # Get IGO state
  state_igo <- igoR::igo_year_format3
  init_cols <- c(
    "ioname", "orgname", "year", "longorgname",
    "political", "social", "economic", state_names
  )

  state_igo <- state_igo[, tolower(init_cols)]
  colnames(state_igo) <- c(
    "ioname", "orgname", "year", "longorgname",
    "political", "social", "economic", "value"
  )
  state_igo$category <- igo_recode_igoyear(state_igo$value)

  # Merge with igo_db
  igo_w_year <- merge(igo_db2, state_igo)
  igo_w_year <- igo_w_year[igo_w_year$category %in% status, ]

  if (nrow(igo_w_year) == 0) {
    message(
      "No IGOs for state '", state_names,
      "' with the parameters provided."
    )
    return(NULL)
  }

  # Last bits
  df_states <- igoR::igo_search_states(state_names)
  cntriesend <- merge(igo_w_year, df_states)
  # Rearrange columns
  rearcol <- c(
    "ccode", "stateabb", "statenme", "state",
    "year", "ioname", "value", "category", "orgname",
    "longorgname", "political", "social", "economic"
  )

  cntriesend <- cntriesend[, rearcol]

  cntriesend <- cntriesend[order(
    cntriesend$year, cntriesend$category,
    cntriesend$ioname
  ), ]

  rownames(cntriesend) <- NULL
  cntriesend
}
