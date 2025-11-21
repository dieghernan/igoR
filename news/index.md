# Changelog

## igoR 0.2.1

CRAN release: 2024-12-17

- Regular update of documentation.

## igoR 0.2.0

CRAN release: 2024-02-05

- Internal refactor of the code. The user shouldn’t notice any visible
  change.
- [`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md)
  accepts now a vector of countries also in the `country1` parameter.
- New helper functions for converting numerical values to labels:
  [`igo_recode_igoyear()`](https://dieghernan.github.io/igoR/reference/igo_recode.md),
  [`igo_recode_stateyear()`](https://dieghernan.github.io/igoR/reference/igo_recode.md),
  [`igo_recode_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_recode.md).
- Update docs and basic package maintenance.

## igoR 0.1.5

CRAN release: 2023-04-14

- Update docs and examples.

## igoR 0.1.4

CRAN release: 2022-08-13

- Update docs due to **CRAN** notice.

## igoR 0.1.3

CRAN release: 2021-10-20

- Update docs.

## igoR 0.1.2

CRAN release: 2021-08-04

- “Mapping IGOs” article compiled to vignette.
- Update docs. Now in markdown format using `roxygen2md::roxygen2md()`.
- Moved tests to **testthat**.

## igoR 0.1.1

CRAN release: 2021-01-27

- Remove **lifecycle** badge.

## igoR 0.1.0

- Vectorize
  [`igo_members()`](https://dieghernan.github.io/igoR/reference/igo_members.md).
- Generalize search ignoring case.
- Add
  [`igo_state_membership()`](https://dieghernan.github.io/igoR/reference/igo_state_membership.md).
- `cow_country_codes` now is internal.
- Added
  [`igoR::states2016`](https://dieghernan.github.io/igoR/reference/states2016.md)
  in replacement of `cow_country_codes`.
- Add
  [`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md).
- Add
  [`igo_search_states()`](https://dieghernan.github.io/igoR/reference/igo_search_states.md).
- More vignettes on the [website](https://dieghernan.github.io/igoR/).

## igoR 0.0.0.9000

- Pre-release.
