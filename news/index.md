# Changelog

## igoR (development version)

- `COPYRIGHTS` file updated.

## igoR 1.0.0

CRAN release: 2026-01-17

First major version of the package.

- The minimum **R** version required is now 3.6.0. No visible change for
  users.

## igoR 0.2.1

CRAN release: 2024-12-17

- Regular documentation update.

## igoR 0.2.0

CRAN release: 2024-02-05

- Internal refactor of the code. The user shouldn’t notice any visible
  change.
- [`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md)
  now accepts a vector of countries also in the `country1` argument.
- New helper functions for converting numerical values to labels:
  [`igo_recode_igoyear()`](https://dieghernan.github.io/igoR/reference/igo_recode.md),
  [`igo_recode_stateyear()`](https://dieghernan.github.io/igoR/reference/igo_recode.md),
  [`igo_recode_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_recode.md).
- Updated docs and basic package maintenance.

## igoR 0.1.5

CRAN release: 2023-04-14

- Updated docs and examples.

## igoR 0.1.4

CRAN release: 2022-08-13

- Updated docs due to **CRAN** notice.

## igoR 0.1.3

CRAN release: 2021-10-20

- Updated docs.

## igoR 0.1.2

CRAN release: 2021-08-04

- “Mapping IGOs” article compiled into vignette.
- Updated docs. Now in markdown format using
  [`roxygen2md::roxygen2md()`](https://roxygen2md.r-lib.org/reference/roxygen2md.html).
- Moved tests to **testthat**.

## igoR 0.1.1

CRAN release: 2021-01-27

- Removed **lifecycle** badge.

## igoR 0.1.0

- Vectorize
  [`igo_members()`](https://dieghernan.github.io/igoR/reference/igo_members.md).
- Generalize search ignoring case.
- Added
  [`igo_state_membership()`](https://dieghernan.github.io/igoR/reference/igo_state_membership.md).
- `cow_country_codes` is now internal.
- Added
  [`igoR::states2016`](https://dieghernan.github.io/igoR/reference/states2016.md)
  as a replacement for `cow_country_codes`.
- Added
  [`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md).
- Added
  [`igo_search_states()`](https://dieghernan.github.io/igoR/reference/igo_search_states.md).
- More vignettes on the [website](https://dieghernan.github.io/igoR/).
