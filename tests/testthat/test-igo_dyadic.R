test_that("non-numeric years return NULL with a warning", {
  expect_snapshot(n <- igo_dyadic("USA", "CUBA", year = NULL))

  expect_null(n)
})

test_that("unsupported numeric years return NULL with a warning", {
  expect_snapshot(
    res <- igo_dyadic("USA", "Spain", c(NA, NaN, Inf, 1990.5), "UN")
  )

  expect_null(res)
})

test_that("empty year vectors return NULL with a warning", {
  expect_snapshot(res <- igo_dyadic("USA", "Spain", numeric(), "UN"))

  expect_null(res)
})

test_that("state pairs outside the state system return NULL", {
  expect_snapshot(n <- igo_dyadic("USA", "Cuba", 1900))

  expect_null(n)
})

test_that("self-pairs return NULL", {
  expect_snapshot(n <- igo_dyadic("USA", "USA"))

  expect_null(n)
})

test_that("unknown IGO names return NULL", {
  expect_snapshot(n <- igo_dyadic("USA", "Cuba", ioname = "Not an IGO"))

  expect_null(n)
})

test_that("unknown states return NULL", {
  expect_snapshot(n <- igo_dyadic("Not a country", "banana", 1900))

  expect_null(n)
})

test_that("partially unavailable state pairs return NULL", {
  expect_snapshot(n <- igo_dyadic("Cuba", "USa", 1900))

  expect_null(n)
})

test_that("years outside the IGO data return NULL", {
  expect_snapshot(n <- igo_dyadic("France", "Spain", 2200))

  expect_null(n)
})

test_that("dyadic search keeps only years where both states are comparable", {
  res <- igo_dyadic("USA", c("Cuba", "Mexico"), 1900:1902)

  expect_identical(
    res[, c("state1", "state2", "year")],
    data.frame(
      state1 = c("usa", "usa", "usa", "usa"),
      state2 = c("cuba", "mexico", "mexico", "mexico"),
      year = c(1902, 1900, 1901, 1902),
      stringsAsFactors = FALSE
    )
  )
})

test_that("dyadic search expands vectorized country pairs", {
  res <- igo_dyadic(c("USA", "Cuba"), c("Cuba", "Mexico", "Cuba"), 1991:1992)

  expect_identical(
    res[, c("state1", "state2", "year")],
    data.frame(
      state1 = c("usa", "usa", "usa", "usa", "cuba", "cuba"),
      state2 = c("cuba", "cuba", "mexico", "mexico", "mexico", "mexico"),
      year = c(1991, 1992, 1991, 1992, 1991, 1992),
      stringsAsFactors = FALSE
    )
  )
})

test_that("dyadic search drops self-pairs from vectorized inputs", {
  res <- igo_dyadic("USA", c("USA", "Canada"), 1921)

  expect_identical(unique(res$state1), "usa")
  expect_identical(unique(res$state2), "canada")
  expect_disjoint(res$state1, res$state2)
})

test_that("selected IGOs determine dyadic membership columns", {
  un <- igo_dyadic("USA", "Spain", 1990, "un")
  un_wto <- igo_dyadic("USA", "Spain", 1990, c("un", "wto"))

  expect_identical(names(un)[11], "un")
  expect_identical(names(un_wto)[11:12], c("un", "wto"))
  expect_identical(un, un_wto[, names(un)])
})

test_that("selected IGOs are case-insensitive", {
  res <- igo_dyadic("USA", c("Spain", "France"), 1995, c("un", "WTo"))

  expect_identical(names(res)[11:12], c("un", "wto"))
  expect_identical(unique(res$state1), "usa")
  expect_identical(unique(res$state2), c("spain", "france"))
})

test_that("unknown selected IGOs are ignored when at least one IGO is valid", {
  res <- igo_dyadic("USA", "Spain", 1990, c("un", "random"))

  expect_identical(names(res)[11], "un")
  expect_disjoint("random", names(res))
})

test_that("dyadic output keeps metadata before selected IGOs", {
  res <- igo_dyadic("USA", "Spain", 1990, c("UN", "EU"))

  expect_identical(
    names(res)[1:10],
    c(
      "dyadid",
      "ccode1",
      "stateabb1",
      "statenme1",
      "state1",
      "ccode2",
      "stateabb2",
      "statenme2",
      "state2",
      "year"
    )
  )
  expect_identical(names(res)[11:12], c("un", "eu"))
  expect_identical(row.names(res), as.character(seq_len(nrow(res))))
})

test_that("dyadic identifiers use both state codes", {
  res <- igo_dyadic("USA", "Spain", 1990, "UN")

  expect_identical(
    res[, c("dyadid", "ccode1", "ccode2")],
    data.frame(dyadid = 2230, ccode1 = 2L, ccode2 = 230L)
  )
})

test_that("dyadic output contains known joint membership values", {
  res <- igo_dyadic(
    "USA",
    "Spain",
    1990,
    c("UN", "EU", "AAAID", "ARCAL")
  )

  expect_identical(
    res[, c("year", "un", "eu", "aaaid", "arcal")],
    data.frame(year = 1990, un = 1, eu = -1, aaaid = 0, arcal = -9)
  )
})
