# igoR

**igoR** provides access to the Intergovernmental Organizations (IGO)
Database (v3) from the Correlates of War Project ([Pevehouse et al.
2020](#ref-pevehouse2020)).

The IGO-year data set includes **534** IGOs from 1816 to 2014, plus
state-year membership information.

- Source: [Intergovernmental Organizations
  (v3)](https://correlatesofwar.org/data-sets/IGOs/).
- Documentation and vignettes at <https://dieghernan.github.io/igoR/>.

The package also includes a distribution of the Correlates of War State
System Membership data ([Correlates of War Project
2017](#ref-correlatesofwarproject2017)).

## Installation

Check the documentation for the development version at
<https://dieghernan.github.io/igoR/dev/>.

You can install the development version from GitHub:

``` r

pak::pak("dieghernan/igoR")
```

Alternatively, you can install **igoR** using
[r-universe](https://dieghernan.r-universe.dev/igoR):

``` r

# Install igoR from r-universe.
install.packages(
  "igoR",
  repos = c(
    "https://dieghernan.r-universe.dev",
    "https://cloud.r-project.org"
  )
)
```

## Basic usage

### Search for IGOs by name

Search for all IGOs related to “sugar”.

``` r

library(igoR)

result_sugar <- igo_search("Sugar")
```

| ionum | ioname | orgname | longorgname | label | sdate | deaddate | dead | integrated | replaced | igocode | version | accuracyofpre1965membershipdates | sourcesandnotes | imputed | political | social | economic |
|---:|:---|:---|:---|:---|---:|---:|---:|---:|---:|---:|---:|:---|:---|---:|---:|---:|---:|
| 40 | AMSC | African/Malgasy Sugar Council | African and Malagasy Sugar Council | African and Malagasy Sugar Council | 1966 | 1977 | 1 | 0 | 0 | NA | 2.1 | Not applicable - created 1965 or later |  | 0 | 0 | 0 | 1 |
| 1920 | GLACSEC | Group of L/A & Carib. Sugar Exp. Countries | Group of Latin American and Caribbean Sugar Exporting Countries | Group of Latin American and Caribbean Sugar Exporting Countries | 1974 | 2001 | 1 | 0 | 0 | NA | 2.3 | Not applicable - created 1965 or later |  | 0 | 1 | 0 | 0 |
| 3130 | ISuC | Intl Sugar Council | International Sugar Council | International Sugar Council | 1937 | 1967 | 1 | 0 | 0 | 91 | 3.0 | Within 5 years |  | 0 | 0 | 1 | 0 |
| 4290 | SugU | Sugar Union | Sugar Union | Sugar Union | 1902 | 1913 | 1 | 0 | 0 | 29 | 3.0 | Completely accurate, except a few minor uncertainties |  | 0 | 0 | 0 | 1 |

Table 1: IGOs related to sugar

### IGO members

Extract members of the [European Economic
Community](https://en.wikipedia.org/wiki/European_Economic_Community)
over time.

``` r

eec_code <- igo_search("EEC", exact = TRUE)

# Get founding members.
eec_init <- igo_members(eec_code$ioname, year = eec_code$sdate)
```

| ioname | ccode | state | statenme | year | value | category | orgname |
|:---|---:|:---|:---|---:|---:|:---|:---|
| EEC | 210 | netherlands | Netherlands | 1958 | 1 | Full Membership | European Economic Community |
| EEC | 211 | belgium | Belgium | 1958 | 1 | Full Membership | European Economic Community |
| EEC | 212 | luxembourg | Luxembourg | 1958 | 1 | Full Membership | European Economic Community |
| EEC | 220 | france | France | 1958 | 1 | Full Membership | European Economic Community |
| EEC | 260 | wgermany | German Federal Republic | 1958 | 1 | Full Membership | European Economic Community |
| EEC | 325 | italy | Italy | 1958 | 1 | Full Membership | European Economic Community |

Table 2: EEC, members (1958)

``` r

# Get members in the latest available year.
eec_end <- igo_members(eec_code$ioname)
```

| ioname | ccode | state | statenme | year | value | category | orgname |
|:---|---:|:---|:---|---:|---:|:---|:---|
| EEC | 200 | uk | United Kingdom | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 205 | ireland | Ireland | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 210 | netherlands | Netherlands | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 211 | belgium | Belgium | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 212 | luxembourg | Luxembourg | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 220 | france | France | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 230 | spain | Spain | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 235 | portugal | Portugal | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 255 | germany | Germany | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 325 | italy | Italy | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 350 | greece | Greece | 1992 | 1 | Full Membership | European Economic Community |
| EEC | 390 | denmark | Denmark | 1992 | 1 | Full Membership | European Economic Community |

Table 3: EEC, members (1992)

## Recommended packages

- **countrycode** package for converting country names and codes across
  different systems, including ISO3, Eurostat, World Bank, UN and
  FIPS/GEC.
- **dplyr** package for data manipulation.

## Citation

Hernangómez D (2026). *igoR: Access the Intergovernmental Organizations
Database*.
[doi:10.32614/CRAN.package.igoR](https://doi.org/10.32614/CRAN.package.igoR).
<https://dieghernan.github.io/igoR/>.

A BibTeX entry for LaTeX users:

``` R
@Manual{R-igoR,
  title = {{igoR}: Access the Intergovernmental Organizations Database},
  doi = {10.32614/CRAN.package.igoR},
  author = {Diego Hernangómez},
  year = {2026},
  version = {1.0.2.9000},
  url = {https://dieghernan.github.io/igoR/},
  abstract = {Tools for searching, extracting and recoding information from the Intergovernmental Organizations (IGO) Database (v3), distributed by the Correlates of War Project <https://correlatesofwar.org/>. The package includes IGO-year, state-year and joint membership data. See also Pevehouse, J. C. et al. (2020) <doi:10.1177/0022343319881175>.},
}
```

## References

Correlates of War Project. 2017. *State System Membership List, V2016*.
<https://correlatesofwar.org/data-sets/state-system-membership/>.

Pevehouse, Jon C. W., Timothy Nordstrom, Roseanne W. McManus, and Anne
Spencer Jamison. 2020. “Tracking Organizations in the World: The
Correlates of War IGO Version 3.0 Datasets.” *Journal of Peace Research*
57 (3): 492–503. <https://doi.org/10.1177/0022343319881175>.
