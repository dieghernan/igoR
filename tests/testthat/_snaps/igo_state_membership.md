# Testing state members

    Code
      igo_state_membership("Spain", status = "Error")
    Condition
      Warning in `igo_state_membership()`:
      status 'Error' not valid. Valid values are 'No Membership', 'Full Membership', 'Associate Membership', 'Observer', 'Missing Data', 'State Not System Member'
      Error in `igo_state_membership()`:
      ! status values not valid

---

    Code
      s <- igo_state_membership("Spain", status = c("Full Membership", "Error"))
    Condition
      Warning in `igo_state_membership()`:
      status 'Error' not valid. Valid values are 'No Membership', 'Full Membership', 'Associate Membership', 'Observer', 'Missing Data', 'State Not System Member'

