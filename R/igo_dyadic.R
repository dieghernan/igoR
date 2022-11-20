#' @title Extract the Joint Membership of a pair of Countries across IGOs.
#' @name igo_dyadic
#' @description Dyadic version of the data. The unit of observation is a dyad
#' of countries. It provides a summary of the joint memberships of two IGOs
#' over time.
#'
#' @return A coded data frame representing the years and country dyad (rows)
#' and the IGOs selected (columns). See Details
#' @seealso [state_year_format3],  [states2016],
#' [igo_search()].
#' @source [**Codebook Version 3
#' IGO Data**](https://correlatesofwar.org/data-sets/IGOs/) for full reference.
#' @references
#' Pevehouse, Jon CW, Timothy Nordstrom, Roseanne W McManus, and Anne Spencer
#' Jamison. "Tracking Organizations in the World: The Correlates of War
#' IGO Version 3.0 Datasets." *Journal of Peace Research* 57, no. 3
#' (May 2020): 492-503.
#'
#' @param country1 A single state, used as a base of comparison. It could be
#' any valid name or code of a state as specified on [states2016].
#' @param country2 A state of vector of states to be compared with
#' `country1`.
#' @param year Year to be assessed, an integer or an array of year.
#' @param ioname Optional. `ioname` or vector of `ioname`
#' corresponding to the IGOs to be assessed. If `NULL` (the default),
#' all IGOs would be extracted. See codes on [igo_search()].
#' @details
#' This function tries to replicate the information contained in the original
#' file distributed by The Correlates of War Project
#' (`dyadic_format3.dta`). That file is not included in this package due
#' to its size.
#'
#' The result is a data frame containing the common years of the states
#' selected via `country1, country2, year` by rows.
#'
#' An additional column `dyadid`, computed as `(1000*ccode1)+ccode2`
#' is provided in order to identify relationships.
#'
#' For each IGO selected via `ioname` (or all if the default
#' option has been used) a column (using lowercase `ioname` as
#' identifier) is provided with the following code system:
#' \tabular{cc}{
#'   **Category** \tab **Numerical Value**\cr
#'     No Joint Membership \tab 0 \cr
#'     Joint Full Membership \tab 1 \cr
#'     Missing data \tab -9 \cr
#'     State Not System Member \tab -1 \cr
#'     }
#' If one state in an IGO is a full member but the other is an associate
#' member or observer, that IGO is not coded as a joint membership.
#'
#'  **Differences with the original dataset**
#'
#'  There are some differences on the results provided by this function and the
#'  original dataset on some IGOs regarding the "Missing Data" (-9) and
#'  "State Not System Member" (-1). However it is not clear how to fully
#'  replicate those values.
#'
#' See
#' [**Codebook Version 3 IGO Data**](https://correlatesofwar.org/data-sets/IGOs/)
#'
#'
#' @export
#' @examples
#' USA_CAN <- igo_dyadic("USA", "Spain")
#' nrow(USA_CAN)
#' ncol(USA_CAN)
#'
#' # Using custom parameters
#' igo_dyadic(
#'   country1 = "France",
#'   country2 =
#'     c("Sweden", "Austria"),
#'   year = 1992:1995,
#'   ioname = "EU"
#' )
igo_dyadic <- function(country1,
                       country2,
                       year = 1816:2014,
                       ioname = NULL) {
  # Check countries
  if (length(country1) != 1) {
    stop("country1 should be a single value")
  }

  country1 <- igoR::igo_search_states(country1)$stateabb
  country2 <- unique(igoR::igo_search_states(country2)$stateabb)

  # Initial clean up
  country2 <- country2[country2 != country1]

  if (length(country2) == 0) {
    stop(
      "Codes selected correspond to the same country: ",
      country1
    )
  }

  if (length(country2) == 1) {
    # Get IGO info

    all_igos <- igoR::state_year_format3

    min <- min(all_igos$year)
    max <- max(all_igos$year)

    # Filter by years

    all_igos <- all_igos[all_igos$year %in% year, ]

    # Check years

    if (nrow(all_igos) == 0) {
      stop(
        "The value(s) of year are not valid. Years range: ",
        min,
        " - ",
        max
      )
    }


    # Check ionames if selected

    if (!is.null(ioname)) {
      coligos <- colnames(all_igos)

      ioname <- unique(tolower(ioname))
      colsel <- match(ioname, coligos)

      if (anyNA(colsel)) {
        warning(
          "ioname(s) ",
          paste0("'",
            ioname[is.na(colsel)], "'",
            collapse = ","
          ),
          " not valid"
        )
      }

      if (all(is.na(colsel))) {
        stop("Execution halted. No valid ionames used.")
      }

      colsel <- c(1:2, colsel[!is.na(colsel)])
      all_igos <- all_igos[, colsel]
    }

    # Extract countries

    c1 <- igoR::igo_search_states(country1)
    c2 <- igoR::igo_search_states(country2)

    # nocov start
    if (c1$ccode == c2$ccode) {
      stop(
        "Codes selected correspond to the same country: ",
        c1$statenme
      )
    }
    # nocov end

    # Extract igos by country
    c1_igos <- all_igos[all_igos$ccode == c1$ccode, ]
    colnames(c1_igos) <- gsub("ccode", "ccode1", colnames(c1_igos))
    colnames(c1_igos) <- gsub("state", "state1", colnames(c1_igos))

    c2_igos <- all_igos[all_igos$ccode == c2$ccode, ]
    colnames(c2_igos) <- gsub("ccode", "ccode2", colnames(c2_igos))
    colnames(c2_igos) <- gsub("state", "state2", colnames(c2_igos))

    # Master table with common years
    master <- merge(c1_igos[, 1:2], c2_igos[, 1:2])
    master$dyadid <- master$ccode1 * 1000 + master$ccode2
    # Check
    if (nrow(master) == 0) {
      stop(
        "No common records on the years selected. ",
        "One country (or both) does not exist on that range.",
        "Countries selected: ",
        c1$statenme,
        ", ",
        c2$statenme
      )
    }

    # Refilter country tables
    c1_igos <- c1_igos[c1_igos$year %in% master$year, ]

    c2_igos <- c2_igos[c2_igos$year %in% master$year, ]


    # Recode table
    igos_colnames <- colnames(c1_igos)
    igos_colnames <-
      igos_colnames[!igos_colnames %in% c("ccode1", "year", "state1")]

    c1_matrix <- as.matrix(c1_igos[, igos_colnames])
    c2_matrix <- as.matrix(c2_igos[, igos_colnames])
    end_matrix <-
      matrix(
        data = NA,
        nrow = nrow(c1_matrix),
        ncol = ncol(c1_matrix)
      )
    colnames(end_matrix) <- igos_colnames

    dims <- dim(end_matrix)

    # Create coding
    for (r in seq_len(dims[1])) {
      for (c in seq_len(dims[2])) {
        vals <- c(c1_matrix[r, c], c2_matrix[r, c])

        if (any(vals == -9)) {
          finalvalue <- -9
        } else if (any(vals == -1)) {
          finalvalue <- -1
        } else if (all(vals == 1)) {
          finalvalue <- 1
        } else if (any(vals %in% c(0, 2, 3))) {
          finalvalue <- 0
        } else {
          # Safe coding
          # nocov start
          finalvalue <- -9
          # nocov end
        }

        end_matrix[r, c] <- finalvalue
      }
    }

    # Handle NAs
    end_matrix[is.na(end_matrix)] <- -9

    end_igos <- as.data.frame(end_matrix)
    end_igos$year <- master$year

    # Regenerate table
    colnames(c1) <- paste0(colnames(c1), 1)
    colnames(c2) <- paste0(colnames(c2), 2)

    master <- merge(master, c1)
    master <- merge(master, c2)
    master <- merge(master, end_igos)

    # Reorder rows and cols

    colorder <-
      unique(c("dyadid", colnames(c1), colnames(c2), colnames(master)))
    master <- master[, colorder]
    master <- master[order(master$year), ]

    rownames(master) <- NULL

    return(master)
  } else {
    # Vectorized part for country2----
    df <-
      igo_dyadic(
        country1 = country1,
        country2 = country2[1],
        year = year,
        ioname = ioname
      )

    dflen <- seq_len(length(country2))[-1]

    for (i in dflen) {
      df <-
        rbind(
          df,
          igo_dyadic(
            country1 = country1,
            country2 = country2[i],
            year = year,
            ioname = ioname
          )
        )
    }

    return(df)
  }
}
