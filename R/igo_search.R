#' @title Search and Find an IGO
#' @name igo_search
#' @description Search any IGO by name or string pattern.
#' @return A dataframe.
#' @seealso \code{\link{igo_year_format3}}
#'
#'
#' @param pattern regex pattern. If \code{NULL} the function returns a dataset
#' with all the IGOs on \code{\link{igo_year_format3}}. Integer values are
#' accepted.
#' @param exact Logical. When \code{TRUE} only exact matches are returned.
#' @details The information of each IGO is retrieved based on the last year
#' available on \code{\link{igo_year_format3}}.
#'
#' An additional column \code{label} is provided. This column is a clean
#' version of \code{longorgname}
#' @examples
#' # All values
#' all <- igo_search()
#'
#' nrow(all)
#' colnames(all)
#'
#' # Search by pattern
#' igo_search("EU")[, 1:3]
#'
#' igo_search("EU", exact = TRUE)[, 1:3]
#'
#' # With integers
#' igo_search(10)[, 1:3]
#'
#' igo_search(10, exact = TRUE)[, 1:3]
#'
#' # Several patterns (regex style)
#' igo_search("NAFTA|UN|EU")[, 1:3]
#'
#' # Several patterns Exact (regex style)
#' igo_search("^NAFTA$|^UN$|^EU$")[, 1:3]
#' @export
igo_search <- function(pattern = NULL, exact = FALSE) {
  db <- igoR::igo_year_format3

  # Select columns that not are countries
  cols <- !colnames(db) %in% c(unique(igoR::state_year_format3$state))
  db_clean <- db[, cols]

  # Extract last date
  db_last <- db_clean[, c("ioname", "year")]
  db_lastyear <-
    aggregate(db_last, by = list(db_last$ioname), FUN = max)
  db_lastyear <- db_lastyear[, c("ioname", "year")]

  db_end <- merge(db_clean, db_lastyear)

  # Create label column
  db_end$label <- db_end$longorgname

  db_end$label <- gsub("\\((.*?)\\)", "", db_end$label)
  db_end$label <- gsub("\\((.*?)$", "", db_end$label)
  db_end$label <- gsub("  ", " ", db_end$label)

  # Reorder col
  cols <-
    unique(c(
      "ionum",
      "ioname",
      "orgname",
      "longorgname",
      "label",
      colnames(db_end)
    ))
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
      stop("Pattern '", pattern, "' do not match with any IGO")
    }
  }
  row.names(db_end) <- NULL
  return(db_end)
}
