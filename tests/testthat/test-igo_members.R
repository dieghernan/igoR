test_that("missing IGO identifiers produce an informative error", {
  expect_snapshot(error = TRUE, igo_members())
})

test_that("unknown IGO identifiers return NULL with a warning", {
  expect_snapshot(res <- igo_members("Error"))

  expect_null(res)
})

test_that("empty IGO identifier vectors return NULL with a warning", {
  expect_snapshot(res <- igo_members(character()))

  expect_null(res)
})

test_that("missing IGO identifier values return NULL with a warning", {
  expect_snapshot(res <- igo_members(NA))

  expect_null(res)
})

test_that("years outside an IGO lifetime return NULL", {
  expect_snapshot(res <- igo_members("EU", year = 1900))

  expect_null(res)
})

test_that("invalid statuses warn and valid statuses are still used", {
  expect_snapshot(
    res <- igo_members(
      "IOLM",
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
  expect_snapshot(res <- igo_members("EU", year = c(NA, Inf, 1990.5)))

  expect_null(res)
})

test_that("NULL status filters return NULL with a warning", {
  expect_snapshot(res <- igo_members("EU", status = NULL))

  expect_null(res)
})

test_that("filters with no matching members return NULL", {
  expect_snapshot(res <- igo_members("EU", status = "Observer"))

  expect_null(res)
})

test_that("latest year is used when year is NULL", {
  single <- igo_members("SCA")

  expect_identical(unique(single$year), 1914)
  expect_contains(single$state, c("uk", "netherlands", "france"))
})

test_that("year ranges are restricted to the IGO lifetime", {
  single <- igo_members("SCA", year = 1700:2020)

  expect_equal(unique(single$year), 1888:1914)
})

test_that("several IGOs can be extracted in one call", {
  sev <- igo_members(c("wpact", "EU"))

  expect_identical(c("WPact", "EU"), unique(sev$ioname))
  expect_identical(unique(sev$year), c(1991, 2014))
})

test_that("several statuses can be extracted in one call", {
  lvs <- levels(igo_recode_stateyear(1))
  lvs <- lvs[!is.na(lvs)]
  sev <- igo_members("UN", status = lvs, year = 1900:2014)

  expect_identical(as.character(unique(sev$category)), lvs[1:2])
  expect_identical(range(sev$year), c(1945, 2014))
})

test_that("membership results have stable column types", {
  expect_silent(sev <- igo_members("UN"))

  expect_s3_class(sev, "data.frame", exact = TRUE)
  expect_identical(
    vapply(sev, class, character(1)),
    c(
      ioname = "character",
      ccode = "numeric",
      state = "character",
      statenme = "character",
      year = "numeric",
      value = "numeric",
      category = "factor",
      orgname = "character"
    )
  )
})

test_that("unknown identifiers are omitted from vectorized results", {
  expect_snapshot(var_err <- igo_members(c("EU", "an invented", "UN")))

  expect_identical(unique(var_err$ioname), c("EU", "UN"))
  expect_disjoint("an invented", var_err$ioname)
})
