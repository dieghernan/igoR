# Changelog

## igoR 1.0.2

- Package documentation was reviewed and updated with AI-assisted
  editing.

## igoR 1.0.1

CRAN release: 2026-03-13

- Updated the `COPYRIGHTS` file.
- Migrated documentation and vignettes to Quarto.

## igoR 1.0.0

CRAN release: 2026-01-17

First major version of the package.

- The minimum **R** version required is now 3.6.0. No visible change for
  users.

## igoR 0.2.1

CRAN release: 2024-12-17

- Updated documentation.

## igoR 0.2.0

CRAN release: 2024-02-05

- Refactored internal code. Users should not notice any visible change.
- Updated documentation and basic package maintenance.
- [`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md)
  now also accepts a vector of countries in the `country1` argument.
- [`igo_recode_igoyear()`](https://dieghernan.github.io/igoR/reference/igo_recode.md),
  [`igo_recode_stateyear()`](https://dieghernan.github.io/igoR/reference/igo_recode.md)
  and
  [`igo_recode_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_recode.md)
  are new helper functions for converting numerical values to labels.

## igoR 0.1.5

CRAN release: 2023-04-14

- Updated documentation and examples.

## igoR 0.1.4

CRAN release: 2022-08-13

- Updated documentation due to a **CRAN** notice.

## igoR 0.1.3

CRAN release: 2021-10-20

- Updated documentation.

## igoR 0.1.2

CRAN release: 2021-08-04

- Compiled the “Mapping IGOs” article as a vignette.
- Updated documentation. It is now in Markdown format using
  `roxygen2md::roxygen2md()`.
- Moved tests to **testthat**.

## igoR 0.1.1

CRAN release: 2021-01-27

- Removed **lifecycle** badge.

## igoR 0.1.0

- Generalized search to ignore case.
- More vignettes are available on the
  [website](https://dieghernan.github.io/igoR/).
- `cow_country_codes` is now internal.
- [`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md)
  was added.
- [`igo_members()`](https://dieghernan.github.io/igoR/reference/igo_members.md)
  was vectorized.
- [`igo_search_states()`](https://dieghernan.github.io/igoR/reference/igo_search_states.md)
  was added.
- [`igo_state_membership()`](https://dieghernan.github.io/igoR/reference/igo_state_membership.md)
  was added.
- [`igoR::states2016`](https://dieghernan.github.io/igoR/reference/states2016.md)
  was added as a replacement for `cow_country_codes`.
