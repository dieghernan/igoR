test_that("recode igo year", {
  expect_snapshot(igo_recode_igoyear(c(0, 1, 2, 3)))

  checkl <- igo_recode_igoyear(c(-3, NA, -9, -1))
  expect_snapshot(checkl)
  expect_length(levels(checkl), 7)
  expect_snapshot(igo_recode_igoyear(-1))
})

test_that("recode state year", {
  expect_snapshot(igo_recode_stateyear(c(0, 1, 2, 3)))

  checkl <- igo_recode_stateyear(c(-3, NA, -9, -1))
  expect_snapshot(checkl)
  expect_length(levels(checkl), 7)
  expect_snapshot(igo_recode_stateyear(-1))
})

test_that("recode dyadic", {
  expect_snapshot(igo_recode_dyadic(c(0, 1, -9, -1)))

  checkl <- igo_recode_dyadic(c(-3, NA, -9, -1))
  expect_snapshot(checkl)
  expect_length(levels(checkl), 5)
  expect_snapshot(igo_recode_dyadic(-1))
})

test_that("internal dyadic recoding preserves membership precedence", {
  mat1 <- matrix(
    c(1, -9, -1, 0, 2, NA, 1, 3, -1, -9),
    ncol = 2
  )
  mat2 <- matrix(
    c(1, 1, 1, 1, 3, 1, 0, 1, -1, -1),
    ncol = 2
  )

  recoded <- recode_joint_matrix(mat1, mat2)

  expect_equal(
    recoded,
    matrix(c(1, -9, -1, 0, 0, -9, 0, 0, -1, -9), ncol = 2)
  )
})
