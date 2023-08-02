# Testing state members

    Code
      igo_state_membership("Spain", status = "Error")
    Warning <simpleWarning>
      status 'Error' not valid. Valid values are 'No Membership', 'Full Membership', 'Associate Membership', 'Observer', 'Missing Data', 'State Not System Member'
    Error <simpleError>
      status values not valid

---

    Code
      s <- igo_state_membership("Spain", status = c("Full Membership", "Error"))
    Warning <simpleWarning>
      status 'Error' not valid. Valid values are 'No Membership', 'Full Membership', 'Associate Membership', 'Observer', 'Missing Data', 'State Not System Member'

