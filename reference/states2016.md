# State System Membership (v2016)

The list of states with COW abbreviations and ID numbers, plus the field
`state` from
[state_year_format3](https://dieghernan.github.io/igoR/reference/state_year_format3.md).

## Format

[`data.frame`](https://rdrr.io/r/base/data.frame.html) with 243 rows.
Relevant fields:

- **ccode**: COW country number.

- **stateabb**: COW state abbreviation (3 characters).

- **statenme**: COW state name.

- **styear...endday**: Fields to identify the beginning and the end of
  each tenure.

- **version**: Data file version number.

- **state**: Abbreviated state name as appear in
  [state_year_format3](https://dieghernan.github.io/igoR/reference/state_year_format3.md).

## Source

[State System Membership
(v2016)](https://correlatesofwar.org/data-sets/state-system-membership/),
The Correlates of War Project.

## Details

This data set contains the list of states in the international system as
updated and distributed by the Correlates of War Project.

These data sets identify states, their standard Correlates of War
"country code" or state number (used throughout the Correlates of War
project data sets), state abbreviations, and dates of membership as
states and major powers in the international system.

The Correlates of War project includes a state in the international
system from 1816-2016 for the following criteria:

- **Prior to 1920** the entity must have had a population greater than
  500,000 and have had diplomatic missions at or above the rank of
  charge d'affaires with Britain and France.

- **After 1920** the entity must be a member of the League of Nations or
  the United Nations, or have a population greater than 500,000 and
  receive diplomatic missions from two major powers.

## Note

`state` variable added to original data to help comparisons across
datasets on this package.

## References

Correlates of War Project. 2017 "State System Membership List, v2016."
Online, <https://correlatesofwar.org/>.

## See also

Other datasets:
[`igo_recode_igoyear()`](https://dieghernan.github.io/igoR/reference/igo_recode.md),
[`igo_year_format3`](https://dieghernan.github.io/igoR/reference/igo_year_format3.md),
[`state_year_format3`](https://dieghernan.github.io/igoR/reference/state_year_format3.md)

## Examples

``` r
# example code
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
