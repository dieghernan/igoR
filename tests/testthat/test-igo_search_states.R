test_that("Search states", {
  expect_silent(n <- igo_search_states("Spain"))
  expect_equal(nrow(n), 1)

  expect_snapshot(n <- igo_search_states(c("Spain", "aaa", "france")))
  expect_equal(nrow(n), 2)

  expect_silent(n <- igo_search_states(c(20, 150)))
  expect_equal(nrow(n), 2)

  expect_silent(n <- igo_search_states(c("congo")))
  expect_equal(nrow(n), 1)

  expect_silent(
    n <- igo_search_states(c("FRN", "United Kingdom", 240, "italy"))
  )
  expect_equal(nrow(n), 4)

  expect_snapshot(
    n <- igo_search_states("aaaaa")
  )
  expect_null(n)
})
