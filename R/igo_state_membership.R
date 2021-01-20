#' @title Extract Memberships of a State
#' @name igo_state_membership
#' @description Extract all the memberships of a state on a specific date.
#' @return A dataframe.
#' @seealso \code{\link{igo_year_format3}}, \code{\link{igo_search_states}},
#' \code{\link{states2016}}.
#' @export
#'
#' @param state Any valid name or code of a state as specified on
#' \code{\link{states2016}}. It could be also a vector of states
#' @param year Year to be assessed, an integer or an array of year.
#' If \code{NULL} the latest year available
#' of the state would be extracted.
#' @param status Character or vector with the membership status to be
#' extracted. See Details
#' on \code{\link{igo_year_format3}}.
#' @examples
#' # Memberships on two different dates
#' igo_state_membership("Spain", year = 1850)
#' igo_state_membership("Spain", year = 1870)
#' igo_state_membership("Spain", year = 1880:1882)
#'
#' # Last year
#' igo_state_membership("ZAN")[, 1:7]
#'
#' # Use codes to get countries
#' igo_state_membership("2", year = 1865)
#'
#' # Extract different status
#'
#' igo_state_membership("kosovo",
#'                      status = c("Associate Membership",
#'                      "Observer",
#'                      "Full Membership"))
#'
#' # Vectorized
#' igo_state_membership(c("usa", "spain"),
#'                      year = 1870:1871)
#'
#' # Use countrycodes package to get additional codes
#' if (requireNamespace("countrycode", quietly = TRUE)) {
#'   library(countrycode)
#'   IT <- igo_state_membership("Italy", year = 1880)
#'   IT$iso3c <- countrycode(IT$ccode, origin = "cown",
#'                           destination = "iso3c")
#'   head(IT)
#' }
#'
igo_state_membership <- function(state,
                                 year = NULL,
                                 status = "Full Membership") {
  # Checks

  if (missing(state)) {
    stop("You must enter a value on 'state'")
  }

  if (length(state) == 1) {
    ## A. States
    # Search state
    df_states <- igoR::igo_search_states(state)

    # Extract state
    state_names <- as.character(df_states$state)

    ## Check years
    df_mem <- igoR::state_year_format3
    df_mem <- df_mem[df_mem$state == state_names, ]

    interval <- c(min(df_mem$year), max(df_mem$year))

    if (is.null(year)) {
      year <- interval[2]
    }
    year <- sort(unique(as.integer(year)))
    yeardf <- data.frame(year = year,
                         check = NA)

    yeardf$check <- ifelse(yeardf$year %in% df_mem$year,
                           TRUE,
                           FALSE)


    df_mem <- df_mem[df_mem$year %in% year, ]

    if (nrow(df_mem) == 0) {
      stop(
        "year(s) ",
        paste0("'",
               as.character(yeardf[!yeardf$check, ]$year),
               "'", collapse = ", "),
        " not valid for ",
        df_states$statenme,
        ". Date should be any year between ",
        interval[1],
        " and ",
        interval[2]
      )
    }


    ## Memberships

    helpdf <- data.frame(
      category = c(
        "No Membership",
        "Full Membership",
        "Associate Membership",
        "Observer",
        "Missing Data",
        "State Not System Member"
      ),
      value = c(0, 1, 2, 3, -9, -1),
      stringsAsFactors = FALSE
    )


    checkstatus <- match(status, helpdf$category)
    if (isTRUE(anyNA(checkstatus))) {
      warning(
        "status ",
        paste0("'", status[is.na(checkstatus)], "'", collapse = ", "),
        " not valid. Valid values are ",
        paste0("'", helpdf$category, collapse = "', "),
        "'"
      )
    }

    if (all(is.na(checkstatus))) {
      stop("status values not valid")
    }



    # Extract igoS
    igos <- igoR::igo_year_format3
    igos <-
      igos[igos$year %in% year, tolower(
        c(
          "ioname",
          "orgname",
          "year",
          "longorgname",
          "political",
          "social",
          "economic",
          state_names
        )
      )]

    colnames(igos)[8] <- "value"

    igos$state <- as.character(state_names)

    codestatus <- helpdf[helpdf$category %in% status, ]


    igosend <- merge(igos, codestatus)
    igosend <- merge(igosend, df_states)

    # Rearrange columns
    rearcol <-
      unique(c(
        colnames(df_states),
        "year",
        "ioname",
        "category",
        colnames(igosend)
      ))

    rearcol <- rearcol[-match("value", rearcol)]
    igosend <- igosend[, rearcol]

    # Handle missing results

    if (nrow(igosend) == 0) {
      warning("No memberships for ",
              df_states$statenme,
              " on the year(s) selected")

      df_null <- igosend[seq_len(length(year)), ]
      df_null$year <- year
      df_null$ccode <- df_states$ccode
      df_null$stateabb <- df_states$stateabb
      df_null$statenme <- df_states$statenme
      df_null$state <- df_states$state


      igosend <- df_null
    }

    igosend <- igosend[order(igosend$ioname), ]
    igosend <- igosend[order(igosend$year), ]
    rownames(igosend) <- NULL

    return(igosend)

  } else {
    # Vectorized
    df <-
      igo_state_membership(state[1], year = year, status = status)
    dflen <- seq_len(length(state))[-1]

    for (i in dflen) {
      df <-
        rbind(df,
              igo_state_membership(state[i], year = year, status = status))
    }

    return(df)
  }
}
