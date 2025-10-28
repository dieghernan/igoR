test_that("Testing messages ", {
  expect_error(igo_members())
  expect_snapshot(res <- igo_members("Error"))
  expect_null(res)

  expect_snapshot(res <- igo_members("EU", year = 1900))
  expect_null(res)

  expect_snapshot(
    res <- igo_members(
      "IOLM",
      status = c(
        "Nope",
        "IGO Not In Existence",
        "Full Membership",
        "Observer"
      )
    )
  )

  expect_true(
    all(
      unique(res$category) %in%
        c(
          "Nope",
          "IGO Not In Existence",
          "Full Membership",
          "Observer"
        )
    )
  )

  expect_snapshot(res <- igo_members("EU", status = "Observer"))
  expect_null(res)
})

test_that("Expect years", {
  # Compare last
  expect_silent(single <- igo_members("SCA"))

  comp <- igoR::igo_year_format3
  comp <- comp[comp$ioname == "SCA", ]

  expect_identical(max(comp$year), unique(single$year))

  # With an array of years
  expect_silent(single <- igo_members("SCA", year = 1700:2020))

  comp <- igoR::igo_year_format3
  comp <- comp[comp$ioname == "SCA", ]
  fullr <- range(comp$year)

  expect_equal(seq(fullr[1], fullr[2]), unique(single$year))
})

test_that("Extract several orgs", {
  # Compare last
  expect_silent(sev <- igo_members(c("wpact", "EU")))

  expect_identical(c("WPact", "EU"), unique(sev$ioname))
})

test_that("Extract several status", {
  lvs <- levels(igo_recode_stateyear(1))
  lvs <- lvs[!is.na(lvs)]
  expect_silent(sev <- igo_members("UN", status = lvs, year = 1900:2014))

  expect_identical(
    as.character(unique(sev$category)),
    lvs[1:2]
  )
})

test_that("Object classes", {
  expect_silent(sev <- igo_members("UN"))

  expect_s3_class(sev, "data.frame", exact = TRUE)

  expect_snapshot(
    vapply(sev, class, character(1))
  )
})

test_that("Cleanup", {
  expect_snapshot(var_err <- igo_members(c("EU", "an invented", "UN")))

  expect_identical(unique(var_err$ioname), c("EU", "UN"))
})
