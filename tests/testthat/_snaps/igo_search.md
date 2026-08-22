# unknown IGO searches return NULL

    Code
      res <- igo_search("Expect Error")
    Condition
      Warning in `igo_search()`:
      No IGOs matched `pattern`: 'Expect Error'.

# missing search patterns return NULL with a warning

    Code
      res <- igo_search(NA)
    Condition
      Warning in `igo_search()`:
      No IGOs matched `pattern`: 'NA'.

