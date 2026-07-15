#' Search for IGOs
#'
#' @name igo_search
#'
#' @description
#' Searches for IGOs by name or regular expression.
#'
#' @param pattern A [regular expression][base::regex] used to match IGO names
#'   and identifiers. If `NULL`, all IGOs in [igo_year_format3] are returned.
#'   Integer values are accepted.
#' @param exact A logical value. If `TRUE`, `pattern` is anchored to require a
#'   complete match.
#'
#' @returns
#' A [`data.frame`][data.frame()] with IGO identifiers, names, dates and other
#' metadata from the latest available year for each IGO.
#'
#' @details
#' The information for each IGO is retrieved from the latest year available in
#' [igo_year_format3].
#'
#' The `label` column provides a cleaned version of `longorgname`.
#'
#' @inherit igo_members source references
#'
#' @seealso [igo_year_format3].
#'
#' @family query functions
#'
#' @export
#' @encoding UTF-8
#'
#' @examplesIf requireNamespace("dplyr", quietly = TRUE)
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
#' # Search by numeric identifier.
#' igo_search(10) %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' igo_search(10, exact = TRUE) %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' # Search with a regular expression.
#' igo_search("NAFTA|UN|EU") %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' # Search for several exact identifiers.
#' igo_search("^NAFTA$|^UN$|^EU$") %>%
#'   select(ionum:orgname) %>%
#'   tibble()
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

  # Put primary identifiers before the remaining metadata.
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

    # Search across IGO names and identifiers.
    lon <- grep(pattern, db_end$longorgname, ignore.case = TRUE)
    lon <- c(lon, grep(pattern, db_end$orgname, ignore.case = TRUE))
    lon <- c(lon, grep(pattern, db_end$ioname, ignore.case = TRUE))
    lon <- c(lon, grep(pattern, as.character(db_end$ionum)))

    lon <- sort(unique(lon))

    if (length(lon) > 0) {
      db_end <- db_end[lon, ]
    } else {
      warning("No IGOs matched `pattern`: '", pattern, "'.")
      return(invisible(NULL))
    }
  }
  igo_reset_rows(db_end)
}
