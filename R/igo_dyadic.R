#' @title Extract the Joint Membership of a pair of Countries across IGOs.
#'
#' @name igo_dyadic
#'
#' @description
#' Dyadic version of the data. The unit of observation is a dyad of countries.
#' It provides a summary of the joint memberships of two countries across IGOs
#' over time.
#'
#' @return
#' A coded [`data.frame`][data.frame()] representing the years and country dyad
#' (rows) and the IGOs selected (columns). See **Details**.
#'
#' @seealso
#' [state_year_format3],  [states2016], [igo_search()].
#'
#' @source
#' [**Codebook Version 3
#' IGO Data**](https://correlatesofwar.org/data-sets/IGOs/) for full reference.
#'
#' @references
#' Pevehouse, J. C., Nordstrom, T., McManus, R. W., & Jamison, A. S. (2020).
#' Tracking organizations in the world: The Correlates of War IGO Version 3.0
#' datasets. *Journal of Peace Research, 57*(3), 492–503.
#' \doi{10.1177/0022343319881175}.
#'
#' @param country1,country2 A state of vector of states to be compared. It
#'   could be any valid name or code of a state as specified on [states2016].
#' @param year Year to be assessed, an integer or an array of year.
#' @param ioname Optional. `ioname` or vector of `ioname` corresponding to the
#'   IGOs to be assessed. If `NULL` (the default), all IGOs would be extracted.
#'   See codes on [igo_search()].
#'
#' @details
#' This function tries to replicate the information contained in the original
#' file distributed by The Correlates of War Project (`dyadic_format3.dta`).
#' That file is not included in this package due to its size.
#'
#' The result is a [`data.frame`][data.frame()] containing the common years of
#' the states selected via `country1, country2, year` by rows.
#'
#' An additional column `dyadid`, computed as `(1000*ccode1)+ccode2` is provided
#' in order to identify relationships.
#'
#' For each IGO selected via `ioname` (or all if the default option has been
#' used) a column (using lowercase `ioname` as identifier) is provided with the
#' following code system:
#'
#' ```{r, echo=FALSE}
#'
#' tb <- data.frame(
#'   "Category" = c(
#'     "No Joint Membership", "Joint Full Membership",
#'     "Missing data", "State Not System Member"
#'   ),
#'   "Numerical" = c(0, 1, -9, -1)
#' )
#'
#' knitr::kable(tb, col.names = c("**Category**", "**Numerical Value**"))
#'
#' ```
#'
#' See [igo_recode_dyadic()] section for an easy way to recode the numerical
#' values into [factors][base::factor].
#'
#' If one state in an IGO is a full member but the other is an associate member
#' or observer, that IGO is not coded as a joint membership.
#'
#'  # Differences with the original dataset
#'
#'  There are some differences on the results provided by this function and the
#'  original dataset on some IGOs regarding the "Missing Data" (`-9`) and
#'  "State Not System Member" (`-1`). However it is not clear how to fully
#'  replicate those values.
#'
#' See [**Codebook Version 3
#' IGO Data**](https://correlatesofwar.org/data-sets/IGOs/)
#'
#' @export
#'
#' @examples
#' usa_esp <- igo_dyadic("USA", "Spain")
#' nrow(usa_esp)
#' ncol(usa_esp)
#'
#' dplyr::tibble(usa_esp)
#'
#' # Using custom parameters
#' custom <- igo_dyadic(
#'   country1 = c("France", "Germany"), country2 = c("Sweden", "Austria"),
#'   year = 1992:1993, ioname = "EU"
#' )
#'
#' dplyr::glimpse(custom)
igo_dyadic <- function(country1, country2, year = 1816:2014, ioname = NULL) {
  # Check inputs
  if (!is.numeric(year)) {
    warning("year should be numeric, no ", paste0(class(year), collapse = ", "))
    return(invisible(NULL))
  }

  # Prepare base for applys
  c1s <- igo_search_states(country1)
  c2s <- igo_search_states(country2)

  if (any(is.null(c1s), is.null(c2s))) {
    warning("No country(ies) found for comparison")
    return(invisible(NULL))
  }

  names(c1s) <- paste0(names(c1s), "1")
  names(c2s) <- paste0(names(c2s), "2")

  base_df <- expand.grid(
    state1 = unique(c1s$state1),
    state2 = unique(c2s$state2),
    stringsAsFactors = FALSE
  )

  # Remove 1 to 1 comparisons
  base_df <- base_df[base_df$state1 != base_df$state2, ]


  if (nrow(base_df) == 0) {
    warning(
      "No different country(ies) found for comparison ",
      "in 'country','country2' values"
    )
    return(invisible(NULL))
  }

  # Find vectorized

  iter <- seq_len(nrow(base_df))

  find_v <- lapply(iter, igo_dyadic_single,
    base_df = base_df,
    year = year, ioname = ioname
  )

  # Check results
  has_results <- vapply(find_v, is.null, logical(1))

  # Clean
  clean <- find_v[!has_results]
  if (length(clean) < 1) {
    warning("No dyadic results found with the required parameters")
    return(invisible(NULL))
  }

  end <- do.call("rbind", clean)
  rownames(end) <- NULL
  end
}

igo_dyadic_single <- function(iter, base_df, year, ioname) {
  # Handle ioname
  all_igos <- igoR::state_year_format3

  ioname_ext <- tolower(colnames(all_igos))
  if (!is.null(ioname)) {
    ioname <- unique(tolower(ioname))
    colsel <- match(ioname, ioname_ext)
    ioname_ext <- ioname_ext[colsel[!is.na(colsel)]]
  }

  if (length(ioname_ext) == 0) {
    message(
      "No valid ionames used with ",
      paste0("'", ioname, "'", collapse = ", ")
    )
    return(NULL)
  }

  this_iter_df <- base_df[iter, ]


  # Filter with year
  all_igos <- all_igos[all_igos$year %in% year, ]

  if (nrow(all_igos) == 0) {
    message("No ionames found for years selected")
    return(NULL)
  }

  # Start getting matrixes for comparisons

  mat1 <- all_igos[all_igos$state == this_iter_df$state1, ]
  if (nrow(mat1) == 0) {
    message(
      "Country '", this_iter_df$state1,
      "' was not alive on years selected"
    )
    return(NULL)
  }
  mat2 <- all_igos[all_igos$state == this_iter_df$state2, ]
  if (nrow(mat2) == 0) {
    message(
      "Country '", this_iter_df$state2,
      "' was not alive on years selected"
    )
    return(NULL)
  }

  # Common years
  ress <- table(c(mat1$year, mat2$year))
  fyear <- as.numeric(names(ress[ress == 2]))

  mat1_comp <- mat1[mat1$year %in% fyear,
    tolower(ioname_ext),
    drop = FALSE
  ]
  mat2_comp <- mat2[mat2$year %in% fyear,
    names(mat1_comp),
    drop = FALSE
  ]


  # Create final matrix and iterate
  mat_res <- matrix(
    data = double(0),
    nrow = nrow(mat1_comp), ncol = ncol(mat2_comp)
  )


  n_cols <- seq_len(ncol(mat_res))
  n_rows <- seq_len(nrow(mat_res))


  for (i in n_rows) {
    for (j in n_cols) {
      vals <- c(mat1_comp[i, j], mat2_comp[i, j])

      finalvalue <- recode_joints(vals)
      mat_res[i, j] <- finalvalue
    }
  }

  # Handle NAs
  mat_res[is.na(mat_res)] <- -9

  end_igos <- as.data.frame(mat_res)
  colnames(end_igos) <- colnames(mat1_comp)

  # Last bits
  end_igos$year <- fyear
  c1 <- igo_search_states(this_iter_df$state1)[1, ]
  c2 <- igo_search_states(this_iter_df$state2)[1, ]

  end_igos$dyadid <- 1000 * c1$ccode + c1$ccode
  end_igos$ccode1 <- c1$ccode
  end_igos$statenme1 <- c1$statenme
  end_igos$state1 <- c1$state
  end_igos$stateabb1 <- c1$stateabb

  end_igos$ccode2 <- c2$ccode
  end_igos$statenme2 <- c2$statenme
  end_igos$state2 <- c2$state
  end_igos$stateabb2 <- c2$stateabb

  # Re-order columns
  reorder_col <- unique(c(
    "dyadid", "ccode1", "stateabb1", "statenme1", "state1", "ccode2",
    "stateabb2", "statenme2", "state2", "year", colnames(end_igos)
  ))
  end_igos <- end_igos[, reorder_col]

  end_igos <- end_igos[order(end_igos$year), ]
  rownames(end_igos) <- NULL
  end_igos
}

recode_joints <- function(vals) {
  finalvalue <- -9

  if (all(vals == 1)) {
    finalvalue <- 1
  } else if (any(vals == -9)) {
    finalvalue <- -9
  } else if (any(vals == -1)) {
    finalvalue <- -1
  } else if (any(vals %in% c(0, 2, 3))) {
    finalvalue <- 0
  }

  finalvalue
}
