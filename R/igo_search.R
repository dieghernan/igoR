#' Search for IGOs
#'
#' @name igo_search
#'
#' @description
#' Search for IGOs by name or regular expression pattern.
#'
#' @param pattern [regex][base::regex] pattern. If `NULL`, the function returns
#'   a data set with all IGOs in [igo_year_format3]. Integer values are
#'   accepted.
#' @param exact Logical. When `TRUE`, only exact matches are returned.
#'
#' @returns
#' A [`data.frame`][data.frame()] with IGO identifiers, names, dates and
#' metadata from the latest available year for each IGO.
#'
#' @details
#' The information for each IGO is retrieved from the last year available in
#' [igo_year_format3].
#'
#' An additional column, `label`, provides a clean version of `longorgname`.
#'
#' @inherit igo_members source references
#'
#' @seealso [igo_year_format3].
#'
#' @family query functions
#'
#' @examples
#' # Return all values.
#' library(dplyr)
#' all <- igo_search()
#'
#' all %>% tibble()
#'
#' # Search by pattern.
#' igo_search("EU") %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' igo_search("EU", exact = TRUE) %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' # Use integers.
#' igo_search(10) %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' igo_search(10, exact = TRUE) %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' # Use several patterns (regex style).
#' igo_search("NAFTA|UN|EU") %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' # Use several exact patterns (regex style).
#' igo_search("^NAFTA$|^UN$|^EU$") %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' @encoding UTF-8
#' @export
igo_search <- function(pattern = NULL, exact = FALSE) {
  db <- igoR::igo_year_format3

  # Keep IGO metadata columns.
  cols <- !colnames(db) %in% c(unique(igoR::state_year_format3$state))
  db_clean <- db[, cols]

  # Keep the latest available year for each IGO.
  db_end <- igo_last_year_rows(db_clean, "ioname")

  # Create a display label from the long organization name.
  db_end$label <- db_end$longorgname

  db_end$label <- gsub("\\((.*?)\\)", "", db_end$label)
  db_end$label <- gsub("\\((.*?)$", "", db_end$label)
  db_end$label <- gsub("  ", " ", db_end$label, fixed = TRUE)

  # Reorder columns.
  cols <- unique(c(
    "ionum",
    "ioname",
    "orgname",
    "longorgname",
    "label",
    colnames(db_end)
  ))

  cols <- cols[cols != "year"]
  db_end <- db_end[, cols]

  # Apply the search pattern across the main IGO identifiers.
  if (!is.null(pattern)) {
    pattern <- as.character(pattern)

    if (exact) {
      pattern <- paste0("^", pattern, "$")
    }

    # Search in the long name.
    lon <- grep(pattern, db_end$longorgname, ignore.case = TRUE)
    # Search in the organization name.
    lon <- c(lon, grep(pattern, db_end$orgname, ignore.case = TRUE))
    # Search in the IGO ID.
    lon <- c(lon, grep(pattern, db_end$ioname, ignore.case = TRUE))
    # Search in `ionum`.
    lon <- c(lon, grep(pattern, as.character(db_end$ionum)))

    lon <- sort(unique(lon))

    if (length(lon) > 0) {
      db_end <- db_end[lon, ]
    } else {
      warning("No IGOs matched pattern '", pattern, "'.")
      return(invisible(NULL))
    }
  }
  igo_reset_rows(db_end)
}
