test_that("search returns all IGOs when no pattern is supplied", {
  all_igos <- igo_search()

  expect_s3_class(all_igos, "data.frame", exact = TRUE)
  expect_false("year" %in% names(all_igos))
  expect_identical(row.names(all_igos), as.character(seq_len(nrow(all_igos))))
  expect_true(all(
    c("ionum", "ioname", "orgname", "longorgname", "label") %in%
      names(all_igos)
  ))
  expect_identical(anyDuplicated(all_igos$ioname), 0L)
})

test_that("pattern search matches IGO identifiers and organization names", {
  matches <- igo_search("EU")

  expect_identical(nrow(matches), 55L)
  expect_true("EU" %in% matches$ioname)
  expect_true("WEU" %in% matches$ioname)
  expect_true(10 %in% matches$ionum)
})

test_that("exact search is case-insensitive across identifiers", {
  by_name <- igo_search("UN", exact = TRUE)
  by_number <- igo_search(by_name$ionum, exact = TRUE)

  expect_identical(by_name$ioname, "UN")
  expect_identical(by_number$ioname, by_name$ioname)
})

test_that("exact search returns a single IGO and cleaned label", {
  eu <- igo_search("EU", exact = TRUE)

  expect_identical(nrow(eu), 1L)
  expect_identical(eu$ionum, 1830)
  expect_identical(eu$ioname, "EU")
  expect_identical(eu$orgname, "European Union")
  expect_no_match(eu$label, "\\(")
})

test_that("unknown IGO searches return NULL", {
  expect_snapshot(res <- igo_search("Expect Error"))

  expect_null(res)
})
