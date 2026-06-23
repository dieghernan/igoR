# Recode membership categories

Converts the numerical membership codes in
[igo_year_format3](https://dieghernan.github.io/igoR/reference/igo_year_format3.md),
[state_year_format3](https://dieghernan.github.io/igoR/reference/state_year_format3.md)
and
[`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md)
into [factors](https://rdrr.io/r/base/factor.html). Use
`igo_recode_igoyear()` with values from
[igo_year_format3](https://dieghernan.github.io/igoR/reference/igo_year_format3.md),
`igo_recode_stateyear()` with values from
[state_year_format3](https://dieghernan.github.io/igoR/reference/state_year_format3.md)
and `igo_recode_dyadic()` with values from
[`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md).

## Usage

``` r
igo_recode_igoyear(x)

igo_recode_stateyear(x)

igo_recode_dyadic(x)
```

## Arguments

- x:

  A numerical value or vector of values to recode.

## Value

A [factor](https://rdrr.io/r/base/factor.html) with the recoded
membership categories.

## Examples

``` r
data("igo_year_format3")

# Recode memberships for some states.
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

# Recode the membership columns.
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
