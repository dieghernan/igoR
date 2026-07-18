#' Extract dyad-year joint IGO membership
#'
#' @name igo_dyadic
#'
#' @description
#' Creates dyad-year IGO data. Each row represents a pair of states in one year
#' and summarizes their joint memberships across IGOs.
#'
#' @param country1,country2 A state or vector of states to compare. Each value
#'   can be any state name or Correlates of War code in [states2016].
#' @param year An integer or vector of years to assess.
#' @param ioname An optional IGO identifier or vector of identifiers. If `NULL`
#'   (the default), all IGOs are included. Use [igo_search()] to find valid
#'   identifiers.
#'
#' @returns
#' A coded [`data.frame`][data.frame()] with one row per state pair and year and
#' one column per selected IGO. See **Details** for the membership status
#' coding scheme.
#'
#' @details
#' The arguments `country1` and `country2` are named for compatibility with
#' earlier versions of **igoR**. Values are matched against states in
#' [states2016].
#'
#' This function reproduces the structure of the original dyad-year file
#' distributed by the Correlates of War Project
#' (`dyadic_format3.dta`). That file is not included in this package due to its
#' size.
#'
#' The result contains one row for each common dyad-year selected by `country1`,
#' `country2` and `year`.
#'
#' The `dyadid` column identifies each relationship and is computed as
#' `(1000 * ccode1) + ccode2`.
#'
#' For each selected IGO, the result includes a column named after its
#' lowercase identifier and uses this coding scheme:
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
#' knitr::kable(tb, col.names = c("**Category**", "**Numerical value**"))
#'
#' ```
#'
#' Use [igo_recode_dyadic()] to recode the numerical values as
#' [factors][base::factor].
#'
#' If one state in an IGO is a full member but the other is an associate member
#' or observer, that IGO is not coded as a joint membership.
#'
#' # Differences from the original data set
#'
#' For some IGOs, results differ from the original data set in the coding of
#' "Missing data" (`-9`) and "State Not System Member" (`-1`). The available
#' documentation does not fully specify how to reproduce those values.
#'
#' See [Codebook Version 3 IGO
#' Data](https://correlatesofwar.org/data-sets/IGOs/).
#'
#' @source
#' [Codebook Version 3 IGO
#' Data](https://correlatesofwar.org/data-sets/IGOs/) for the full
#' reference.
#'
#' @references
#' Pevehouse, J. C., Nordstrom, T., McManus, R. W. & Jamison, A. S. (2020).
#' Tracking organizations in the world: The Correlates of War IGO Version 3.0
#' data sets. *Journal of Peace Research*, **57**(3), 492–503.
#' \doi{10.1177/0022343319881175}.
#'
#' @seealso
#' [state_year_format3], [states2016], [igo_search()], [igo_recode_dyadic()].
#'
#' @family membership functions
#'
#' @export
#' @encoding UTF-8
#'
#' @examplesIf requireNamespace("dplyr", quietly = TRUE)
#' usa_esp <- igo_dyadic("USA", "Spain")
#' nrow(usa_esp)
#' ncol(usa_esp)
#'
#' dplyr::tibble(usa_esp)
#'
#' # Use custom arguments.
#' custom <- igo_dyadic(
#'   country1 = c("France", "Germany"), country2 = c("Sweden", "Austria"),
#'   year = 1992:1993, ioname = "EU"
#' )
#'
#' dplyr::glimpse(custom)
igo_dyadic <- function(country1, country2, year = 1816:2014, ioname = NULL) {
  # Require numeric years before building state combinations.
  if (!is.numeric(year)) {
    warning(
      "`year` must be numeric, not ",
      paste0(class(year), collapse = ", "),
      "."
    )
    return(invisible(NULL))
  }

  # Build the state-pair base for vectorized lookup.
  c1s <- suppressWarnings(igo_search_states(country1))
  c2s <- suppressWarnings(igo_search_states(country2))

  if (any(is.null(c1s), is.null(c2s))) {
    warning("No valid states were found for comparison.")
    return(invisible(NULL))
  }

  names(c1s) <- paste0(names(c1s), "1")
  names(c2s) <- paste0(names(c2s), "2")

  base_df <- expand.grid(
    state1 = unique(c1s$state1),
    state2 = unique(c2s$state2),
    stringsAsFactors = FALSE
  )

  # Remove self-pairs.
  base_df <- base_df[base_df$state1 != base_df$state2, ]

  if (nrow(base_df) == 0) {
    warning(
      "No distinct states were found between `country1` ",
      "and `country2`."
    )
    return(invisible(NULL))
  }

  # Keep one lookup result for each state pair.
  iter <- seq_len(nrow(base_df))

  find_v <- lapply(
    iter,
    igo_dyadic_single,
    base_df = base_df,
    year = year,
    ioname = ioname
  )

  igo_bind_results(
    find_v,
    "No dyad-year results were found for the supplied arguments."
  )
}

igo_dyadic_single <- function(iter, base_df, year, ioname) {
  # Limit output to valid IGO columns.
  all_igos <- igoR::state_year_format3

  ioname_ext <- tolower(colnames(all_igos))
  if (!is.null(ioname)) {
    ioname <- unique(tolower(ioname))
    colsel <- match(ioname, ioname_ext)
    ioname_ext <- ioname_ext[colsel[!is.na(colsel)]]
  }

  if (length(ioname_ext) == 0) {
    message(
      "Unknown values for `ioname`: ",
      paste0("'", ioname, "'", collapse = ", "),
      "."
    )
    return(NULL)
  }

  this_iter_df <- base_df[iter, ]

  # Keep selected years before comparing states.
  all_igos <- all_igos[all_igos$year %in% year, ]

  if (nrow(all_igos) == 0) {
    message("No IGO records were found for the selected years.")
    return(NULL)
  }

  # Build comparable state-by-IGO matrices.
  mat1 <- all_igos[all_igos$state == this_iter_df$state1, ]
  if (nrow(mat1) == 0) {
    message(
      "State '",
      this_iter_df$state1,
      "' was not in the state system in the selected years."
    )
    return(NULL)
  }
  mat2 <- all_igos[all_igos$state == this_iter_df$state2, ]
  if (nrow(mat2) == 0) {
    message(
      "State '",
      this_iter_df$state2,
      "' was not in the state system in the selected years."
    )
    return(NULL)
  }

  # Keep only years where both states are in the state system.
  ress <- table(c(mat1$year, mat2$year))
  fyear <- as.numeric(names(ress[ress == 2]))

  mat1_comp <- mat1[mat1$year %in% fyear, tolower(ioname_ext), drop = FALSE]
  mat2_comp <- mat2[mat2$year %in% fyear, names(mat1_comp), drop = FALSE]

  # Recode state memberships into joint membership values.
  mat_res <- recode_joint_matrix(mat1_comp, mat2_comp)
  end_igos <- as.data.frame(mat_res)
  colnames(end_igos) <- colnames(mat1_comp)

  # Add final dyad metadata.
  end_igos$year <- fyear
  c1 <- igo_search_states(this_iter_df$state1)[1, ]
  c2 <- igo_search_states(this_iter_df$state2)[1, ]

  end_igos$dyadid <- 1000 * c1$ccode + c2$ccode
  end_igos$ccode1 <- c1$ccode
  end_igos$statenme1 <- c1$statenme
  end_igos$state1 <- c1$state
  end_igos$stateabb1 <- c1$stateabb

  end_igos$ccode2 <- c2$ccode
  end_igos$statenme2 <- c2$statenme
  end_igos$state2 <- c2$state
  end_igos$stateabb2 <- c2$stateabb

  # Arrange metadata before IGO membership columns.
  reorder_col <- unique(c(
    "dyadid",
    "ccode1",
    "stateabb1",
    "statenme1",
    "state1",
    "ccode2",
    "stateabb2",
    "statenme2",
    "state2",
    "year",
    colnames(end_igos)
  ))
  end_igos <- end_igos[, reorder_col]

  end_igos <- end_igos[order(end_igos$year), ]
  igo_reset_rows(end_igos)
}

recode_joint_matrix <- function(mat1, mat2) {
  mat1 <- as.matrix(mat1)
  mat2 <- as.matrix(mat2)
  mat_res <- matrix(-9, nrow = nrow(mat1), ncol = ncol(mat1))

  both_full_members <- mat1 == 1 & mat2 == 1
  has_missing <- mat1 == -9 | mat2 == -9
  state_not_system_member <- !has_missing & (mat1 == -1 | mat2 == -1)
  has_membership_status <- matrix(
    mat1 %in% c(0, 2, 3) | mat2 %in% c(0, 2, 3),
    nrow = nrow(mat1)
  )
  no_joint_membership <- !both_full_members &
    !has_missing &
    !state_not_system_member &
    has_membership_status

  mat_res[which(both_full_members)] <- 1
  mat_res[which(state_not_system_member)] <- -1
  mat_res[which(no_joint_membership)] <- 0
  mat_res
}
