#' Intergovernmental Organizations (IGO) by year
#'
#' @name igo_year_format3
#'
#' @docType data
#'
#' @description
#' Data on IGOs from 1815-2014, at the IGO-year level. Contains one record per
#' IGO-year (with years listed at 5 year intervals through 1965, and annually
#' thereafter).
#'
#' @source
#' [Intergovernmental Organizations
#' (v3)](https://correlatesofwar.org/data-sets/IGOs/), The Correlates of War
#' Project (IGO Data Stata Files).
#'
#' @details
#' Possible value of the status of that state in the IGO are:
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
#' knitr::kable(tb, col.names = c("**Category**", "**Numerical Value**"))
#'
#' ```
#'
#' See [igo_recode_igoyear()] section for an easy way to recode the numerical
#' values into [factors][base::factor].
#'
#' @format
#' [`data.frame`][data.frame()] with
#' `r prettyNum(nrow(igoR::igo_year_format3), big.mark=",")` rows. Relevant
#' fields:
#'   * **ioname**: Short abbreviation of the IGO name.
#'   * **orgname**: Full IGO name.
#'   * **year**: Calendar Year.
#'   * **afghanistan...zimbabwe**: status of that state in the IGO. See
#'     **Details**.
#'   * **sdate**: start date (year) that the IGO started.
#'   * **deaddate**: dead date (year) that the IGO dead.
#'   * **longorgname**: a longer version of the IGOs name (including previous
#'     names)
#'   * **ionum**: IGO id number in v2.1 and v3.0 of the data.
#'   * **version**: COW version number.
#'
#' See [**Codebook Version 3 IGO
#'  Data**](https://correlatesofwar.org/data-sets/IGOs/) for full reference.
#'
#' @family datasets
#'
#' @note Raw data used internally by \CRANpkg{igoR}.
#'
#' @references
#' Pevehouse, J. C., Nordstrom, T., McManus, R. W., & Jamison, A. S. (2020).
#' Tracking organizations in the world: The Correlates of War IGO Version 3.0
#' datasets. *Journal of Peace Research, 57*(3), 492–503.
#' \doi{10.1177/0022343319881175}.
#' @examples
#' data("state_year_format3")
#'
#' # Show a glimpse
#' library(dplyr)
#'
#' state_year_format3 %>%
#'   select(ccode:afgec) %>%
#'   filter(year > 1990) %>%
#'   glimpse()
#'
#' # Recode numerical to factors: with a sample
#' sample_state_year <- state_year_format3 %>%
#'   as_tibble() %>%
#'   select(ccode:afgec) %>%
#'   filter(year == 1990)
#'
#' sample_state_year %>% glimpse()
#'
#' # Recode
#' sample_state_year_recoded <- sample_state_year %>%
#'   mutate(across(-c(ccode:state), igo_recode_stateyear))
#'
#' sample_state_year_recoded %>% glimpse()
NULL

#' @title Country membership to IGO by year
#'
#' @name state_year_format3
#'
#' @docType data
#'
#' @description
#' Data on IGOs from 1815-2014, at the country-year level. Contains one record
#' per country-year (with years listed at 5 year intervals through 1965, and
#' annually thereafter).
#'
#' @source
#' [Intergovernmental Organizations
#' (v3)](https://correlatesofwar.org/data-sets/IGOs/), The Correlates of War
#' Project (IGO Data Stata Files)
#'
#' @details
#' Possible value of the status of that state in the IGO are:
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
#' knitr::kable(tb, col.names = c("**Category**", "**Numerical Value**"))
#'
#' ```
#' See [igo_recode_stateyear()] section for an easy way to recode the numerical
#' values into [factors][base::factor].
#'
#' @format [`data.frame`][data.frame()] with
#' `r prettyNum(nrow(igoR::state_year_format3), big.mark=",")` rows. Relevant
#' fields:
#'   * **ccode**: COW country number, see [states2016].
#'   * **year**: Calendar Year.
#'   * **state**: Abbreviated state name, identical to variable names in
#'     [igo_year_format3].
#'   * **aaaid...wassen**: IGO variables containing information on state
#'     membership status. See **Details**.
#'
#' See [**Codebook Version 3 IGO
#'  Data**](https://correlatesofwar.org/data-sets/IGOs/)
#'
#' @seealso
#' [countrycode::countrycode()] to convert between different country code
#' schemes.
#'
#' @family datasets
#'
#' @note Raw data used internally by \CRANpkg{igoR}.
#'
#' @references
#' Pevehouse, J. C., Nordstrom, T., McManus, R. W., & Jamison, A. S. (2020).
#' Tracking organizations in the world: The Correlates of War IGO Version 3.0
#' datasets. *Journal of Peace Research, 57*(3), 492–503.
#' \doi{10.1177/0022343319881175}.
#'
#' @examples
#' data("state_year_format3")
#' dplyr::tibble(state_year_format3)
#'
NULL


#' @title State System Membership (v2016)
#'
#' @name states2016
#'
#' @docType data
#'
#' @description
#' The list of states with COW abbreviations and ID numbers, plus the field
#' `state` from [state_year_format3].
#'
#' @source
#' [State System Membership
#' (v2016)](https://correlatesofwar.org/data-sets/state-system-membership/),
#' The Correlates of War Project.
#'
#' @format [`data.frame`][data.frame()] with
#' `r prettyNum(nrow(igoR::states2016), big.mark=",")` rows. Relevant fields:
#' * **ccode**: COW country number.
#' * **stateabb**: COW state abbreviation (3 characters).
#' * **statenme**: COW state name.
#' * **styear...endday**: Fields to identify the beginning and the end of each
#'   tenure.
#' * **version**: Data file version number.
#' * **state**: Abbreviated state name as appear in [state_year_format3].
#'
#' @family datasets
#'
#' @details
#' This data set contains the list of states in the international system as
#' updated and distributed by the Correlates of War Project.
#'
#' These data sets identify states, their standard Correlates of War "country
#' code" or state number (used throughout the Correlates of War project data
#' sets), state abbreviations, and dates of membership as states and major
#' powers in the international system.
#'
#' The Correlates of War project includes a state in the international system
#' from 1816-2016 for the following criteria:
#'
#' * **Prior to 1920** the entity must have had a population greater than
#'   500,000 and have had diplomatic missions at or above the rank of charge
#'   d'affaires with Britain and France.
#'
#' * **After 1920** the entity must be a member of the League of Nations or the
#'   United Nations, or have a population greater than 500,000 and receive
#'   diplomatic missions from two major powers.
#'
#'
#' @note
#' `state` variable added to original data to help comparison across datasets
#' on this package.
#'
#' @references
#' Correlates of War Project. 2017 "State System Membership List, v2016."
#' Online, <https://correlatesofwar.org/>.
#'
#' @examples
#' # example code
#' data("states2016")
#' dplyr::glimpse(states2016)
NULL
