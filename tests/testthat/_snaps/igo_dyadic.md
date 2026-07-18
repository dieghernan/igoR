# non-numeric years return NULL with a warning

    Code
      n <- igo_dyadic("USA", "CUBA", year = NULL)
    Condition
      Warning in `igo_dyadic()`:
      `year` must be numeric, not NULL.

# state pairs outside the state system return NULL

    Code
      n <- igo_dyadic("USA", "Cuba", 1900)
    Message
      State 'cuba' was not in the state system in the selected years.
    Condition
      Warning in `igo_dyadic()`:
      No dyad-year results were found for the supplied arguments.

# self-pairs return NULL

    Code
      n <- igo_dyadic("USA", "USA")
    Condition
      Warning in `igo_dyadic()`:
      No distinct states were found between `country1` and `country2`.

# unknown IGO names return NULL

    Code
      n <- igo_dyadic("USA", "Cuba", ioname = "Not an IGO")
    Message
      Unknown values for `ioname`: 'not an igo'.
    Condition
      Warning in `igo_dyadic()`:
      No dyad-year results were found for the supplied arguments.

# unknown states return NULL

    Code
      n <- igo_dyadic("Not a country", "banana", 1900)
    Message
      Unknown value for `state`: 'Not a country'.
      Unknown value for `state`: 'banana'.
    Condition
      Warning in `igo_dyadic()`:
      No valid states were found for comparison.

# partially unavailable state pairs return NULL

    Code
      n <- igo_dyadic("Cuba", "USa", 1900)
    Message
      State 'cuba' was not in the state system in the selected years.
    Condition
      Warning in `igo_dyadic()`:
      No dyad-year results were found for the supplied arguments.

# years outside the IGO data return NULL

    Code
      n <- igo_dyadic("France", "Spain", 2200)
    Message
      No IGO records were found for the selected years.
    Condition
      Warning in `igo_dyadic()`:
      No dyad-year results were found for the supplied arguments.

# unknown selected IGOs are ignored when at least one IGO is valid

    Code
      res <- igo_dyadic("USA", "Spain", 1990, c("un", "random"))

# Dyadic identifiers use both state codes

    Code
      res[, c("dyadid", "ccode1", "ccode2")]
    Output
        dyadid ccode1 ccode2
      1   2230      2    230

