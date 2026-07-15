#' IGO-year membership data
#'
#' @name igo_year_format3
#' @docType data
#'
#' @description
#' Data on intergovernmental organizations (IGOs) from 1816 to 2014 at the
#' IGO-year level. Each row represents one IGO in one year. Years are recorded
#' at five-year intervals through 1965 and annually thereafter.
#'
#' @format
#' A [`data.frame`][data.frame()] with
#' `r prettyNum(nrow(igoR::igo_year_format3), big.mark = ",")` rows. Relevant
#' fields:
#'
#' - `ioname`: Short abbreviation for the IGO name.
#' - `orgname`: Full IGO name.
#' - `year`: Calendar year.
#' - `afghanistan...zimbabwe`: Membership status of each state in the IGO. See
#'   the **Details** section.
#' - `sdate`: Start year for the IGO.
#' - `deaddate`: End year for the IGO.
#' - `longorgname`: Longer IGO name, including previous names.
#' - `ionum`: IGO identifier in versions 2.1 and 3.0 of the data.
#' - `version`: Correlates of War version number.
#'
#' @details
#' Possible values for the status of a state in the IGO are:
#'
#' ```{r, echo=FALSE}
#'
#' tb <- data.frame(
#'   "Category" = c(
#'     "No Membership", "Full Membership", "Associate Membership",
#'     "Observer", "Missing data", "State Not System Member"
#'   ),
#'   "Numerical" = c(0, 1, 2, 3, -9, -1)
#' )
#'
#' knitr::kable(tb, col.names = c("**Category**", "**Numerical value**"))
#'
#' ```
#'
#' Use [igo_recode_igoyear()] to recode the numerical values as
#' [factors][base::factor].
#'
#' @inherit igo_dyadic references
#'
#' @source
#' [Intergovernmental Organizations
#' (version 3)](https://correlatesofwar.org/data-sets/IGOs/), IGO Data Stata
#' Files from the Correlates of War Project.
#'
#' See the [Codebook Version 3 IGO
#' Data](https://correlatesofwar.org/data-sets/IGOs/) for the full reference.
#'
#' @family data sets
#' @keywords datasets
#' @concept datasets
#'
#' @note Data distributed with \CRANpkg{igoR}.
#'
#' @encoding UTF-8
#'
#' @examplesIf requireNamespace("dplyr", quietly = TRUE)
#' data("igo_year_format3")
#'
#' # Show a glimpse.
#' library(dplyr)
#'
#' igo_year_format3 %>%
#'   select(ioname:year, spain, france) %>%
#'   filter(year > 1990) %>%
#'   glimpse()
#'
#' # Prepare a sample of numerical membership values.
#' sample_igo_year <- igo_year_format3 %>%
#'   as_tibble() %>%
#'   select(ioname:year, spain, france) %>%
#'   filter(year == 1990)
#'
#' sample_igo_year %>% glimpse()
#'
#' # Recode the membership columns.
#' sample_igo_year_recoded <- sample_igo_year %>%
#'   mutate(across(c(spain, france), igo_recode_igoyear))
#'
#' sample_igo_year_recoded %>% glimpse()
NULL

#' Country-year IGO membership data
#'
#' @name state_year_format3
#' @docType data
#'
#' @description
#' Data on IGO membership from 1816 to 2014 at the country-year level. Each row
#' represents one country in one year. Years are recorded at five-year
#' intervals through 1965 and annually thereafter.
#'
#' @format
#' A [`data.frame`][data.frame()] with
#' `r prettyNum(nrow(igoR::state_year_format3), big.mark=",")` rows. Relevant
#' fields:
#'
#' - `ccode`: Correlates of War country number. See [states2016].
#' - `year`: Calendar year.
#' - `state`: Abbreviated state name, identical to variable names in
#'   [igo_year_format3].
#' - `aaaid...wassen`: IGO variables containing state membership status. See
#'   the **Details** section.
#'
#' @details
#' Possible values for the status of a state in the IGO are:
#'
#' ```{r, echo=FALSE}
#'
#' tb <- data.frame(
#'   "Category" = c(
#'     "No Membership", "Full Membership", "Associate Membership",
#'     "Observer", "Missing data", "IGO Not In Existence"
#'   ),
#'   "Numerical" = c(0, 1, 2, 3, -9, -1)
#' )
#'
#' knitr::kable(tb, col.names = c("**Category**", "**Numerical value**"))
#'
#' ```
#'
#' Use [igo_recode_stateyear()] to recode the numerical values as
#' [factors][base::factor].
#'
#' See the [Codebook Version 3 IGO
#' Data](https://correlatesofwar.org/data-sets/IGOs/).
#'
#' @inherit igo_year_format3 source references note
#'
#' @seealso
#' [countrycode::countrycode()] to convert between different country code
#' schemes.
#'
#' @family data sets
#' @keywords datasets
#' @concept datasets
#'
#' @encoding UTF-8
#'
#' @examplesIf requireNamespace("dplyr", quietly = TRUE)
#' data("state_year_format3")
#' dplyr::tibble(state_year_format3)
NULL

#' State system membership (v2016)
#'
#' @name states2016
#' @docType data
#'
#' @description
#' A list of states with Correlates of War abbreviations and identifiers, plus
#' the `state` field from [state_year_format3].
#'
#' @format
#' A [`data.frame`][data.frame()] with
#' `r prettyNum(nrow(igoR::states2016), big.mark=",")` rows and 11 variables:
#'
#' \describe{
#'   \item{`ccode`}{COW state number.}
#'   \item{`stateabb`}{COW state abbreviation.}
#'   \item{`statenme`}{Primary COW state name.}
#'   \item{`styear`}{Beginning year of state tenure.}
#'   \item{`stmonth`}{Beginning month of state tenure.}
#'   \item{`stday`}{Beginning day of state tenure.}
#'   \item{`endyear`}{Ending year of state tenure.}
#'   \item{`endmonth`}{Ending month of state tenure.}
#'   \item{`endday`}{Ending day of state tenure.}
#'   \item{`version`}{Data file version number.}
#'   \item{`state`}{Abbreviated state name as it appears in
#'     `state_year_format3`.}
#' }
#'
#' @details
#' This data set contains the states in the international system as updated and
#' distributed by the Correlates of War Project.
#'
#' It identifies states, their standard Correlates of War country code or state
#' number, state abbreviations and dates of membership as states and major
#' powers in the international system.
#'
#' The Correlates of War Project includes a state in the international system
#' from 1816 to 2016 according to the following criteria:
#'
#' - **Before 1920**, the entity must have had a population greater than
#'   500,000 and have had diplomatic missions at or above the rank of chargé
#'   d'affaires with Britain and France.
#'
#' - **After 1920**, the entity must be a member of the League of Nations or the
#'   United Nations, or have a population greater than 500,000 and receive
#'   diplomatic missions from two major powers.
#'
#' @source
#' [State System Membership
#' (v2016)](https://correlatesofwar.org/data-sets/state-system-membership/).
#' The Correlates of War Project.
#'
#' @references
#' Correlates of War Project. 2017. "State System Membership List, v2016."
#' Online, <https://correlatesofwar.org/>.
#'
#' @family data sets
#' @keywords datasets
#' @concept datasets
#'
#' @note
#' The `state` variable was added to the original data to support comparisons
#' across data sets in this package.
#'
#' @encoding UTF-8
#'
#' @examplesIf requireNamespace("dplyr", quietly = TRUE)
#' data("states2016")
#' dplyr::glimpse(states2016)
NULL
