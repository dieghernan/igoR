test_that("IGO-year values are recoded to membership labels", {
  recoded <- igo_recode_igoyear(c(0, 1, 2, 3, -9, -1, NA, -3))

  expect_identical(
    as.character(recoded),
    c(
      "No Membership",
      "Full Membership",
      "Associate Membership",
      "Observer",
      "Missing data",
      "State Not System Member",
      NA_character_,
      NA_character_
    )
  )
  expect_identical(
    levels(recoded),
    c(
      "No Membership",
      "Full Membership",
      "Associate Membership",
      "Observer",
      "Missing data",
      "State Not System Member",
      NA_character_
    )
  )
})

test_that("state-year values are recoded to membership labels", {
  recoded <- igo_recode_stateyear(c(0, 1, 2, 3, -9, -1, NA, -3))

  expect_identical(
    as.character(recoded),
    c(
      "No Membership",
      "Full Membership",
      "Associate Membership",
      "Observer",
      "Missing data",
      "IGO Not In Existence",
      NA_character_,
      NA_character_
    )
  )
  expect_identical(
    levels(recoded),
    c(
      "No Membership",
      "Full Membership",
      "Associate Membership",
      "Observer",
      "Missing data",
      "IGO Not In Existence",
      NA_character_
    )
  )
})

test_that("dyadic values are recoded to joint membership labels", {
  recoded <- igo_recode_dyadic(c(0, 1, -9, -1, NA, -3))

  expect_identical(
    as.character(recoded),
    c(
      "No Joint Membership",
      "Joint Full Membership",
      "Missing data",
      "State Not System Member",
      NA_character_,
      NA_character_
    )
  )
  expect_identical(
    levels(recoded),
    c(
      "No Joint Membership",
      "Joint Full Membership",
      "Missing data",
      "State Not System Member",
      NA_character_
    )
  )
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
