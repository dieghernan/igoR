# recode igo year

    Code
      igo_recode_igoyear(c(0, 1, 2, 3))
    Output
      [1] No Membership        Full Membership      Associate Membership
      [4] Observer            
      7 Levels: No Membership Full Membership Associate Membership ... <NA>

---

    Code
      checkl
    Output
      [1] <NA>                    <NA>                    Missing data           
      [4] State Not System Member
      7 Levels: No Membership Full Membership Associate Membership ... <NA>

---

    Code
      igo_recode_igoyear(-1)
    Output
      [1] State Not System Member
      7 Levels: No Membership Full Membership Associate Membership ... <NA>

# recode state year

    Code
      igo_recode_stateyear(c(0, 1, 2, 3))
    Output
      [1] No Membership        Full Membership      Associate Membership
      [4] Observer            
      7 Levels: No Membership Full Membership Associate Membership ... <NA>

---

    Code
      checkl
    Output
      [1] <NA>                 <NA>                 Missing data        
      [4] IGO Not In Existence
      7 Levels: No Membership Full Membership Associate Membership ... <NA>

---

    Code
      igo_recode_stateyear(-1)
    Output
      [1] IGO Not In Existence
      7 Levels: No Membership Full Membership Associate Membership ... <NA>

