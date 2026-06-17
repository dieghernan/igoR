# Extract joint IGO membership for state pairs

Creates dyad-year IGO data. Each row represents a pair of states in one
year and summarizes their joint memberships across IGOs.

## Usage

``` r
igo_dyadic(country1, country2, year = 1816:2014, ioname = NULL)
```

## Source

[Codebook Version 3 IGO
Data](https://correlatesofwar.org/data-sets/IGOs/) for the full
reference.

## Arguments

- country1, country2:

  A state or vector of states to compare. Each value can be any state
  name or code in
  [states2016](https://dieghernan.github.io/igoR/dev/reference/states2016.md).

- year:

  An integer or vector of years to assess.

- ioname:

  An optional IGO identifier or vector of identifiers. If `NULL` (the
  default), all IGOs are included. Use
  [`igo_search()`](https://dieghernan.github.io/igoR/dev/reference/igo_search.md)
  to find valid identifiers.

## Value

A coded [`data.frame`](https://rdrr.io/r/base/data.frame.html) with one
row per state pair and year and one column per selected IGO. See Details
for the coding scheme.

## Details

The arguments `country1` and `country2` are named for compatibility with
earlier versions of **igoR**. Values are matched against states in
[states2016](https://dieghernan.github.io/igoR/dev/reference/states2016.md).

This function reproduces the structure of the original dyad-year file
distributed by the Correlates of War Project (`dyadic_format3.dta`).
That file is not included in this package due to its size.

The result contains one row for each common year selected by `country1`,
`country2` and `year`.

The `dyadid` column identifies each relationship and is computed as
`(1000 * ccode1) + ccode2`.

For each selected IGO, the result includes a column named after its
lowercase identifier and uses this coding scheme:

|                         |                     |
|-------------------------|---------------------|
| **Category**            | **Numerical value** |
| No Joint Membership     | 0                   |
| Joint Full Membership   | 1                   |
| Missing data            | -9                  |
| State Not System Member | -1                  |

Use
[`igo_recode_dyadic()`](https://dieghernan.github.io/igoR/dev/reference/igo_recode.md)
to recode the numerical values as
[factors](https://rdrr.io/r/base/factor.html).

If one state in an IGO is a full member but the other is an associate
member or observer, that IGO is not coded as a joint membership.

## Differences from the original data set

For some IGOs, results differ from the original data set in the coding
of "Missing data" (`-9`) and "State Not System Member" (`-1`). The
available documentation does not fully specify how to reproduce those
values.

See [Codebook Version 3 IGO
Data](https://correlatesofwar.org/data-sets/IGOs/).

## References

Pevehouse, J. C., Nordstrom, T., McManus, R. W. & Jamison, A. S. (2020).
Tracking organizations in the world: The Correlates of War IGO Version
3.0 data sets. *Journal of Peace Research, 57*(3), 492–503.
[doi:10.1177/0022343319881175](https://doi.org/10.1177/0022343319881175)
.

## See also

[state_year_format3](https://dieghernan.github.io/igoR/dev/reference/state_year_format3.md),
[states2016](https://dieghernan.github.io/igoR/dev/reference/states2016.md),
[`igo_search()`](https://dieghernan.github.io/igoR/dev/reference/igo_search.md),
[`igo_recode_dyadic()`](https://dieghernan.github.io/igoR/dev/reference/igo_recode.md).

Other membership functions:
[`igo_members()`](https://dieghernan.github.io/igoR/dev/reference/igo_members.md),
[`igo_state_membership()`](https://dieghernan.github.io/igoR/dev/reference/igo_state_membership.md)

## Examples

``` r
usa_esp <- igo_dyadic("USA", "Spain")
nrow(usa_esp)
#> [1] 199
ncol(usa_esp)
#> [1] 546

dplyr::tibble(usa_esp)
#> # A tibble: 199 × 546
#>    dyadid ccode1 stateabb1 statenme1    state1 ccode2 stateabb2 statenme2 state2
#>     <dbl>  <int> <chr>     <chr>        <chr>   <int> <chr>     <chr>     <chr> 
#>  1   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  2   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  3   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  4   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  5   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  6   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  7   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  8   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  9   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#> 10   2230      2 USA       United Stat… usa       230 SPN       Spain     spain 
#> # ℹ 189 more rows
#> # ℹ 537 more variables: year <dbl>, ccode <dbl>, state <dbl>, aaaid <dbl>,
#> #   aacb <dbl>, aalco <dbl>, aaro <dbl>, aata <dbl>, aatpo <dbl>, abeda <dbl>,
#> #   abepseac <dbl>, acc <dbl>, acct <dbl>, acdt <dbl>, aci <dbl>, acml <dbl>,
#> #   acp <dbl>, acpeu <dbl>, acs <dbl>, acso <dbl>, acssrb <dbl>, acu <dbl>,
#> #   acwl <dbl>, afesd <dbl>, afeximb <dbl>, afgec <dbl>, afpu <dbl>,
#> #   afrand <dbl>, afristat <dbl>, afspc <dbl>, afte <dbl>, agc <dbl>, …

# Use custom arguments.
custom <- igo_dyadic(
  country1 = c("France", "Germany"), country2 = c("Sweden", "Austria"),
  year = 1992:1993, ioname = "EU"
)

dplyr::glimpse(custom)
#> Rows: 8
#> Columns: 11
#> $ dyadid    <dbl> 220380, 220380, 255380, 255380, 220305, 220305, 255305, 2553…
#> $ ccode1    <int> 220, 220, 255, 255, 220, 220, 255, 255
#> $ stateabb1 <chr> "FRN", "FRN", "GMY", "GMY", "FRN", "FRN", "GMY", "GMY"
#> $ statenme1 <chr> "France", "France", "Germany", "Germany", "France", "France"…
#> $ state1    <chr> "france", "france", "germany", "germany", "france", "france"…
#> $ ccode2    <int> 380, 380, 380, 380, 305, 305, 305, 305
#> $ stateabb2 <chr> "SWD", "SWD", "SWD", "SWD", "AUS", "AUS", "AUS", "AUS"
#> $ statenme2 <chr> "Sweden", "Sweden", "Sweden", "Sweden", "Austria", "Austria"…
#> $ state2    <chr> "sweden", "sweden", "sweden", "sweden", "austria", "austria"…
#> $ year      <dbl> 1992, 1993, 1992, 1993, 1992, 1993, 1992, 1993
#> $ eu        <dbl> -1, 0, -1, 0, -1, 0, -1, 0
```
