test_that("Testing search", {
  expect_silent(igo_search())
  expect_true(nrow(igo_search("EU")) > 1)
  expect_true(nrow(igo_search("EU", exact = TRUE)) == 1)
  expect_silent(igo_search("abepseac"))
  expect_snapshot(igo_search("Expect Error"))
})
