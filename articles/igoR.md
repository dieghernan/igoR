# Get started with the igoR package

This vignette is meant to provide **useRs** with a visual, explorable
introduction to the capabilities of the **igoR** package.

The analysis is based on those provided in J. C. Pevehouse et al.
([2020](#ref-pevehouse2020)). For more information on the IGO data sets
and additional downloads, see [Intergovernmental Organizations
(v3)](https://correlatesofwar.org/data-sets/IGOs/).

*Note that the dyadic dataset is not provided in the package, due to its
size (~500 MB in Stata `.dta` format). However,*
[`igo_dyadic()`](https://dieghernan.github.io/igoR/reference/igo_dyadic.md)
*function provides similar results.*

## Definitions

From J. Pevehouse, McManus, and Nordstrom ([2019](#ref-pevehouse2019)):

> ### What is an IGO?
>
> The definition of an Intergovernmental Organization (IGO) on the
> original dataset is based on the following criteria:
>
> 1.  An IGO must consist of at least three members of the [COW-defined
>     state
>     system](https://correlatesofwar.org/data-sets/cow-country-codes/).
> 2.  An IGO must hold regular plenary sessions at least once every ten
>     years
> 3.  An IGO must possess a permanent secretariat and corresponding
>     headquarters.
>
> ### When does an IGO actually begin?
>
> The data sets begins to code an IGO by identifying the first year in
> which the organization functions. In some cases, individual members
> are listed by year of accession or signature.
>
> ### When does an IGO die?
>
> Version 3.0 of the IGO data set uses the following criteria:
>
> - An organization is considered terminated when the following words
>   were used to describe the context of the organization:
>   - Replaced;
>   - Succeeded;
>   - Superseded;
>   - Integrated;
>   - Merged;
>   - Dies.

## Analysis

This section provides some quick analysis based on the figures of J. C.
Pevehouse et al. ([2020](#ref-pevehouse2020)).

### Initial Setup

``` r
library(igoR)

# Additional libraries
library(ggplot2)
library(dplyr)
```

Pevehouse, Jon CW, Timothy Nordstrom, Roseanne W McManus, and Anne
Spencer Jamison. 2020. “Tracking Organizations in the World: The
Correlates of War IGO Version 3.0 Datasets.” *Journal of Peace Research*
57 (3): 492–503. <https://doi.org/10.1177/0022343319881175>.

Pevehouse, Jon, Roseanne McManus, and Timothy Nordstrom. 2019. “Codebook
for Correlates of War 3 International Governmental Organizations Data
Set Version
3.0.”[https://correlatesofwar.org/wp-content/uploads/IGO-Codebook_v3_short-copy.pdf](https://correlatesofwar.org/wp-content/uploads/IGO-Codebook_v3_short-copy.pdf%0A%09)
.
