# State system membership (v2016)

A list of states with Correlates of War abbreviations and identifiers,
plus the `state` field from
[state_year_format3](https://dieghernan.github.io/igoR/reference/state_year_format3.md).

## Format

A [`data.frame`](https://rdrr.io/r/base/data.frame.html) with 243 rows
and 11 variables:

- `ccode`:

  COW state number.

- `stateabb`:

  COW state abbreviation.

- `statenme`:

  Primary COW state name.

- `styear`:

  Beginning year of state tenure.

- `stmonth`:

  Beginning month of state tenure.

- `stday`:

  Beginning day of state tenure.

- `endyear`:

  Ending year of state tenure.

- `endmonth`:

  Ending month of state tenure.

- `endday`:

  Ending day of state tenure.

- `version`:

  Data file version number.

- `state`:

  Abbreviated state name as it appears in `state_year_format3`.

## Source

[State System Membership
(v2016)](https://correlatesofwar.org/data-sets/state-system-membership/).
The Correlates of War Project.

## Details

This data set contains the states in the international system as updated
and distributed by the Correlates of War Project.

It identifies states, their standard Correlates of War country code or
state number, state abbreviations and dates of membership as states and
major powers in the international system.

The Correlates of War Project includes a state in the international
system from 1816 to 2016 according to the following criteria:

- **Before 1920**, the entity must have had a population greater than
  500,000 and have had diplomatic missions at or above the rank of
  chargé d'affaires with Britain and France.

- **After 1920**, the entity must be a member of the League of Nations
  or the United Nations, or have a population greater than 500,000 and
  receive diplomatic missions from two major powers.

## Note

The `state` variable was added to the original data to support
comparisons across data sets in this package.

## References

Correlates of War Project. 2017. "State System Membership List, v2016."
Online, <https://correlatesofwar.org/>.

## See also

Other data sets:
[`igo_year_format3`](https://dieghernan.github.io/igoR/reference/igo_year_format3.md),
[`state_year_format3`](https://dieghernan.github.io/igoR/reference/state_year_format3.md)

## Examples

``` r
data("states2016")
dplyr::glimpse(states2016)
#> Rows: 243
#> Columns: 11
#> $ ccode    <int> 2, 20, 31, 40, 40, 41, 41, 42, 42, 51, 52, 53, 54, 55, 56, 57…
#> $ stateabb <chr> "USA", "CAN", "BHM", "CUB", "CUB", "HAI", "HAI", "DOM", "DOM"…
#> $ statenme <chr> "United States of America", "Canada", "Bahamas", "Cuba", "Cub…
#> $ styear   <int> 1816, 1920, 1973, 1902, 1909, 1859, 1934, 1894, 1924, 1962, 1…
#> $ stmonth  <int> 1, 1, 7, 5, 1, 1, 8, 1, 9, 8, 8, 11, 11, 2, 2, 10, 11, 9, 1, …
#> $ stday    <int> 1, 10, 10, 20, 23, 1, 15, 1, 29, 6, 31, 30, 3, 7, 22, 27, 1, …
#> $ endyear  <int> 2016, 2016, 2016, 1906, 2016, 1915, 2016, 1916, 2016, 2016, 2…
#> $ endmonth <int> 12, 12, 12, 9, 12, 7, 12, 11, 12, 12, 12, 12, 12, 12, 12, 12,…
#> $ endday   <int> 31, 31, 31, 25, 31, 28, 31, 29, 31, 31, 31, 31, 31, 31, 31, 3…
#> $ version  <int> 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2…
#> $ state    <chr> "usa", "canada", "bahamas", "cuba", "cuba", "haiti", "haiti",…
```
