# Finds codes and names of a state

Find codes and names of a state.

## Usage

``` r
igo_search_states(state)
```

## Source

[**Codebook Version 3 IGO
Data**](https://correlatesofwar.org/data-sets/IGOs/) for full reference.

## Arguments

- state:

  Any valid name or code of a state as specified on
  [`states2016()`](https://dieghernan.github.io/igoR/dev/reference/states2016.md).
  It can be also an array of states.

## Value

A [`data.frame`](https://rdrr.io/r/base/data.frame.html).

## References

Pevehouse, J. C., Nordstrom, T., McManus, R. W., & Jamison, A. S.
(2020). Tracking organizations in the world: The Correlates of War IGO
Version 3.0 datasets. *Journal of Peace Research, 57*(3), 492–503.
[doi:10.1177/0022343319881175](https://doi.org/10.1177/0022343319881175)
.

## See also

[`states2016()`](https://dieghernan.github.io/igoR/dev/reference/states2016.md).

## Examples

``` r
library(dplyr)

igo_search_states("Spain") %>% as_tibble()
#> # A tibble: 1 × 4
#>   ccode stateabb statenme state
#>   <int> <chr>    <chr>    <chr>
#> 1   230 SPN      Spain    spain

igo_search_states(c(20, 150)) %>% as_tibble()
#> # A tibble: 2 × 4
#>   ccode stateabb statenme state   
#>   <int> <chr>    <chr>    <chr>   
#> 1    20 CAN      Canada   canada  
#> 2   150 PAR      Paraguay paraguay

igo_search_states("congo") %>% as_tibble()
#> # A tibble: 1 × 4
#>   ccode stateabb statenme state     
#>   <int> <chr>    <chr>    <chr>     
#> 1   484 CON      Congo    congobrazz

igo_search_states(c("Germany", "papal states")) %>% as_tibble()
#> # A tibble: 2 × 4
#>   ccode stateabb statenme     state      
#>   <int> <chr>    <chr>        <chr>      
#> 1   255 GMY      Germany      germany    
#> 2   327 PAP      Papal States papalstates

igo_search_states(c("FRN", "United Kingdom", 240, "italy")) %>% as_tibble()
#> # A tibble: 4 × 4
#>   ccode stateabb statenme       state  
#>   <int> <chr>    <chr>          <chr>  
#> 1   220 FRN      France         france 
#> 2   200 UKG      United Kingdom uk     
#> 3   240 HAN      Hanover        hanover
#> 4   325 ITA      Italy          italy  
```
