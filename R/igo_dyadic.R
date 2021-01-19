#' @title Extract the Joint Membership of a pair of Countries across IGOs.
#' @name igo_dyadic
#' @description Dyadic version of the data. The unit of observation is a dyad
#' of countries. It provides a summary of the joint memberships of two IGOs
#' over time.
#'
#' @return XXXXX
#' @seealso XXXXX
#' @export
#'
#' @param country1,country2,year,ioname XXXXX
igo_dyadic <- function(country1,
                       country2,
                       year = 1816:2014,
                       ioname = NULL) {
  # Check countries
  if (length(country1) != 1) {
    stop("country1 should be a single value")
  }

  # Initial clean up
  country2 <- country2[country2 != country1]

  if (length(country2) == 0) {
    stop("Equal values for country1 and country2 doesn't make sense")
  }

  if (length(country2) == 1) {
    # Helper df for memberships
    helpdf <- data.frame(
      category = c(
        "No Membership",
        "Full Membership",
        "Associate Membership",
        "Observer",
        "Missing Data",
        "State Not System Member"
      ),
      value = c(0, 1, 0, 0, -9, -1),
      stringsAsFactors = FALSE
    )

    # Extract Country1----
    c1 <- igo_state_membership(
      state = country1,
      year = year,
      status = c(
        "No Membership",
        "Full Membership",
        "Associate Membership",
        "Observer",
        "State Not System Member"
      )
    )

    c1$ioname <- tolower(c1$ioname)
    c1 <- merge(c1, helpdf)

    # Rearrange cols
    cols <-
      c("ccode",
        "stateabb",
        "statenme",
        "state",
        "value",
        "year",
        "ioname")

    c1 <- c1[, cols]
    colnames(c1) <-
      c(paste0(colnames(c1)[1:5], "1"), "year", "ioname")


    # Extract Country2----
    c2 <- igo_state_membership(
      state = country2,
      year = year,
      status = c(
        "No Membership",
        "Full Membership",
        "Associate Membership",
        "Observer",
        "State Not System Member"
      )
    )

    c2$ioname <- tolower(c2$ioname)

    if (c1[1, "statenme1"] == c2[1, "statenme"]) {
      stop(
        "country1 and country2 should be different values. ",
        "Both values correspond to ",
        c1[1, "statenme1"]
      )
    }

    c2 <- merge(c2, helpdf)

    # Rearrange cols
    c2 <- c2[, cols]
    colnames(c2) <-
      c(paste0(colnames(c2)[1:5], "2"), "year", "ioname")

    # Merge
    cend <- merge(c1, c2)

    # Check merge----

    if (nrow(cend) == 0) {
      stop(
        "No records for the query with the parameters provided. ",
        "Try changing the range of years or selecting more IGOs"
      )
    }

    # Data treatment----
    cend$ioname <- tolower(cend$ioname)
    cend$dyadid <- cend$ccode1 * 1000 + cend$ccode2

    # Assign values
    cend$value <- -9
    cend$value <- ifelse(cend$value1 == 1 & cend$value2 == 1, 1,
                         cend$value)
    cend$value <- ifelse(cend$value1 == 0 | cend$value2 == 0, 0,
                         cend$value)



    # Reshape
    cend <- cend[, c(
      "dyadid",
      "ccode1",
      "stateabb1",
      "state1",
      "ccode2",
      "stateabb2",
      "state2",
      "year",
      "ioname",
      "value"
    )]

    colnames(cend) <- c(
      "dyadid",
      "ccode1",
      " country1",
      "state1",
      "ccode2",
      "country2",
      "state2",
      "year",
      "ioname",
      "value"
    )



    # Add fake last rows with all the igos - complete data frame
    # This is done so when transposing all IGOs would be on columns

    all_igos <-
      data.frame(ioname = tolower(unique(igo_search()$ioname)),
                 stringsAsFactors = FALSE)
    # Fake year
    all_igos$year <- 9999

    # Key rows
    cols <- !colnames(cend) %in% c("ioname", "year", "value")
    key_rows <- unique(cend[, cols])

    # Repeat
    key_rows <- key_rows[rep(1, nrow(all_igos)), ]
    df_help <- cbind(key_rows, all_igos)
    df_help$value <- NA

    # Add to end
    cend <- rbind(cend, df_help)

    # Transpose data----
    cend <- cend[order(cend$ioname, cend$year), ]

    cend_t <- reshape(
      cend,
      timevar = "ioname",
      idvar = c(
        "dyadid",
        "ccode1",
        " country1",
        "state1",
        "ccode2",
        "country2",
        "state2",
        "year"
      ),
      direction = "wide"
    )

    cend_t <- cend_t[order(cend_t$year), ]
    coln <- gsub("value.", "", colnames(cend_t))

    colnames(cend_t) <- coln

    # Fill NA
    cend_t[is.na(cend_t)] <- -9

    # Finish dataset----

    # Filter fake year
    cend_t <- cend_t[cend_t$year != 9999, ]

    # Select columns
    if (!is.null(ioname)) {
      ioname <- tolower(ioname)


      coligos <- colnames(cend_t[, -c(1:8)])
      colsel <-  match(ioname, coligos)

      if (anyNA(colsel)) {
        warning("ioname(s) ", paste0("'",
                                    ioname[is.na(colsel)], "'", collapse = ","),
                " not valid")
      }

      if (all(is.na(colsel))) {
        stop("Execution halted. No valid ionames used.")
      }

      colsel <- colsel[!is.na(colsel)] + 8
      colselend <- c(1:8, colsel)

      cend_t <- cend_t[, colselend]
    }


    return(cend_t)

  } else {
    # Vectorized part for country2----
    df <-
      igo_dyadic(
        country1 = country1,
        country2 = country2[1],
        year = year,
        ioname = ioname
      )

    df <- df[order(df$year), ]

    dflen <- seq_len(length(country2))[-1]

    for (i in dflen) {
      dfnew <- igo_dyadic(
        country1 = country1,
        country2 = country2[i],
        year = year,
        ioname = ioname
      )
      dfnew <- dfnew[order(df$year), ]
      df <- rbind(df, dfnew)

    }

    return(df)
  }
}
