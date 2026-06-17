# Testing messages 

    Code
      res <- igo_state_membership("Error")
    Message
      Unknown value for `state`: 'Error'.
    Condition
      Warning in `igo_state_membership()`:
      Unknown values for `state`: 'Error'.

---

    Code
      res <- igo_state_membership("modena", year = 1900)
    Message
      State 'modena' is available from 1842 to 1860.
    Condition
      Warning in `igo_state_membership()`:
      No IGO membership records were found for the supplied arguments.

---

    Code
      res <- igo_state_membership("uk", status = c("Nope", "IGO Not In Existence",
        "Full Membership", "Observer"))
    Condition
      Warning in `igo_state_membership()`:
      Unknown values for `status`: 'Nope', 'IGO Not In Existence'. Valid values are 'No Membership', 'Full Membership', 'Associate Membership', 'Observer', 'Missing data', 'State Not System Member'.

---

    Code
      res <- igo_state_membership("spain", year = 1900, status = "Observer")
    Message
      No membership records for state 'spain' matched the supplied arguments.
    Condition
      Warning in `igo_state_membership()`:
      No IGO membership records were found for the supplied arguments.

# Extract several cntries

    Code
      sev <- igo_state_membership(c("UnitEd KingDom", "SPAIN", "aga haha", "1298",
        "WGeRMANy"))
    Message
      Unknown value for `state`: 'aga haha'.
      Unknown value for `state`: '1298'.

# Object classes

    Code
      vapply(sev, class, character(1))
    Output
            ccode    stateabb    statenme       state        year      ioname 
        "numeric" "character" "character" "character"   "numeric" "character" 
            value    category     orgname longorgname   political      social 
        "numeric"    "factor" "character" "character"   "numeric"   "numeric" 
         economic 
        "numeric" 

# Cleanup

    Code
      var_err <- igo_state_membership(c("uk", "invented", "usa"))
    Message
      Unknown value for `state`: 'invented'.

