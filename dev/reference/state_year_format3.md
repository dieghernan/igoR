# Country membership to IGO by year

Data on IGOs from 1815-2014, at the country-year level. Contains one
record per country-year (with years listed at 5 year intervals through
1965, and annually thereafter).

## Format

[`data.frame`](https://rdrr.io/r/base/data.frame.html) with 15,557 rows.
Relevant fields:

- **ccode**: COW country number, see
  [states2016](https://dieghernan.github.io/igoR/dev/reference/states2016.md).

- **year**: Calendar Year.

- **state**: Abbreviated state name, identical to variable names in
  [igo_year_format3](https://dieghernan.github.io/igoR/dev/reference/igo_year_format3.md).

- **aaaid...wassen**: IGO variables containing information on state
  membership status. See **Details**.

See [**Codebook Version 3 IGO
Data**](https://correlatesofwar.org/data-sets/IGOs/)

## Source

[Intergovernmental Organizations
(v3)](https://correlatesofwar.org/data-sets/IGOs/), The Correlates of
War Project (IGO Data Stata Files).

## Details

Possible values of the status of that state in the IGO are:

|                      |                     |
|----------------------|---------------------|
| **Category**         | **Numerical Value** |
| No Membership        | 0                   |
| Full Membership      | 1                   |
| Associate Membership | 2                   |
| Observer             | 3                   |
| Missing data         | -9                  |
| IGO Not In Existence | -1                  |

See
[`igo_recode_stateyear()`](https://dieghernan.github.io/igoR/dev/reference/igo_recode.md)
section for an easy way to recode the numerical values into
[factors](https://rdrr.io/r/base/factor.html).

## Note

Raw data used internally by
[igoR](https://CRAN.R-project.org/package=igoR).

## References

Pevehouse, J. C., Nordstrom, T., McManus, R. W., & Jamison, A. S.
(2020). Tracking organizations in the world: The Correlates of War IGO
Version 3.0 datasets. *Journal of Peace Research, 57*(3), 492–503.
[doi:10.1177/0022343319881175](https://doi.org/10.1177/0022343319881175)
.

## See also

[`countrycode::countrycode()`](https://vincentarelbundock.github.io/countrycode/reference/countrycode.html)
to convert between different country code schemes.

Other datasets:
[`igo_recode_igoyear()`](https://dieghernan.github.io/igoR/dev/reference/igo_recode.md),
[`igo_year_format3`](https://dieghernan.github.io/igoR/dev/reference/igo_year_format3.md),
[`states2016`](https://dieghernan.github.io/igoR/dev/reference/states2016.md)

## Examples

``` r
data("state_year_format3")
dplyr::tibble(state_year_format3)
#> # A tibble: 15,557 × 537
#>    ccode  year state aaaid  aacb aalco  aaro  aata aatpo abeda abepseac   acc
#>    <dbl> <dbl> <chr> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>    <dbl> <dbl>
#>  1     2  1816 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#>  2     2  1817 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#>  3     2  1818 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#>  4     2  1819 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#>  5     2  1820 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#>  6     2  1821 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#>  7     2  1822 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#>  8     2  1823 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#>  9     2  1824 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#> 10     2  1825 usa      -1    -1    -1    -1    -1    -1    -1       -1    -1
#> # ℹ 15,547 more rows
#> # ℹ 525 more variables: acct <dbl>, acdt <dbl>, aci <dbl>, acml <dbl>,
#> #   acp <dbl>, acpeu <dbl>, acs <dbl>, acso <dbl>, acssrb <dbl>, acu <dbl>,
#> #   acwl <dbl>, afesd <dbl>, afeximb <dbl>, afgec <dbl>, afpu <dbl>,
#> #   afrand <dbl>, afristat <dbl>, afspc <dbl>, afte <dbl>, agc <dbl>,
#> #   agpundo <dbl>, aic <dbl>, aidc <dbl>, aido <dbl>, aioec <dbl>, aipo <dbl>,
#> #   aitic <dbl>, alo <dbl>, alsf <dbl>, amco <dbl>, amcow <dbl>, amf <dbl>, …
```
