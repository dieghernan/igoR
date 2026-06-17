# Search for IGOs

Searches for IGOs by name or regular expression.

## Usage

``` r
igo_search(pattern = NULL, exact = FALSE)
```

## Source

[Codebook Version 3 IGO
Data](https://correlatesofwar.org/data-sets/IGOs/) for the full
reference.

## Arguments

- pattern:

  A [regular expression](https://rdrr.io/r/base/regex.html) used to
  match IGO names and identifiers. If `NULL`, all IGOs in
  [igo_year_format3](https://dieghernan.github.io/igoR/dev/reference/igo_year_format3.md)
  are returned. Integer values are accepted.

- exact:

  A logical value. If `TRUE`, `pattern` is anchored to require a
  complete match.

## Value

A [`data.frame`](https://rdrr.io/r/base/data.frame.html) with IGO
identifiers, names, dates and other metadata from the latest available
year for each IGO.

## Details

The information for each IGO is retrieved from the latest year available
in
[igo_year_format3](https://dieghernan.github.io/igoR/dev/reference/igo_year_format3.md).

The `label` column provides a cleaned version of `longorgname`.

## References

Pevehouse, J. C., Nordstrom, T., McManus, R. W. & Jamison, A. S. (2020).
Tracking organizations in the world: The Correlates of War IGO Version
3.0 data sets. *Journal of Peace Research, 57*(3), 492–503.
[doi:10.1177/0022343319881175](https://doi.org/10.1177/0022343319881175)
.

## See also

[igo_year_format3](https://dieghernan.github.io/igoR/dev/reference/igo_year_format3.md).

Other query functions:
[`igo_search_states()`](https://dieghernan.github.io/igoR/dev/reference/igo_search_states.md)

## Examples

``` r
# Return all values.
library(dplyr)
all <- igo_search()

all %>% tibble()
#> # A tibble: 534 × 18
#>    ionum ioname   orgname      longorgname label sdate deaddate  dead integrated
#>    <dbl> <chr>    <chr>        <chr>       <chr> <dbl>    <dbl> <dbl>      <dbl>
#>  1   370 AAAID    Arab Auth. … Arab Autho… "Ara…  1976       NA     0          0
#>  2   690 AACB     Assoc. of A… Associatio… "Ass…  1968       NA     0          0
#>  3   630 AALCO    Asian-Afric… Asian-Afri… "Asi…  1956       NA     0          0
#>  4   230 AARO     Afro-Asian … Afro-Asian… "Afr…  1962       NA     0          0
#>  5   700 AATA     Assoc. of A… Associatio… "Ass…  1987       NA     0          0
#>  6   710 AATPO    Assoc. of A… Associatio… "Ass…  1974     1992     1          1
#>  7   380 ABEDA    Arab Bank f… Arab Bank … "Ara…  1974       NA     0          0
#>  8   680 ABEPSEAC Assoc. B/t … Associatio… "Ass…  1968     1975     1          0
#>  9   400 ACC      Arab Cooper… Arab Coope… "Ara…  1989     1990     1          0
#> 10   270 ACCT     Francophone… Agence de … "Age…  1970     2005     1          0
#> # ℹ 524 more rows
#> # ℹ 9 more variables: replaced <dbl>, igocode <dbl>, version <dbl>,
#> #   accuracyofpre1965membershipdates <chr>, sourcesandnotes <chr>,
#> #   imputed <dbl>, political <dbl>, social <dbl>, economic <dbl>

# Search by pattern.
igo_search("EU") %>%
  select(ionum:orgname) %>%
  tibble()
#> # A tibble: 55 × 3
#>    ionum ioname   orgname                                         
#>    <dbl> <chr>    <chr>                                           
#>  1   680 ABEPSEAC Assoc. B/t EEC and States of East Afr. Community
#>  2    10 ACPEU    ACP/EU Joint Assembly                           
#>  3   150 APPA     African Petroleum Producers Assoc.              
#>  4   540 ASEF     Asia-Europe Foundation                          
#>  5  1020 CEEPN    Central & Eastern Eur. Privatization Network    
#>  6  1070 CEFTA    Central Europe FTA                              
#>  7  1080 CEI      Central European Initiative                     
#>  8  1720 CERN     European Org for Nuclear Research               
#>  9  1390 COE      Council of Europe                               
#> 10  1300 CONFEJES Conference des Ministres jeunesse...Francais    
#> # ℹ 45 more rows

igo_search("EU", exact = TRUE) %>%
  select(ionum:orgname) %>%
  tibble()
#> # A tibble: 1 × 3
#>   ionum ioname orgname       
#>   <dbl> <chr>  <chr>         
#> 1  1830 EU     European Union

# Search by numeric identifier.
igo_search(10) %>%
  select(ionum:orgname) %>%
  tibble()
#> # A tibble: 62 × 3
#>    ionum ioname orgname                             
#>    <dbl> <chr>  <chr>                               
#>  1   710 AATPO  Assoc. of Afr. Trade Promotion Orgs.
#>  2    10 ACPEU  ACP/EU Joint Assembly               
#>  3   100 AFGEC  Afr. Fund Guarantee & Econ. Coop.   
#>  4   410 AFTE   Arab Federation for Technical Educ. 
#>  5   110 AGC    African Groundnut Council           
#>  6   510 AOMR   Arab Org. for Mineral Resources     
#>  7   610 ARC    Asian Reinsurance Corp.             
#>  8   210 ATO    African Timber Org.                 
#>  9   310 AmCC   Amazonian Coop. Council             
#> 10   810 BIS    Bank for International Settlements  
#> # ℹ 52 more rows

igo_search(10, exact = TRUE) %>%
  select(ionum:orgname) %>%
  tibble()
#> # A tibble: 1 × 3
#>   ionum ioname orgname              
#>   <dbl> <chr>  <chr>                
#> 1    10 ACPEU  ACP/EU Joint Assembly

# Search with a regular expression.
igo_search("NAFTA|UN|EU") %>%
  select(ionum:orgname) %>%
  tibble()
#> # A tibble: 196 × 3
#>    ionum ioname   orgname                                                  
#>    <dbl> <chr>    <chr>                                                    
#>  1   680 ABEPSEAC Assoc. B/t EEC and States of East Afr. Community         
#>  2   400 ACC      Arab Cooperation Council                                 
#>  3    10 ACPEU    ACP/EU Joint Assembly                                    
#>  4   570 ACU      Asian Clearing Union                                     
#>  5   420 AFESD    Arab Fund for Social/Economic Development                
#>  6   100 AFGEC    Afr. Fund Guarantee & Econ. Coop.                        
#>  7   160 AFPU     African Postal Union                                     
#>  8    90 AFRAND   Afr. Foundation for R & D                                
#>  9   725 AFSPC    Association of Financial Supervisors of Pacific Countries
#> 10   110 AGC      African Groundnut Council                                
#> # ℹ 186 more rows

# Search for several exact identifiers.
igo_search("^NAFTA$|^UN$|^EU$") %>%
  select(ionum:orgname) %>%
  tibble()
#> # A tibble: 3 × 3
#>   ionum ioname orgname           
#>   <dbl> <chr>  <chr>             
#> 1  1830 EU     European Union    
#> 2  3670 NAFTA  North American FTA
#> 3  4400 UN     United Nations    
```
