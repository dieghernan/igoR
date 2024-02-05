# Search states

    Code
      n <- igo_search_states(c("Spain", "aaa", "france"))
    Message
      state not found: 'aaa'

---

    Code
      n <- igo_search_states("aaaaa")
    Message
      state not found: 'aaaaa'
    Condition
      Warning in `igo_search_states()`:
      No states found with required parameters

