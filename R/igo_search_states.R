#' @title Finds codes and names of a state
#' @name igo_search_states
#' @description Extract all the memberships of a state on a specific date.
#' @return A dataframe.
#' @seealso [states2016()].
#'
#' @param state Any valid name or code of a state as specified on
#' [states2016()]. It could be also an array of states.
#'
#' @examples
#' igo_search_states("Spain")
#'
#' igo_search_states(c(20, 150))
#'
#' igo_search_states("congo")
#'
#' igo_search_states(c("Germany", "papal states"))
#'
#' igo_search_states(c("FRN", "United Kingdom", 240, "italy"))
#' @export
igo_search_states <- function(state) {
  # Search state
  df_states <- cow_country_codes

  # Vectorize

  if (length(state) == 1) {
    # Lookup
    find_state <- vector(mode = "numeric")

    for (i in seq_len(ncol(df_states))) {
      find_state <-
        sort(unique(c(
          find_state, match(tolower(state), tolower(df_states[, i]))
        )))
    }

    find_state <- sort(find_state)[1]

    if (is.na(find_state)) {
      stop(
        "state not found: ",
        paste0("'",
          state[1],
          "'",
          collapse = ", "
        )
      )
    }

    df_states <- df_states[find_state, ]

    return(df_states)
  } else {
    # Vectorized ----
    df <- igo_search_states(state[1])
    dflen <- seq_len(length(state))[-1]

    for (i in dflen) {
      df <-
        rbind(df, igo_search_states(state[i]))
    }

    return(df)
  }
}
