# Search states

    Code
      n <- igo_search_states(c("Spain", "aaa", "france"))
    Message
      Unknown value for `state`: 'aaa'.

---

    Code
      n <- igo_search_states("aaaaa")
    Message
      Unknown value for `state`: 'aaaaa'.
    Condition
      Warning in `igo_search_states()`:
      No states were found for the supplied arguments.

