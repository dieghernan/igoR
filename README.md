
<!-- README.md is generated from README.Rmd. Please edit that file -->

# igoR <a href='https://dieghernan.github.io/igoR/'><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/igoR)](https://CRAN.R-project.org/package=igoR)
[![CRAN
results](https://badges.cranchecks.info/worst/igoR.svg)](https://cran.r-project.org/web/checks/check_results_igoR.html)
[![CRAN-Downloads](https://cranlogs.r-pkg.org/badges/grand-total/igoR)](https://cran.r-project.org/package=igoR)
[![r-universe](https://dieghernan.r-universe.dev/badges/igoR)](https://dieghernan.r-universe.dev/)
[![R-CMD-check](https://github.com/dieghernan/igoR/actions/workflows/check-full.yaml/badge.svg)](https://github.com/dieghernan/igoR/actions/workflows/check-full.yaml)
[![R-hub](https://github.com/dieghernan/igoR/actions/workflows/rhub.yaml/badge.svg)](https://github.com/dieghernan/igoR/actions/workflows/rhub.yaml)
[![codecov](https://codecov.io/gh/dieghernan/igoR/branch/main/graph/badge.svg?token=UH3VLTTTRE)](https://app.codecov.io/gh/dieghernan/igoR)
[![CodeFactor](https://www.codefactor.io/repository/github/dieghernan/igor/badge)](https://www.codefactor.io/repository/github/dieghernan/igor)
[![DOI](https://img.shields.io/badge/DOI-10.32614/CRAN.package.igoR-blue)](https://doi.org/10.32614/CRAN.package.igoR)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![status](https://tinyverse.netlify.app/status/igoR)](https://CRAN.R-project.org/package=igoR)

<!-- badges: end -->

The goal of **igoR** is to provide access and to extract information
from the Intergovernmental Organizations Database (IGOs), version 3,
provided by the Correlates of War Project ([Pevehouse et al.
2020](#ref-pevehouse2020)).

The dataset (V3) includes information of **534** IGOs from 1816 to 2014,
as well as membership information.

- Source: [Intergovernmental Organizations
  (v3)](https://correlatesofwar.org/data-sets/IGOs/).
- Documentation and vignettes on <https://dieghernan.github.io/igoR/>

Additionally, a distribution of the State System Membership ([Correlates
of War Project 2017](#ref-correlatesofwarproject2017)) is included on
this package.

## Installation

Install **igoR** from
[**CRAN**](https://CRAN.R-project.org/package=igoR):

``` r
install.packages("igoR")
```

You can install the developing version from GitHub:

``` r
library(remotes)
install_github("dieghernan/igoR")
```

Alternatively, you can install **igoR** using the
[r-universe](https://dieghernan.r-universe.dev/igoR):

``` r
# Install igoR in R:
install.packages("igoR", repos = c(
  "https://dieghernan.r-universe.dev",
  "https://cloud.r-project.org"
))
```

## Basic usage

### Search an IGO by name:

Search all IGOs related with “sugar”:

``` r
library(igoR)

result_sugar <- igo_search("Sugar")
```

| ionum | ioname  | orgname                                    | longorgname                                                     | label                                                           | sdate | deaddate | dead | integrated | replaced | igocode | version | accuracyofpre1965membershipdates                      | sourcesandnotes | imputed | political | social | economic |
|------:|:--------|:-------------------------------------------|:----------------------------------------------------------------|:----------------------------------------------------------------|------:|---------:|-----:|-----------:|---------:|--------:|--------:|:------------------------------------------------------|:----------------|--------:|----------:|-------:|---------:|
|    40 | AMSC    | African/Malgasy Sugar Council              | African and Malagasy Sugar Council                              | African and Malagasy Sugar Council                              |  1966 |     1977 |    1 |          0 |        0 |      NA |     2.1 | Not applicable - created 1965 or later                |                 |       0 |         0 |      0 |        1 |
|  1920 | GLACSEC | Group of L/A & Carib. Sugar Exp. Countries | Group of Latin American and Caribbean Sugar Exporting Countries | Group of Latin American and Caribbean Sugar Exporting Countries |  1974 |     2001 |    1 |          0 |        0 |      NA |     2.3 | Not applicable - created 1965 or later                |                 |       0 |         1 |      0 |        0 |
|  3130 | ISuC    | Intl Sugar Council                         | International Sugar Council                                     | International Sugar Council                                     |  1937 |     1967 |    1 |          0 |        0 |      91 |     3.0 | Within 5 years                                        |                 |       0 |         0 |      1 |        0 |
|  4290 | SugU    | Sugar Union                                | Sugar Union                                                     | Sugar Union                                                     |  1902 |     1913 |    1 |          0 |        0 |      29 |     3.0 | Completely accurate, except a few minor uncertainties |                 |       0 |         0 |      0 |        1 |

### IGO members:

Composition of the [European Economic
Community](https://en.wikipedia.org/wiki/European_Economic_Community)
over time:

``` r
eec_code <- igo_search("EEC", exact = TRUE)

# Founding
eec_init <- igo_members(eec_code$ioname, year = eec_code$sdate)
```

| ioname | ccode | state       | statenme                | year | value | category        | orgname                     |
|:-------|------:|:------------|:------------------------|-----:|------:|:----------------|:----------------------------|
| EEC    |   210 | netherlands | Netherlands             | 1958 |     1 | Full Membership | European Economic Community |
| EEC    |   211 | belgium     | Belgium                 | 1958 |     1 | Full Membership | European Economic Community |
| EEC    |   212 | luxembourg  | Luxembourg              | 1958 |     1 | Full Membership | European Economic Community |
| EEC    |   220 | france      | France                  | 1958 |     1 | Full Membership | European Economic Community |
| EEC    |   260 | wgermany    | German Federal Republic | 1958 |     1 | Full Membership | European Economic Community |
| EEC    |   325 | italy       | Italy                   | 1958 |     1 | Full Membership | European Economic Community |

EEC, members (1958)

``` r
# Latest date
eec_end <- igo_members(eec_code$ioname)
```

| ioname | ccode | state       | statenme       | year | value | category        | orgname                     |
|:-------|------:|:------------|:---------------|-----:|------:|:----------------|:----------------------------|
| EEC    |   200 | uk          | United Kingdom | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   205 | ireland     | Ireland        | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   210 | netherlands | Netherlands    | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   211 | belgium     | Belgium        | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   212 | luxembourg  | Luxembourg     | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   220 | france      | France         | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   230 | spain       | Spain          | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   235 | portugal    | Portugal       | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   255 | germany     | Germany        | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   325 | italy       | Italy          | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   350 | greece      | Greece         | 1992 |     1 | Full Membership | European Economic Community |
| EEC    |   390 | denmark     | Denmark        | 1992 |     1 | Full Membership | European Economic Community |

EEC, members (1992)

## Recommended packages

- **countrycode** for converting country names and codes across
  different systems (ISO3, Eurostat, World Bank, UN, FIPS/GEC, etc..)
- **dplyr** for data manipulation.

## Citation

<p>
Hernangómez D (2025). <em>igoR: Intergovernmental Organizations
Database</em>.
<a href="https://doi.org/10.32614/CRAN.package.igoR">doi:10.32614/CRAN.package.igoR</a>,
<a href="https://dieghernan.github.io/igoR/">https://dieghernan.github.io/igoR/</a>.
</p>

A BibTeX entry for LaTeX users:

    @Manual{R-igoR,
      title = {{igoR}: Intergovernmental Organizations Database},
      doi = {10.32614/CRAN.package.igoR},
      author = {Diego Hernangómez},
      year = {2025},
      version = {0.2.1},
      url = {https://dieghernan.github.io/igoR/},
      abstract = {Tools to extract information from the Intergovernmental Organizations (IGO) Database , version 3, provided by the Correlates of War Project <https://correlatesofwar.org/>. See also Pevehouse, J. C. et al. (2020). Version 3 includes information from 1815 to 2014.},
    }

## References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-correlatesofwarproject2017" class="csl-entry">

Correlates of War Project. 2017. “State System Membership List, V2016.”
<https://correlatesofwar.org/data-sets/state-system-membership/>.

</div>

<div id="ref-pevehouse2020" class="csl-entry">

Pevehouse, Jon CW, Timothy Nordstrom, Roseanne W McManus, and Anne
Spencer Jamison. 2020. “Tracking Organizations in the World: The
Correlates of War IGO Version 3.0 Datasets.” *Journal of Peace Research*
57 (3): 492–503. <https://doi.org/10.1177/0022343319881175>.

</div>

</div>

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

All contributions to this project are gratefully acknowledged using the
[`allcontributors` package](https://github.com/ropensci/allcontributors)
following the [allcontributors](https://allcontributors.org)
specification. Contributions of any kind are welcome!

<table class="table allctb-table">
<tr>
<td align="center">
<a href="https://github.com/dieghernan">
<img src="https://avatars.githubusercontent.com/u/25656809?v=4" width="100px;" class="allctb-avatar" alt=""/>
</a><br>
<a href="https://github.com/dieghernan/igoR/commits?author=dieghernan">dieghernan</a>
</td>
</tr>
</table>
<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->
