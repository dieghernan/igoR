# Testing messages 

    Code
      n <- igo_dyadic("USA", "CUBA", year = NULL)
    Condition
      Warning in `igo_dyadic()`:
      year must be numeric, not NULL.

---

    Code
      n <- igo_dyadic("USA", "Cuba", 1900)
    Message
      Country 'cuba' was not alive in the selected years.
    Condition
      Warning in `igo_dyadic()`:
      No dyadic results found with the required arguments.

---

    Code
      n <- igo_dyadic("USA", "USA")
    Condition
      Warning in `igo_dyadic()`:
      No different countries found for comparison in 'country1' and 'country2' values.

---

    Code
      n <- igo_dyadic("USA", "Cuba", ioname = "Not an IGO")
    Message
      No valid ionames used with 'not an igo'.
    Condition
      Warning in `igo_dyadic()`:
      No dyadic results found with the required arguments.

---

    Code
      n <- igo_dyadic("Not a country", "banana", 1900)
    Message
      State not found: 'Not a country'.
    Condition
      Warning in `igo_search_states()`:
      No states found with the required arguments.
    Message
      State not found: 'banana'.
    Condition
      Warning in `igo_search_states()`:
      No states found with the required arguments.
      Warning in `igo_dyadic()`:
      No countries found for comparison.

---

    Code
      n <- igo_dyadic("Cuba", "USa", 1900)
    Message
      Country 'cuba' was not alive in the selected years.
    Condition
      Warning in `igo_dyadic()`:
      No dyadic results found with the required arguments.

---

    Code
      n <- igo_dyadic("France", "Spain", 2200)
    Message
      No ionames found for the selected years.
    Condition
      Warning in `igo_dyadic()`:
      No dyadic results found with the required arguments.

# Test calls

    Code
      aa[, c("state1", "state2", "year")]
    Output
        state1 state2 year
      1    usa   cuba 1991
      2    usa   cuba 1992
      3    usa mexico 1991
      4    usa mexico 1992
      5   cuba mexico 1991
      6   cuba mexico 1992

---

    Code
      aa <- igo_dyadic("USA", "Spain", 1990, c("un", "random"))

