# Testing messages 

    Code
      res <- igo_members("Error")
    Message
      ioname 'Error' not found in data base
    Condition
      Warning in `igo_members()`:
      No IGO results found with the required arguments

---

    Code
      res <- igo_members("EU", year = 1900)
    Message
      ioname 'EU' only alive between 1993 and 2014
    Condition
      Warning in `igo_members()`:
      No IGO results found with the required arguments

---

    Code
      res <- igo_members("IOLM", status = c("Nope", "IGO Not In Existence",
        "Full Membership", "Observer"))
    Condition
      Warning in `igo_members()`:
      status 'Nope' not valid. Valid values are 'No Membership', 'Full Membership', 'Associate Membership', 'Observer', 'Missing data', 'IGO Not In Existence'

---

    Code
      res <- igo_members("EU", status = "Observer")
    Message
      No members for ioname 'EU' with the arguments provided.
    Condition
      Warning in `igo_members()`:
      No IGO results found with the required arguments

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
      ioname 'an invented' not found in data base

