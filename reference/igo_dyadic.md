# Extract the joint membership of a pair of countries across IGOs

Dyadic version of the data. The unit of observation is a dyad of
countries. It provides a summary of the joint memberships of two
countries across IGOs over time.

## Usage

``` r
igo_dyadic(country1, country2, year = 1816:2014, ioname = NULL)
```

## Source

[**Codebook Version 3 IGO
Data**](https://correlatesofwar.org/data-sets/IGOs/) for full reference.

## Arguments

- country1, country2:

  A state or vector of states to be compared. It could be any valid name
  or code of a state as specified on
  [states2016](https://dieghernan.github.io/igoR/reference/states2016.md).

- year:

  Year to be assessed, an integer or an array of years.

- ioname:

  Optional. `ioname` or vector of `ioname` corresponding to the IGOs to
  be assessed. If `NULL` (the default), all IGOs will be extracted. See
  codes on
  [`igo_search()`](https://dieghernan.github.io/igoR/reference/igo_search.md).

## Value

A coded [`data.frame`](https://rdrr.io/r/base/data.frame.html)
representing the years and country dyad (rows) and the IGOs selected
(columns). See **Details**.

## Details

This function tries to replicate the information contained in the
original file distributed by The Correlates of War Project
(`dyadic_format3.dta`). That file is not included in this package due to
its size.

The result is a [`data.frame`](https://rdrr.io/r/base/data.frame.html)
containing the common years of the states selected via
`country1, country2, year` by rows.

An additional column `dyadid`, computed as `(1000*ccode1)+ccode2` is
provided in order to identify relationships.

For each IGO selected via `ioname` (or all if the default option has
been used) a column (using lowercase `ioname` as identifier) is provided
with the following code system:

|                         |                     |
|-------------------------|---------------------|
| **Category**            | **Numerical Value** |
| No Joint Membership     | 0                   |
| Joint Full Membership   | 1                   |
| Missing data            | -9                  |
| State Not System Member | -1                  |

See
[`igo_recode_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_recode.md)
section for an easy way to recode the numerical values into
[factors](https://rdrr.io/r/base/factor.html).

If one state in an IGO is a full member but the other is an associate
member or observer, that IGO is not coded as a joint membership.

## Differences with the original dataset

There are some differences on the results provided by this function and
the original dataset on some IGOs regarding the "Missing Data" (`-9`)
and "State Not System Member" (`-1`). However it is not clear how to
fully replicate those values.

See [**Codebook Version 3 IGO
Data**](https://correlatesofwar.org/data-sets/IGOs/)

## References

Pevehouse, J. C., Nordstrom, T., McManus, R. W., & Jamison, A. S.
(2020). Tracking organizations in the world: The Correlates of War IGO
Version 3.0 datasets. *Journal of Peace Research, 57*(3), 492–503.
[doi:10.1177/0022343319881175](https://doi.org/10.1177/0022343319881175)
.

## See also

[state_year_format3](https://dieghernan.github.io/igoR/reference/state_year_format3.md),
[states2016](https://dieghernan.github.io/igoR/reference/states2016.md),
[`igo_search()`](https://dieghernan.github.io/igoR/reference/igo_search.md).

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
#>  1   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  2   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  3   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  4   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  5   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  6   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  7   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  8   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#>  9   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#> 10   2002      2 USA       United Stat… usa       230 SPN       Spain     spain 
#> # ℹ 189 more rows
#> # ℹ 537 more variables: year <dbl>, ccode <dbl>, state <dbl>, aaaid <dbl>,
#> #   aacb <dbl>, aalco <dbl>, aaro <dbl>, aata <dbl>, aatpo <dbl>, abeda <dbl>,
#> #   abepseac <dbl>, acc <dbl>, acct <dbl>, acdt <dbl>, aci <dbl>, acml <dbl>,
#> #   acp <dbl>, acpeu <dbl>, acs <dbl>, acso <dbl>, acssrb <dbl>, acu <dbl>,
#> #   acwl <dbl>, afesd <dbl>, afeximb <dbl>, afgec <dbl>, afpu <dbl>,
#> #   afrand <dbl>, afristat <dbl>, afspc <dbl>, afte <dbl>, agc <dbl>, …

# Using custom arguments
custom <- igo_dyadic(
  country1 = c("France", "Germany"), country2 = c("Sweden", "Austria"),
  year = 1992:1993, ioname = "EU"
)

dplyr::glimpse(custom)
#> Rows: 8
#> Columns: 11
#> $ dyadid    <dbl> 220220, 220220, 255255, 255255, 220220, 220220, 255255, 2552…
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
