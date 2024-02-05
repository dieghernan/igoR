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

test_that("recode dyadic", {
  expect_snapshot(
    igo_recode_dyadic(c(0, 1, -9, -1))
  )

  checkl <- igo_recode_dyadic(c(-3, NA, -9, -1))
  expect_snapshot(checkl)
  expect_length(levels(checkl), 5)
  expect_snapshot(igo_recode_dyadic(-1))
})
