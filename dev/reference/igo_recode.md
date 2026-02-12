# Helper functions to recode categories

These functions convert the numerical code of
[igo_year_format3](https://dieghernan.github.io/igoR/dev/reference/igo_year_format3.md)
and
[state_year_format3](https://dieghernan.github.io/igoR/dev/reference/state_year_format3.md)
into [factors](https://rdrr.io/r/base/factor.html).

- `igo_recode_igoyear()` is intended to work with values on
  [igo_year_format3](https://dieghernan.github.io/igoR/dev/reference/igo_year_format3.md).

- `igo_recode_stateyear()` is intended to work with values on
  [state_year_format3](https://dieghernan.github.io/igoR/dev/reference/state_year_format3.md).

- `igo_recode_dyadic()` is intended to work with values on
  [`igo_dyadic()`](https://dieghernan.github.io/igoR/dev/reference/igo_dyadic.md).

## Usage

``` r
igo_recode_igoyear(x)

igo_recode_stateyear(x)

igo_recode_dyadic(x)
```

## Arguments

- x:

  Numerical value (or vector of values) to recode.

## Value

The recoded values as [factors](https://rdrr.io/r/base/factor.html).

## See also

Other datasets:
[`igo_year_format3`](https://dieghernan.github.io/igoR/dev/reference/igo_year_format3.md),
[`state_year_format3`](https://dieghernan.github.io/igoR/dev/reference/state_year_format3.md),
[`states2016`](https://dieghernan.github.io/igoR/dev/reference/states2016.md)

## Examples

``` r
data("igo_year_format3")

# Recode memberships for some countries

library(dplyr)

samp <- igo_year_format3 %>%
  select(ioname:year, spain, france) %>%
  filter(year > 2000) %>%
  as_tibble()

glimpse(samp)
#> Rows: 4,661
#> Columns: 5
#> $ ioname  <chr> "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU",…
#> $ orgname <chr> "ACP/EU Joint Assembly", "ACP/EU Joint Assembly", "ACP/EU Join…
#> $ year    <dbl> 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 20…
#> $ spain   <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0,…
#> $ france  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…

# Recode
samp %>%
  mutate(
    spain = igo_recode_igoyear(spain),
    france = igo_recode_igoyear(france)
  ) %>%
  glimpse()
#> Rows: 4,661
#> Columns: 5
#> $ ioname  <chr> "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU",…
#> $ orgname <chr> "ACP/EU Joint Assembly", "ACP/EU Joint Assembly", "ACP/EU Join…
#> $ year    <dbl> 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 20…
#> $ spain   <fct> Full Membership, Full Membership, Full Membership, Full Member…
#> $ france  <fct> Full Membership, Full Membership, Full Membership, Full Member…
```
