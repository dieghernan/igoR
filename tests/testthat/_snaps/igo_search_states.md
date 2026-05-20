# Search states

    Code
      n <- igo_search_states(c("Spain", "aaa", "france"))
    Message
      State not found: 'aaa'.

---

    Code
      n <- igo_search_states("aaaaa")
    Message
      State not found: 'aaaaa'.
    Condition
      Warning in `igo_search_states()`:
      No states found with the required arguments.

