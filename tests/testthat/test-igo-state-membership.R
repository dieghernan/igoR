test_that("missing states produce an informative error", {
  expect_snapshot(error = TRUE, igo_state_membership())
})

test_that("unknown states return NULL with a warning", {
  expect_snapshot(res <- igo_state_membership("Error"))

  expect_null(res)
})

test_that("empty state vectors return NULL with a warning", {
  expect_snapshot(res <- igo_state_membership(character()))

  expect_null(res)
})

test_that("missing state values return NULL with a warning", {
  expect_snapshot(res <- igo_state_membership(NA))

  expect_null(res)
})

test_that("years outside a state lifetime return NULL", {
  expect_snapshot(res <- igo_state_membership("modena", year = 1900))

  expect_null(res)
})

test_that("invalid statuses warn and valid statuses are still used", {
  expect_snapshot(
    res <- igo_state_membership(
      "uk",
      status = c("Nope", "Full Membership", "Observer")
    )
  )

  expect_equal(
    as.character(unique(res$category)),
    c("Full Membership", "Observer")
  )
  expect_disjoint("Nope", as.character(res$category))
})

test_that("unsupported years return NULL with a warning", {
  expect_snapshot(
    res <- igo_state_membership("spain", year = c(NA, Inf, 1990.5))
  )

  expect_null(res)
})

test_that("NULL status filters return NULL with a warning", {
  expect_snapshot(res <- igo_state_membership("spain", status = NULL))

  expect_null(res)
})

test_that("filters with no matching state memberships return NULL", {
  expect_snapshot(
    res <- igo_state_membership("spain", year = 1900, status = "Observer")
  )

  expect_null(res)
})

test_that("latest year is used when year is NULL", {
  single <- igo_state_membership("wgermany")

  expect_identical(unique(single$year), 1989)
  expect_identical(unique(single$state), "wgermany")
  expect_contains(single$ioname, c("ACSSRB", "AVRDC", "AfDB"))
})

test_that("year ranges are restricted to the state lifetime", {
  single <- igo_state_membership("wgermany", year = 1700:2020)

  expect_equal(unique(single$year), 1955:1989)
})

test_that("several countries can be extracted in one call", {
  expect_snapshot(
    sev <- igo_state_membership(c(
      "UnitEd KingDom",
      "SPAIN",
      "aga haha",
      "1298",
      "WGeRMANy"
    ))
  )

  expect_identical(c("uk", "spain", "wgermany"), unique(sev$state))
  expect_identical(unique(sev$year), c(2014, 1989))
})

test_that("several statuses can be extracted in one call", {
  lvs <- levels(igo_recode_igoyear(1))
  lvs <- lvs[!is.na(lvs)]
  sev <- igo_state_membership("kosovo", status = lvs, year = 1900:2014)

  expect_identical(as.character(unique(sort(sev$category))), lvs[c(1:3, 5)])
  expect_identical(range(sev$year), c(2008, 2014))
})

test_that("state membership results have stable column types", {
  expect_silent(sev <- igo_state_membership("spain"))

  expect_s3_class(sev, "data.frame", exact = TRUE)
  expect_identical(
    vapply(sev, class, character(1)),
    c(
      ccode = "numeric",
      stateabb = "character",
      statenme = "character",
      state = "character",
      year = "numeric",
      ioname = "character",
      value = "numeric",
      category = "factor",
      orgname = "character",
      longorgname = "character",
      political = "numeric",
      social = "numeric",
      economic = "numeric"
    )
  )
})

test_that("unknown states are omitted from vectorized results", {
  expect_snapshot(var_err <- igo_state_membership(c("uk", "invented", "usa")))

  expect_identical(unique(var_err$state), c("uk", "usa"))
  expect_disjoint("invented", var_err$state)
})
