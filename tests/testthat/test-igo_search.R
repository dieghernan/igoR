test_that("search returns all IGOs when no pattern is supplied", {
  all_igos <- igo_search()

  expect_s3_class(all_igos, "data.frame", exact = TRUE)
  expect_disjoint("year", names(all_igos))
  expect_identical(row.names(all_igos), as.character(seq_len(nrow(all_igos))))
  expect_contains(
    names(all_igos),
    c("ionum", "ioname", "orgname", "longorgname", "label")
  )
  expect_identical(anyDuplicated(all_igos$ioname), 0L)
})

test_that("pattern search matches IGO identifiers and organization names", {
  matches <- igo_search("EU")

  expect_in("EU", matches$ioname)
  expect_in("WEU", matches$ioname)
  expect_in(10, matches$ionum)
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

test_that("missing search patterns return NULL with a warning", {
  expect_snapshot(res <- igo_search(NA))

  expect_null(res)
})

test_that("invalid regular expressions produce an informative error", {
  expect_error(
    igo_search("[invalid"),
    "invalid regular expression",
    class = "simpleError"
  )
})

test_that("missing exact flags produce an informative error", {
  expect_error(
    igo_search("EU", exact = NA),
    "missing value where TRUE/FALSE needed",
    class = "simpleError",
    fixed = TRUE
  )
})
