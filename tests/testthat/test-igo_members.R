test_that("missing or unknown IGO identifiers return informative conditions", {
  expect_snapshot(error = TRUE, s <- igo_members())
  expect_snapshot(res <- igo_members("Error"))
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
  expect_false("Nope" %in% as.character(res$category))
})

test_that("filters with no matching members return NULL", {
  expect_snapshot(res <- igo_members("EU", status = "Observer"))

  expect_null(res)
})

test_that("latest year is used when year is NULL", {
  single <- igo_members("SCA")

  expect_identical(unique(single$year), 1914)
  expect_identical(head(single$state, 3), c("uk", "netherlands", "france"))
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

test_that("Object classes", {
  expect_silent(sev <- igo_members("UN"))

  expect_s3_class(sev, "data.frame", exact = TRUE)

  expect_snapshot(vapply(sev, class, character(1)))
})

test_that("Cleanup", {
  expect_snapshot(var_err <- igo_members(c("EU", "an invented", "UN")))

  expect_identical(unique(var_err$ioname), c("EU", "UN"))
  expect_false("an invented" %in% var_err$ioname)
})
