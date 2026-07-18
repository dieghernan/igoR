test_that("missing or unknown states return informative conditions", {
  expect_snapshot(error = TRUE, s <- igo_state_membership())
  expect_snapshot(res <- igo_state_membership("Error"))
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
  expect_false("Nope" %in% as.character(res$category))
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
  expect_identical(head(single$ioname, 3), c("ACSSRB", "AVRDC", "AfDB"))
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

test_that("Object classes", {
  expect_silent(sev <- igo_state_membership("spain"))

  expect_s3_class(sev, "data.frame", exact = TRUE)

  expect_snapshot(vapply(sev, class, character(1)))
})

test_that("Cleanup", {
  expect_snapshot(var_err <- igo_state_membership(c("uk", "invented", "usa")))

  expect_identical(unique(var_err$state), c("uk", "usa"))
  expect_false("invented" %in% var_err$state)
})
