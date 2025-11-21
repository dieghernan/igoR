# Extract memberships of a state

Extract all the memberships of a state on a specific date.

## Usage

``` r
igo_state_membership(state, year = NULL, status = "Full Membership")
```

## Source

[**Codebook Version 3 IGO
Data**](https://correlatesofwar.org/data-sets/IGOs/) for full reference.

## Arguments

- state:

  Any valid name or code of a state as specified on
  [`states2016()`](https://dieghernan.github.io/igoR/reference/states2016.md).
  It could be also an array of states.

- year:

  Year to be assessed, an integer or an array of year. If `NULL` the
  latest year available of the state would be extracted.

- status:

  Character or vector with the membership status to be extracted. See
  **Details** on
  [igo_year_format3](https://dieghernan.github.io/igoR/reference/igo_year_format3.md).

## Value

A [`data.frame`](https://rdrr.io/r/base/data.frame.html).

## References

Pevehouse, J. C., Nordstrom, T., McManus, R. W., & Jamison, A. S.
(2020). Tracking organizations in the world: The Correlates of War IGO
Version 3.0 datasets. *Journal of Peace Research, 57*(3), 492–503.
[doi:10.1177/0022343319881175](https://doi.org/10.1177/0022343319881175)
.

## See also

[igo_year_format3](https://dieghernan.github.io/igoR/reference/igo_year_format3.md),
[`igo_search_states()`](https://dieghernan.github.io/igoR/reference/igo_search_states.md),
[states2016](https://dieghernan.github.io/igoR/reference/states2016.md).

## Examples

``` r
# Memberships on two different dates
igo_state_membership("Spain", year = 1850)
#>   ccode stateabb statenme state year ioname value        category
#> 1   230      SPN    Spain spain 1850    SCH     1 Full Membership
#>                      orgname                longorgname political social
#> 1 Superior Council of Health Superior Council of Health         0      1
#>   economic
#> 1        0
igo_state_membership("Spain", year = 1870)
#>   ccode stateabb statenme state year ioname value        category
#> 1   230      SPN    Spain spain 1870 ICCSLT     1 Full Membership
#> 2   230      SPN    Spain spain 1870    ITU     1 Full Membership
#> 3   230      SPN    Spain spain 1870    SCH     1 Full Membership
#>                           orgname
#> 1 Intl Comm of Cape Spartel Light
#> 2              Intl Telecom Union
#> 3      Superior Council of Health
#>                                                     longorgname political
#> 1 International Commission of the Cape Spartel Light in Tangier         0
#> 2                         International Telecommunication Union         0
#> 3                                    Superior Council of Health         0
#>   social economic
#> 1      0        1
#> 2      0        1
#> 3      1        0
igo_state_membership("Spain", year = 1880:1882)
#>    ccode stateabb statenme state year ioname value        category
#> 1    230      SPN    Spain spain 1880   BIPM     1 Full Membership
#> 2    230      SPN    Spain spain 1880 ICCSLT     1 Full Membership
#> 3    230      SPN    Spain spain 1880 IPentC     1 Full Membership
#> 4    230      SPN    Spain spain 1880    ITU     1 Full Membership
#> 5    230      SPN    Spain spain 1880    SCH     1 Full Membership
#> 6    230      SPN    Spain spain 1880    UPU     1 Full Membership
#> 7    230      SPN    Spain spain 1881   BIPM     1 Full Membership
#> 8    230      SPN    Spain spain 1881 ICCSLT     1 Full Membership
#> 9    230      SPN    Spain spain 1881 IPentC     1 Full Membership
#> 10   230      SPN    Spain spain 1881    ITU     1 Full Membership
#> 11   230      SPN    Spain spain 1881    SCH     1 Full Membership
#> 12   230      SPN    Spain spain 1881    UPU     1 Full Membership
#> 13   230      SPN    Spain spain 1882   BIPM     1 Full Membership
#> 14   230      SPN    Spain spain 1882 ICCSLT     1 Full Membership
#> 15   230      SPN    Spain spain 1882 IPentC     1 Full Membership
#> 16   230      SPN    Spain spain 1882    ITU     1 Full Membership
#> 17   230      SPN    Spain spain 1882    SCH     1 Full Membership
#> 18   230      SPN    Spain spain 1882    UPU     1 Full Membership
#>                                       orgname
#> 1  International Bureau of Weights & Measures
#> 2             Intl Comm of Cape Spartel Light
#> 3                      Intl Penitentiary Comm
#> 4                          Intl Telecom Union
#> 5                  Superior Council of Health
#> 6                      Universal Postal Union
#> 7  International Bureau of Weights & Measures
#> 8             Intl Comm of Cape Spartel Light
#> 9                      Intl Penitentiary Comm
#> 10                         Intl Telecom Union
#> 11                 Superior Council of Health
#> 12                     Universal Postal Union
#> 13 International Bureau of Weights & Measures
#> 14            Intl Comm of Cape Spartel Light
#> 15                     Intl Penitentiary Comm
#> 16                         Intl Telecom Union
#> 17                 Superior Council of Health
#> 18                     Universal Postal Union
#>                                                      longorgname political
#> 1            International Bureau of Weights and Measures (BIPM)         0
#> 2  International Commission of the Cape Spartel Light in Tangier         0
#> 3                          International Penitentiary Commission         0
#> 4                          International Telecommunication Union         0
#> 5                                     Superior Council of Health         0
#> 6                                         Universal Postal Union         0
#> 7            International Bureau of Weights and Measures (BIPM)         0
#> 8  International Commission of the Cape Spartel Light in Tangier         0
#> 9                          International Penitentiary Commission         0
#> 10                         International Telecommunication Union         0
#> 11                                    Superior Council of Health         0
#> 12                                        Universal Postal Union         0
#> 13           International Bureau of Weights and Measures (BIPM)         0
#> 14 International Commission of the Cape Spartel Light in Tangier         0
#> 15                         International Penitentiary Commission         0
#> 16                         International Telecommunication Union         0
#> 17                                    Superior Council of Health         0
#> 18                                        Universal Postal Union         0
#>    social economic
#> 1       0        1
#> 2       0        1
#> 3       1        0
#> 4       0        1
#> 5       1        0
#> 6       0        1
#> 7       0        1
#> 8       0        1
#> 9       1        0
#> 10      0        1
#> 11      1        0
#> 12      0        1
#> 13      0        1
#> 14      0        1
#> 15      1        0
#> 16      0        1
#> 17      1        0
#> 18      0        1

# Last year
igo_state_membership("ZAN")[, 1:7]
#>   ccode stateabb statenme    state year ioname value
#> 1   511      ZAN Zanzibar zanzibar 1964    CEC     1
#> 2   511      ZAN Zanzibar zanzibar 1964    ITU     1
#> 3   511      ZAN Zanzibar zanzibar 1964     UN     1
#> 4   511      ZAN Zanzibar zanzibar 1964    UPU     1

# Use codes to get countries
igo_state_membership("2", year = 1865)
#>   ccode stateabb                 statenme state year ioname value
#> 1     2      USA United States of America   usa 1865 ICCSLT     1
#>          category                         orgname
#> 1 Full Membership Intl Comm of Cape Spartel Light
#>                                                     longorgname political
#> 1 International Commission of the Cape Spartel Light in Tangier         0
#>   social economic
#> 1      0        1

# Extract different status
igo_state_membership("kosovo", status = c(
  "Associate Membership", "Observer",
  "Full Membership"
))
#>   ccode stateabb statenme  state year ioname value             category
#> 1   347      KOS   Kosovo kosovo 2014   EBRD     1      Full Membership
#> 2   347      KOS   Kosovo kosovo 2014   IBRD     1      Full Membership
#> 3   347      KOS   Kosovo kosovo 2014    IFC     1      Full Membership
#> 4   347      KOS   Kosovo kosovo 2014    IMF     1      Full Membership
#> 5   347      KOS   Kosovo kosovo 2014   MIGA     1      Full Membership
#> 6   347      KOS   Kosovo kosovo 2014   ACCT     2 Associate Membership
#>                                          orgname
#> 1 European Bank for Reconstruction & Development
#> 2                                     World Bank
#> 3                      Int'l Finance Corporation
#> 4                             Intl Monetary Fund
#> 5       Multilateral Investment Guarantee Agency
#> 6                             Francophone Agency
#>                                                          longorgname political
#> 1            European Bank for Reconstruction and Development (EBRD)         0
#> 2 International Bank for Reconstruction and Development (World Bank)         0
#> 3                            International Finance Corporation (IFC)         0
#> 4                                        International Monetary Fund         0
#> 5                    Multilateral Investment Guarantee Agency (MIGA)         0
#> 6                                   Agence de La Francophonie (ACCT)         0
#>   social economic
#> 1      0        1
#> 2      0        1
#> 3      0        1
#> 4      0        1
#> 5      0        1
#> 6      1        0

# Vectorized
igo_state_membership(c("usa", "spain"), year = 1870:1871)
#>   ccode stateabb                 statenme state year ioname value
#> 1     2      USA United States of America   usa 1870 ICCSLT     1
#> 2     2      USA United States of America   usa 1871 ICCSLT     1
#> 3   230      SPN                    Spain spain 1870 ICCSLT     1
#> 4   230      SPN                    Spain spain 1870    ITU     1
#> 5   230      SPN                    Spain spain 1870    SCH     1
#> 6   230      SPN                    Spain spain 1871 ICCSLT     1
#> 7   230      SPN                    Spain spain 1871    ITU     1
#> 8   230      SPN                    Spain spain 1871    SCH     1
#>          category                         orgname
#> 1 Full Membership Intl Comm of Cape Spartel Light
#> 2 Full Membership Intl Comm of Cape Spartel Light
#> 3 Full Membership Intl Comm of Cape Spartel Light
#> 4 Full Membership              Intl Telecom Union
#> 5 Full Membership      Superior Council of Health
#> 6 Full Membership Intl Comm of Cape Spartel Light
#> 7 Full Membership              Intl Telecom Union
#> 8 Full Membership      Superior Council of Health
#>                                                     longorgname political
#> 1 International Commission of the Cape Spartel Light in Tangier         0
#> 2 International Commission of the Cape Spartel Light in Tangier         0
#> 3 International Commission of the Cape Spartel Light in Tangier         0
#> 4                         International Telecommunication Union         0
#> 5                                    Superior Council of Health         0
#> 6 International Commission of the Cape Spartel Light in Tangier         0
#> 7                         International Telecommunication Union         0
#> 8                                    Superior Council of Health         0
#>   social economic
#> 1      0        1
#> 2      0        1
#> 3      0        1
#> 4      0        1
#> 5      1        0
#> 6      0        1
#> 7      0        1
#> 8      1        0

# Use countrycodes package to get additional codes
if (requireNamespace("countrycode", quietly = TRUE)) {
  library(countrycode)
  IT <- igo_state_membership("Italy", year = 1880)
  IT$iso3c <- countrycode(IT$ccode, origin = "cown", destination = "iso3c")
  head(IT)
}
#>   ccode stateabb statenme state year ioname value        category
#> 1   325      ITA    Italy italy 1880   BIPM     1 Full Membership
#> 2   325      ITA    Italy italy 1880   ECCD     1 Full Membership
#> 3   325      ITA    Italy italy 1880 ICCSLT     1 Full Membership
#> 4   325      ITA    Italy italy 1880 IPentC     1 Full Membership
#> 5   325      ITA    Italy italy 1880    ITU     1 Full Membership
#> 6   325      ITA    Italy italy 1880    SCH     1 Full Membership
#>                                      orgname
#> 1 International Bureau of Weights & Measures
#> 2            Euro Comm for Control of Danube
#> 3            Intl Comm of Cape Spartel Light
#> 4                     Intl Penitentiary Comm
#> 5                         Intl Telecom Union
#> 6                 Superior Council of Health
#>                                                     longorgname political
#> 1           International Bureau of Weights and Measures (BIPM)         0
#> 2                 European Commission for Control of the Danube         0
#> 3 International Commission of the Cape Spartel Light in Tangier         0
#> 4                         International Penitentiary Commission         0
#> 5                         International Telecommunication Union         0
#> 6                                    Superior Council of Health         0
#>   social economic iso3c
#> 1      0        1   ITA
#> 2      1        0   ITA
#> 3      0        1   ITA
#> 4      1        0   ITA
#> 5      0        1   ITA
#> 6      1        0   ITA
```
