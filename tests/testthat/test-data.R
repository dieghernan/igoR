test_that("data sets expose stable schemas and column types", {
  expect_contains(
    names(igo_year_format3),
    c("ioname", "orgname", "year", "sdate", "deaddate", "ionum")
  )
  expect_contains(
    names(state_year_format3),
    c("ccode", "year", "state", "un", "eu")
  )
  expect_named(
    states2024,
    c(
      "ccode",
      "stateabb",
      "statenme",
      "styear",
      "stmonth",
      "stday",
      "endyear",
      "endmonth",
      "endday",
      "version",
      "state"
    )
  )

  state_columns <- names(igo_year_format3)[4:220]
  igo_columns <- names(state_year_format3)[4:ncol(state_year_format3)]

  expect_all_equal(
    vapply(igo_year_format3[state_columns], typeof, character(1)),
    "double"
  )
  expect_all_equal(
    vapply(state_year_format3[igo_columns], typeof, character(1)),
    "double"
  )
  expect_identical(
    vapply(states2024, typeof, character(1)),
    c(
      ccode = "integer",
      stateabb = "character",
      statenme = "character",
      styear = "integer",
      stmonth = "integer",
      stday = "integer",
      endyear = "integer",
      endmonth = "integer",
      endday = "integer",
      version = "integer",
      state = "character"
    )
  )
})

test_that("data sets have unique compound keys and expected year ranges", {
  expect_identical(
    anyDuplicated(igo_year_format3[c("ioname", "year")]),
    0L
  )
  expect_identical(
    anyDuplicated(state_year_format3[c("state", "year")]),
    0L
  )
  expect_identical(anyDuplicated(states2024[c("ccode", "styear")]), 0L)

  expect_identical(range(igo_year_format3$year), c(1816, 2014))
  expect_identical(range(state_year_format3$year), c(1816, 2014))
  expect_identical(range(states2024$styear), c(1816L, 2011L))
  expect_identical(range(states2024$endyear), c(1860L, 2024L))
  expect_identical(unique(states2024$version), 2024L)
})

test_that("membership columns contain only documented status values", {
  state_columns <- names(igo_year_format3)[4:220]
  igo_columns <- names(state_year_format3)[4:ncol(state_year_format3)]

  igo_values <- unique(unlist(
    igo_year_format3[state_columns],
    use.names = FALSE
  ))
  state_values <- unique(
    unlist(state_year_format3[igo_columns], use.names = FALSE)
  )

  expect_setequal(igo_values[!is.na(igo_values)], c(-9, 0, 1, 2, 3))
  expect_in(NA_real_, igo_values)
  expect_setequal(state_values, c(-9, -1, 0, 1, 2, 3))
})

test_that("identifiers are consistent across package data sets", {
  state_columns <- names(igo_year_format3)[4:220]
  igo_columns <- names(state_year_format3)[4:ncol(state_year_format3)]

  expect_setequal(state_columns, unique(states2024$state))
  expect_setequal(igo_columns, tolower(unique(igo_year_format3$ioname)))
  expect_setequal(unique(state_year_format3$ccode), unique(states2024$ccode))
})
