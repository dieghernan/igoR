#' Finds codes and names of a state
#'
#' @name igo_search_states
#'
#' @description
#' Extract all the memberships of a state on a specific date.
#'
#' @seealso [states2016()].
#'
#' @inherit igo_members source references return
#'
#' @param state Any valid name or code of a state as specified on
#'   [states2016()]. It could be also an array of states.
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
#' @export
igo_search_states <- function(state) {
  # Vectorize

  find_v <- lapply(state, function(x) {
    # Lookup
    find_state <- vector(mode = "numeric")
    # Search state
    df_states <- cow_country_codes

    for (i in seq_len(ncol(df_states))) {
      find_state <- sort(unique(
        c(find_state, match(tolower(x), tolower(df_states[, i])))
      ))
    }

    find_state <- sort(find_state)[1]

    if (is.na(find_state)) {
      message("state not found: ", paste0("'", x, "'", collapse = ", "))
      return(invisible(NULL))
    }

    df_states <- df_states[find_state, ]

    df_states
  })

  # Check results
  has_results <- vapply(find_v, is.null, logical(1))

  # Clean
  clean <- find_v[!has_results]
  if (length(clean) < 1) {
    warning("No states found with required parameters")
    return(invisible(NULL))
  }

  end <- do.call("rbind", clean)
  rownames(end) <- NULL
  end
}
