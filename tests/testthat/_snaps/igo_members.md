# Testing messages 

    Code
      res <- igo_members("Error")
    Message
      ioname 'Error' not found in data base
      No results for query

---

    Code
      res <- igo_members("EU", year = 1900)
    Message
      ioname 'EU' only alive between 1993 and 2014
      No results for query

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
      No members for ioname 'EU' with the parameters provided.
      No results for query

