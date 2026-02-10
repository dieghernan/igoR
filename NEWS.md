# igoR (development version)

-   `COPYRIGHTS` file updated.
-   Migrate documentation and vignettes to Quarto.

# igoR 1.0.0

First major version of the package.

-   The minimum **R** version required is now 3.6.0. No visible change for
    users.

# igoR 0.2.1

-   Regular documentation update.

# igoR 0.2.0

-   Internal refactor of the code. The user shouldn't notice any visible change.
-   `igo_dyadic()` now accepts a vector of countries also in the `country1`
    argument.
-   New helper functions for converting numerical values to labels:
    `igo_recode_igoyear()`, `igo_recode_stateyear()`, `igo_recode_dyadic()`.
-   Updated docs and basic package maintenance.

# igoR 0.1.5

-   Updated docs and examples.

# igoR 0.1.4

-   Updated docs due to **CRAN** notice.

# igoR 0.1.3

-   Updated docs.

# igoR 0.1.2

-   "Mapping IGOs" article compiled into vignette.
-   Updated docs. Now in markdown format using `roxygen2md::roxygen2md()`.
-   Moved tests to **testthat**.

# igoR 0.1.1

-   Removed **lifecycle** badge.

# igoR 0.1.0

-   Vectorize `igo_members()`.
-   Generalize search ignoring case.
-   Added `igo_state_membership()`.
-   `cow_country_codes` is now internal.
-   Added `igoR::states2016` as a replacement for `cow_country_codes`.
-   Added `igo_dyadic()`.
-   Added `igo_search_states()`.
-   More vignettes on the [website](https://dieghernan.github.io/igoR/).
