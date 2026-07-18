#' Find Correlates of War state codes, abbreviations and names
#'
#' @name igo_search_states
#'
#' @description
#' Finds Correlates of War country codes, abbreviations and names for states.
#'
#' @param state A state name or code, or a vector of names or codes, as
#'   specified in [states2016].
#'
#' @returns
#' A [`data.frame`][data.frame()] with Correlates of War country codes,
#' abbreviations, names and the matching `state` identifiers used by
#' [state_year_format3].
#'
#' @inherit igo_members source references
#'
#' @seealso [states2016].
#'
#' @family query functions
#'
#' @export
#' @encoding UTF-8
#'
#' @examplesIf requireNamespace("dplyr", quietly = TRUE)
#' library(dplyr)
#'
#' igo_search_states("Spain") %>% as_tibble()
#'
#' igo_search_states(c(20, 150)) %>% as_tibble()
#'
#' igo_search_states("congo") %>% as_tibble()
#'
#' igo_search_states(c("Germany", "papal states")) %>% as_tibble()
#'
#' igo_search_states(c("FRN", "United Kingdom", 240, "italy")) %>% as_tibble()
igo_search_states <- function(state) {
  # Keep one lookup result for each input value.
  find_v <- lapply(state, igo_search_state_single)

  igo_bind_results(find_v, "No states were found for the supplied arguments.")
}

igo_search_state_single <- function(state) {
  df_states <- cow_cntr_codes()
  matches <- lapply(df_states, function(column) {
    match(tolower(state), tolower(column))
  })
  find_state <- sort(unique(unlist(matches, use.names = FALSE)))[1]

  if (is.na(find_state)) {
    message(
      "Unknown value for `state`: ",
      paste0("'", state, "'", collapse = ", "),
      "."
    )
    return(invisible(NULL))
  }

  df_states[find_state, ]
}
