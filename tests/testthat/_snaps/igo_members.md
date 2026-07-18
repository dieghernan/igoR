# missing or unknown IGO identifiers return informative conditions

    Code
      s <- igo_members()
    Condition
      Error in `igo_members()`:
      ! `ioname` must be supplied.

---

    Code
      res <- igo_members("Error")
    Message
      Unknown value for `ioname`: 'Error'.
    Condition
      Warning in `igo_members()`:
      No IGO membership records were found for the supplied arguments.

# years outside an IGO lifetime return NULL

    Code
      res <- igo_members("EU", year = 1900)
    Message
      IGO 'EU' is available from 1993 to 2014.
    Condition
      Warning in `igo_members()`:
      No IGO membership records were found for the supplied arguments.

# invalid statuses warn and valid statuses are still used

    Code
      res <- igo_members("IOLM", status = c("Nope", "Full Membership", "Observer"))
    Condition
      Warning in `igo_members()`:
      Unknown values for `status`: 'Nope'. Valid values are 'No Membership', 'Full Membership', 'Associate Membership', 'Observer', 'Missing data', 'IGO Not In Existence'.

# filters with no matching members return NULL

    Code
      res <- igo_members("EU", status = "Observer")
    Message
      No membership records for IGO 'EU' matched the supplied arguments.
    Condition
      Warning in `igo_members()`:
      No IGO membership records were found for the supplied arguments.

# Object classes

    Code
      vapply(sev, class, character(1))
    Output
           ioname       ccode       state    statenme        year       value 
      "character"   "numeric" "character" "character"   "numeric"   "numeric" 
         category     orgname 
         "factor" "character" 

# Cleanup

    Code
      var_err <- igo_members(c("EU", "an invented", "UN"))
    Message
      Unknown value for `ioname`: 'an invented'.

