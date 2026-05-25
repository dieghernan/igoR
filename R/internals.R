igo_bind_results <- function(
  results,
  warning_message,
  warning_call = sys.call(-1)
) {
  empty <- vapply(results, is.null, logical(1))
  clean <- results[!empty]

  if (length(clean) < 1) {
    warning(simpleWarning(warning_message, call = warning_call))
    return(invisible(NULL))
  }

  igo_reset_rows(do.call("rbind", clean))
}

igo_reset_rows <- function(x) {
  row.names(x) <- NULL
  x
}

igo_status_levels <- function(recode_fun) {
  levels <- levels(recode_fun(1))
  levels[!is.na(levels)]
}

igo_warn_invalid_status <- function(
  status,
  valid_status,
  warning_call = sys.call(-1)
) {
  invalid <- is.na(match(status, valid_status))

  if (isTRUE(any(invalid))) {
    warning(simpleWarning(
      paste0(
        "Invalid `status` value(s): ",
        paste0("'", status[invalid], "'", collapse = ", "),
        ". Valid values are ",
        paste0("'", valid_status, collapse = "', "),
        "'."
      ),
      call = warning_call
    ))
  }
}

igo_last_year_rows <- function(db, id_column) {
  db_last <- db[, c(id_column, "year")]
  db_lastyear <- aggregate(
    db_last,
    by = list(db_last[[id_column]]),
    FUN = max
  )
  db_lastyear <- db_lastyear[, c(id_column, "year")]

  merge(db, db_lastyear)
}
