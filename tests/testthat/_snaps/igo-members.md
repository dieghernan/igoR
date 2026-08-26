# missing IGO identifiers produce an informative error

    Code
      igo_members()
    Condition
      Error:
      ! `ioname` must be supplied.

# unknown IGO identifiers return NULL with a warning

    Code
      res <- igo_members("Error")
    Message
      Unknown value for `ioname`: 'Error'.
    Condition
      Warning in `igo_members()`:
      No IGO membership records were found for the supplied arguments.

# empty IGO identifier vectors return NULL with a warning

    Code
      res <- igo_members(character())
    Condition
      Warning in `igo_members()`:
      No IGO membership records were found for the supplied arguments.

# missing IGO identifier values return NULL with a warning

    Code
      res <- igo_members(NA)
    Message
      Unknown value for `ioname`: 'NA'.
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

# unsupported years return NULL with a warning

    Code
      res <- igo_members("EU", year = c(NA, Inf, 1990.5))
    Message
      IGO 'EU' is available from 1993 to 2014.
    Condition
      Warning in `igo_members()`:
      No IGO membership records were found for the supplied arguments.

# NULL status filters return NULL with a warning

    Code
      res <- igo_members("EU", status = NULL)
    Message
      No membership records for IGO 'EU' matched the supplied arguments.
    Condition
      Warning in `igo_members()`:
      No IGO membership records were found for the supplied arguments.

# filters with no matching members return NULL

    Code
      res <- igo_members("EU", status = "Observer")
    Message
      No membership records for IGO 'EU' matched the supplied arguments.
    Condition
      Warning in `igo_members()`:
      No IGO membership records were found for the supplied arguments.

# unknown identifiers are omitted from vectorized results

    Code
      var_err <- igo_members(c("EU", "an invented", "UN"))
    Message
      Unknown value for `ioname`: 'an invented'.

