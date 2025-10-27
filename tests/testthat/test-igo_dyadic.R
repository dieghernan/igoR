test_that("Testing messages ", {
  expect_snapshot(n <- igo_dyadic("USA", "CUBA", year = NULL))
  expect_null(n)

  expect_snapshot(n <- igo_dyadic("USA", "Cuba", 1900))
  expect_null(n)

  expect_snapshot(n <- igo_dyadic("USA", "USA"))
  expect_null(n)


  expect_snapshot(n <- igo_dyadic("USA", "Cuba", ioname = "Not an IGO"))
  expect_null(n)

  expect_snapshot(n <- igo_dyadic("Not a country", "banana", 1900))
  expect_null(n)

  expect_snapshot(n <- igo_dyadic("Cuba", "USa", 1900))
  expect_null(n)

  expect_snapshot(n <- igo_dyadic("France", "Spain", 2200))
  expect_null(n)
})

test_that("Test calls", {
  expect_silent(igo_dyadic("USA", "Cuba", 1900:1902))
  expect_silent(igo_dyadic("USA", c("Cuba", "Mexico"), 1900:1902))
  expect_silent(
    aa <- igo_dyadic(c("USA", "Cuba"), c("Cuba", "Mexico", "Cuba"), 1991:1992)
  )

  expect_snapshot(aa[, c("state1", "state2", "year")])


  expect_silent(igo_dyadic("USA", c("USA", "Canada"), 1921))

  expect_silent(aa <- igo_dyadic("USA", "Spain", 1990, "un"))
  expect_equal(ncol(aa), 11)
  expect_silent(bb <- igo_dyadic("USA", "Spain", 1990, c("un", "wto")))
  expect_equal(ncol(bb), 12)

  expect_identical(aa, bb[, colnames(aa)])

  expect_silent(igo_dyadic("USA", c("Spain", "France"), 1995, c("un", "WTo")))

  expect_snapshot(aa <- igo_dyadic("USA", "Spain", 1990, c("un", "random")))
  n1 <- igo_dyadic("USA", "Cuba", 1905)
  n2 <- igo_dyadic("Kosovo", "Cuba")
  n3 <- igo_dyadic("Kosovo", "Cuba", ioname = "UN")
  expect_true(ncol(n1) == ncol(n2))
  expect_false(ncol(n2) == ncol(n3))
})
