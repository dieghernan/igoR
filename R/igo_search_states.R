#' Find state codes and names
#'
#' @name igo_search_states
#'
#' @description
#' Find COW codes, abbreviations and names for states.
#'
#' @param state Any valid state name or code as specified in [states2016]. This
#'   can also be a vector of states.
#'
#' @returns
#' A [`data.frame`][data.frame()] with COW country codes, abbreviations, names
#' and the matching `state` identifier used by [state_year_format3].
#'
#' @inherit igo_members source references
#'
#' @seealso [states2016].
#'
#' @family query functions
#'
#' @examples
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
#'
#' @encoding UTF-8
#' @export
igo_search_states <- function(state) {
  # Keep one lookup result for each input value.
  find_v <- lapply(state, igo_search_state_single)

  igo_bind_results(find_v, "No states found with the required arguments.")
}

igo_search_state_single <- function(state) {
  df_states <- cow_country_codes
  matches <- lapply(df_states, function(column) {
    match(tolower(state), tolower(column))
  })
  find_state <- sort(unique(unlist(matches, use.names = FALSE)))[1]

  if (is.na(find_state)) {
    message(
      "State value not found: ",
      paste0("'", state, "'", collapse = ", "),
      "."
    )
    return(invisible(NULL))
  }

  df_states[find_state, ]
}
