test_that("recode igo year", {
  expect_snapshot(
    igo_recode_igoyear(c(0, 1, 2, 3))
  )

  checkl <- igo_recode_igoyear(c(-3, NA, -9, -1))
  expect_snapshot(checkl)
  expect_length(levels(checkl), 7)
  expect_snapshot(igo_recode_igoyear(-1))
})

test_that("recode state year", {
  expect_snapshot(
    igo_recode_stateyear(c(0, 1, 2, 3))
  )

  checkl <- igo_recode_stateyear(c(-3, NA, -9, -1))
  expect_snapshot(checkl)
  expect_length(levels(checkl), 7)
  expect_snapshot(igo_recode_stateyear(-1))
})
