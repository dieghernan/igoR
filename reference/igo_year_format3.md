# IGO-year membership data

Data on intergovernmental organizations (IGOs) from 1816 to 2014 at the
IGO-year level. Each row represents one IGO in one year. Years are
recorded at five-year intervals through 1965 and annually thereafter.

## Format

A [`data.frame`](https://rdrr.io/r/base/data.frame.html) with 19,335
rows. Relevant fields:

- `ioname`: Short abbreviation for the IGO name.

- `orgname`: Full IGO name.

- `year`: Calendar year.

- `afghanistan...zimbabwe`: Membership status of each state in the IGO.
  See the Details section.

- `sdate`: Start year for the IGO.

- `deaddate`: End year for the IGO.

- `longorgname`: Longer IGO name, including previous names.

- `ionum`: IGO identifier in versions 2.1 and 3.0 of the data.

- `version`: Correlates of War version number.

## Source

[Intergovernmental Organizations (version
3)](https://correlatesofwar.org/data-sets/IGOs/), IGO Data Stata Files
from the Correlates of War Project.

See the [Codebook Version 3 IGO
Data](https://correlatesofwar.org/data-sets/IGOs/) for the full
reference.

## Details

Possible values for the status of a state in the IGO are:

|                         |                     |
|-------------------------|---------------------|
| **Category**            | **Numerical value** |
| No Membership           | 0                   |
| Full Membership         | 1                   |
| Associate Membership    | 2                   |
| Observer                | 3                   |
| Missing data            | -9                  |
| State Not System Member | -1                  |

Use
[`igo_recode_igoyear()`](https://dieghernan.github.io/igoR/reference/igo_recode.md)
to recode the numerical values as
[factors](https://rdrr.io/r/base/factor.html).

## Note

Data distributed with [igoR](https://CRAN.R-project.org/package=igoR).

## References

Pevehouse, J. C., Nordstrom, T., McManus, R. W. & Jamison, A. S. (2020).
Tracking organizations in the world: The Correlates of War IGO Version
3.0 data sets. *Journal of Peace Research, 57*(3), 492–503.
[doi:10.1177/0022343319881175](https://doi.org/10.1177/0022343319881175)
.

## See also

Other data sets:
[`state_year_format3`](https://dieghernan.github.io/igoR/reference/state_year_format3.md),
[`states2016`](https://dieghernan.github.io/igoR/reference/states2016.md)

## Examples

``` r
data("igo_year_format3")

# Show a glimpse.
library(dplyr)

igo_year_format3 %>%
  select(ioname:year, spain, france) %>%
  filter(year > 1990) %>%
  glimpse()
#> Rows: 8,019
#> Columns: 5
#> $ ioname  <chr> "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU", "ACPEU",…
#> $ orgname <chr> "ACP/EU Joint Assembly", "ACP/EU Joint Assembly", "ACP/EU Join…
#> $ year    <dbl> 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 20…
#> $ spain   <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ france  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…

# Prepare a sample of numerical membership values.
sample_igo_year <- igo_year_format3 %>%
  as_tibble() %>%
  select(ioname:year, spain, france) %>%
  filter(year == 1990)

sample_igo_year %>% glimpse()
#> Rows: 314
#> Columns: 5
#> $ ioname  <chr> "ACPEU", "ACSSRB", "CAMES", "ACI", "AfDB", "AFGEC", "AIPO", "A…
#> $ orgname <chr> "ACP/EU Joint Assembly", "Administrative Center for Soc Securi…
#> $ year    <dbl> 1990, 1990, 1990, 1990, 1990, 1990, 1990, 1990, 1990, 1990, 19…
#> $ spain   <dbl> 1, 0, -9, 0, 1, 0, 0, 0, -9, 0, 0, 0, 0, 1, -9, -9, 0, 0, 0, 0…
#> $ france  <dbl> 1, 1, -9, 0, 1, 0, 0, 0, -9, 0, 0, 0, 0, 1, -9, -9, 0, 0, 0, 0…

# Recode the membership columns.
sample_igo_year_recoded <- sample_igo_year %>%
  mutate(across(c(spain, france), igo_recode_igoyear))

sample_igo_year_recoded %>% glimpse()
#> Rows: 314
#> Columns: 5
#> $ ioname  <chr> "ACPEU", "ACSSRB", "CAMES", "ACI", "AfDB", "AFGEC", "AIPO", "A…
#> $ orgname <chr> "ACP/EU Joint Assembly", "Administrative Center for Soc Securi…
#> $ year    <dbl> 1990, 1990, 1990, 1990, 1990, 1990, 1990, 1990, 1990, 1990, 19…
#> $ spain   <fct> Full Membership, No Membership, Missing data, No Membership, F…
#> $ france  <fct> Full Membership, Full Membership, Missing data, No Membership,…
```
