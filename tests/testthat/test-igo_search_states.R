test_that("state names return matching COW identifiers", {
  res <- igo_search_states("Spain")

  expect_identical(res$ccode, 230L)
  expect_identical(res$stateabb, "SPN")
  expect_identical(res$statenme, "Spain")
  expect_identical(res$state, "spain")
  expect_identical(row.names(res), "1")
})

test_that("invalid state values are dropped from vectorized searches", {
  expect_snapshot(res <- igo_search_states(c("Spain", "aaa", "france")))

  expect_identical(res$state, c("spain", "france"))
  expect_identical(res$ccode, c(230L, 220L))
})

test_that("numeric COW codes return matching states", {
  res <- igo_search_states(c(20, 150))

  expect_identical(res$ccode, c(20L, 150L))
  expect_identical(res$state, c("canada", "paraguay"))
})

test_that("ambiguous state names return the first matching COW state", {
  res <- igo_search_states("congo")

  expect_identical(res$ccode, 484L)
  expect_identical(res$state, "congobrazz")
})

test_that("state abbreviations, names and codes can be combined", {
  res <- igo_search_states(c("FRN", "United Kingdom", 240, "italy"))

  expect_identical(res$ccode, c(220L, 200L, 240L, 325L))
  expect_identical(res$state, c("france", "uk", "hanover", "italy"))
})

test_that("unknown states return NULL", {
  expect_snapshot(res <- igo_search_states("aaaaa"))

  expect_null(res)
})

test_that("Search states accepts equivalent state identifiers", {
  n <- igo_search_states(c("USA", "United States of America", 2))

  expect_identical(n$ccode, c(2L, 2L, 2L))
  expect_identical(n$state, c("usa", "usa", "usa"))
  expect_identical(row.names(n), as.character(seq_len(nrow(n))))
})
