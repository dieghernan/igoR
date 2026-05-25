# igoR (development version)

- Internal code paths were simplified with AI-assisted refactoring to reduce
  duplicated result handling, status validation and dyadic recoding logic.
- `igo_dyadic()` now computes `dyadid` with both state codes, as documented.
- User-facing messages were revised for clearer wording and consistent argument
  names.

# igoR 1.0.2

- Package documentation was reviewed and updated with AI-assisted editing.

# igoR 1.0.1

- Updated the `COPYRIGHTS` file.
- Migrated documentation and vignettes to Quarto.

# igoR 1.0.0

First major version of the package.

- The minimum **R** version required is now 3.6.0. No visible change for users.

# igoR 0.2.1

- Updated documentation.

# igoR 0.2.0

- Refactored internal code. Users should not notice any visible change.
- Updated documentation and basic package maintenance.
- `igo_dyadic()` now also accepts a vector of states in the `country1` argument.
- `igo_recode_igoyear()`, `igo_recode_stateyear()` and `igo_recode_dyadic()` are
  new helper functions for converting numerical values to labels.

# igoR 0.1.5

- Updated documentation and examples.

# igoR 0.1.4

- Updated documentation due to a **CRAN** notice.

# igoR 0.1.3

- Updated documentation.

# igoR 0.1.2

- Compiled the "Mapping IGOs" article as a vignette.
- Updated documentation. It is now in Markdown format using
  `roxygen2md::roxygen2md()`.
- Moved tests to **testthat**.

# igoR 0.1.1

- Removed **lifecycle** badge.

# igoR 0.1.0

- Generalized search to ignore case.
- More vignettes are available on the
  [website](https://dieghernan.github.io/igoR/).
- `cow_country_codes` is now internal.
- `igo_dyadic()` was added.
- `igo_members()` was vectorized.
- `igo_search_states()` was added.
- `igo_state_membership()` was added.
- `igoR::states2016` was added as a replacement for `cow_country_codes`.
