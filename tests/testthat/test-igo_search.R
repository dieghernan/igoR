test_that("Testing search", {
  expect_silent(igo_search())
  expect_true(nrow(igo_search("EU")) > 1)
  expect_true(nrow(igo_search("EU", exact = TRUE)) == 1)
  expect_silent(igo_search("abepseac"))
  expect_snapshot(igo_search("Expect Error"))
})

test_that("Search returns latest IGO records with stable columns", {
  all_igos <- igo_search()

  expect_false("year" %in% names(all_igos))
  expect_identical(row.names(all_igos), as.character(seq_len(nrow(all_igos))))
  expect_true(all(
    c("ionum", "ioname", "orgname", "longorgname", "label") %in%
      names(all_igos)
  ))
  expect_false(anyDuplicated(all_igos$ioname) > 0)
})

test_that("Exact search is case-insensitive across identifiers", {
  by_name <- igo_search("UN", exact = TRUE)
  by_number <- igo_search(by_name$ionum, exact = TRUE)

  expect_identical(by_name$ioname, "UN")
  expect_identical(by_number$ioname, by_name$ioname)
})
