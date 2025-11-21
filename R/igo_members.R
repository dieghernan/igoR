#' Extract members of an IGO
#'
#' @name igo_members
#'
#' @description
#' Extract all the countries belonging to an IGO on a specific date.
#'
#' @return A [`data.frame`][data.frame()].
#'
#' @inherit igo_dyadic source references
#'
#' @seealso
#' [igo_year_format3], [igo_search()], [state_year_format3].
#'
#' @export
#'
#' @param ioname Any valid `ioname` of an IGO as specified on
#'   [igo_year_format3]. It could be also a vector of IGOs.
#' @param year Year to be assessed, an integer or an array of year. If `NULL`
#'   the latest year available of the IGO would be extracted.
#' @param status Character or vector with the membership status to be extracted.
#'   See **Details** on [state_year_format3].
#'
#' @examples
#' library(dplyr)
#' igo_members("EU", year = 1993) %>% as_tibble()
#' igo_members("EU") %>% as_tibble()
#' igo_members("NAFTA", year = c(1995:1998)) %>% as_tibble()
#'
#' # Extract different status
#' igo_members("ACCT", status = c("Associate Membership", "Observer")) %>%
#'   as_tibble()
#'
#' # States no members of the UN
#' igo_members("UN", status = "No Membership") %>%
#'   as_tibble()
#'
#' # Vectorized
#' igo_members(c("NAFTA", "EU"), year = 1993) %>%
#'   as_tibble() %>%
#'   arrange(state)
#'
#' # Use countrycodes package to get additional codes
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
  # Checks
  if (missing(ioname)) {
    stop("You must enter a value on 'ioname'")
  }

  levls <- levels(igo_recode_stateyear(1))
  levls <- levls[!is.na(levls)]
  checkstatus <- match(status, levls)
  if (isTRUE(anyNA(checkstatus))) {
    warning(
      "status ",
      paste0("'", status[is.na(checkstatus)], "'", collapse = ", "),
      " not valid. Valid values are ",
      paste0("'", levls, collapse = "', "),
      "'"
    )
  }

  # Find vectorized
  find_v <- lapply(ioname, igo_member_single, year = year, status = status)

  # Check results
  has_results <- vapply(find_v, is.null, logical(1))

  # Clean
  clean <- find_v[!has_results]
  if (length(clean) < 1) {
    warning("No IGO results found with the required parameters")
    return(invisible(NULL))
  }

  end <- do.call("rbind", clean)
  rownames(end) <- NULL
  end
}


igo_member_single <- function(ioname, year, status) {
  igo_db <- igoR::igo_year_format3

  igo_db <- igo_db[tolower(igo_db$ioname) %in% tolower(ioname), ]

  if (nrow(igo_db) == 0) {
    message("ioname '", ioname, "' not found in data base")
    return(NULL)
  }

  if (is.null(year)) {
    year <- max(igo_db$year)
  }

  year <- sort(unique(year))
  ioname <- igo_db$ioname[1]

  # Master db
  master_db <- expand.grid(
    ioname = ioname,
    year = year,
    stringsAsFactors = FALSE
  )

  igo_db2 <- merge(igo_db, master_db)[, c("ioname", "year", "orgname")]

  if (nrow(igo_db2) == 0) {
    dates <- range(igo_db$year, na.rm = TRUE)
    message(
      "ioname '",
      ioname,
      "' only alive between ",
      paste0(dates, collapse = " and ")
    )
    return(NULL)
  }

  # Get members
  state_igo <- igoR::state_year_format3
  state_igo <- state_igo[, tolower(c("ccode", "state", "year", ioname))]
  colnames(state_igo) <- c("ccode", "state", "year", "value")
  state_igo$ioname <- as.character(ioname)
  state_igo$category <- igo_recode_stateyear(state_igo$value)

  # Merge with igo_db

  igo_w_year <- merge(igo_db2, state_igo)
  igo_w_year <- igo_w_year[igo_w_year$category %in% status, ]

  if (nrow(igo_w_year) == 0) {
    message(
      "No members for ioname '",
      ioname,
      "' with the parameters provided."
    )
    return(NULL)
  }

  # Last bits
  dfnames <- cow_country_codes[, c("ccode", "statenme")]
  cntriesend <- merge(igo_w_year, dfnames)
  # Rearrange columns
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
    order(
      cntriesend$year,
      cntriesend$category,
      cntriesend$ccode
    ),
  ]

  rownames(cntriesend) <- NULL
  cntriesend
}
