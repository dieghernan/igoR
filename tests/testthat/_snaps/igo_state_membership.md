# Testing messages 

    Code
      res <- igo_state_membership("Error")
    Message
      state not found: 'Error'
    Condition
      Warning in `igoR::igo_search_states()`:
      No states found with required parameters
      Warning in `igo_state_membership()`:
      state(s) 'Error' not found in data base

---

    Code
      res <- igo_state_membership("modena", year = 1900)
    Message
      state 'modena' only alive between 1842 and 1860
    Condition
      Warning in `igo_state_membership()`:
      No states found with the required parameters

---

    Code
      res <- igo_state_membership("uk", status = c("Nope", "IGO Not In Existence",
        "Full Membership", "Observer"))
    Condition
      Warning in `igo_state_membership()`:
      status 'Nope', 'IGO Not In Existence' not valid. Valid values are 'No Membership', 'Full Membership', 'Associate Membership', 'Observer', 'Missing data', 'State Not System Member'

---

    Code
      res <- igo_state_membership("spain", year = 1900, status = "Observer")
    Message
      No IGOs for state 'spain' with the parameters provided.
    Condition
      Warning in `igo_state_membership()`:
      No states found with the required parameters

# Extract several cntries

    Code
      sev <- igo_state_membership(c("UnitEd KingDom", "SPAIN", "aga haha", "1298",
        "WGeRMANy"))
    Message
      state not found: 'aga haha'
      state not found: '1298'

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
      state not found: 'invented'

