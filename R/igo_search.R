#' @title Search and Find an IGO
#'
#' @name igo_search
#'
#' @description
#' Search any IGO by name or string pattern.
#'
#' @return
#' A [`data.frame`][data.frame()].
#'
#' @seealso [igo_year_format3]
#'
#' @param pattern [regex][base::regex] pattern. If `NULL` the function returns
#'   a dataset with all the IGOs on [igo_year_format3]. Integer values are
#'   accepted.
#' @param exact Logical. When `TRUE` only exact matches are returned.
#'
#' @details
#' The information of each IGO is retrieved based on the last year available on
#' [igo_year_format3].
#'
#' An additional column `label` is provided. This column is a clean version of
#' `longorgname`
#'
#' @examples
#' # All values
#' library(dplyr)
#' all <- igo_search()
#'
#' all %>% tibble()
#'
#' # Search by pattern
#' igo_search("EU") %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' igo_search("EU", exact = TRUE) %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' # With integers
#' igo_search(10) %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' igo_search(10, exact = TRUE) %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' # Several patterns (regex style)
#' igo_search("NAFTA|UN|EU") %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' # Several patterns Exact (regex style)
#' igo_search("^NAFTA$|^UN$|^EU$") %>%
#'   select(ionum:orgname) %>%
#'   tibble()
#'
#' @export
igo_search <- function(pattern = NULL, exact = FALSE) {
  db <- igoR::igo_year_format3

  # Select columns that not are countries
  cols <- !colnames(db) %in% c(unique(igoR::state_year_format3$state))
  db_clean <- db[, cols]

  # Extract last date
  db_last <- db_clean[, c("ioname", "year")]
  db_lastyear <- aggregate(db_last, by = list(db_last$ioname), FUN = max)
  db_lastyear <- db_lastyear[, c("ioname", "year")]

  db_end <- merge(db_clean, db_lastyear)

  # Create label column
  db_end$label <- db_end$longorgname

  db_end$label <- gsub("\\((.*?)\\)", "", db_end$label)
  db_end$label <- gsub("\\((.*?)$", "", db_end$label)
  db_end$label <- gsub("  ", " ", db_end$label)

  # Reorder col
  cols <- unique(
    c("ionum", "ioname", "orgname", "longorgname", "label", colnames(db_end))
  )

  cols <- cols[cols != "year"]
  db_end <- db_end[, cols]

  # Pattern
  if (!is.null(pattern)) {
    pattern <- as.character(pattern)

    if (exact) {
      pattern <- paste0("^", pattern, "$")
    }

    # Search in long name
    lon <- grep(pattern, db_end$longorgname, ignore.case = TRUE)
    # Search in org name
    lon <- c(lon, grep(pattern, db_end$orgname, ignore.case = TRUE))
    # Search in id
    lon <- c(lon, grep(pattern, db_end$ioname, ignore.case = TRUE))
    # Search on ionum
    lon <- c(lon, grep(pattern, as.character(db_end$ionum)))

    lon <- sort(unique(lon))

    if (length(lon) > 0) {
      db_end <- db_end[lon, ]
    } else {
      message("Pattern '", pattern, "' do not match with any IGO")
      return(invisible(NULL))
    }
  }
  row.names(db_end) <- NULL
  return(db_end)
}
