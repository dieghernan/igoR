test_that("Testing messages ", {
  expect_error(igo_state_membership())
  expect_snapshot(res <- igo_state_membership("Error"))
  expect_null(res)

  expect_snapshot(res <- igo_state_membership("modena", year = 1900))
  expect_null(res)

  expect_snapshot(res <- igo_state_membership("uk",
    status = c(
      "Nope", "IGO Not In Existence",
      "Full Membership", "Observer"
    )
  ))

  expect_true(
    all(unique(res$category) %in% c(
      "Nope", "IGO Not In Existence",
      "Full Membership", "Observer"
    ))
  )

  expect_snapshot(
    res <- igo_state_membership("spain", year = 1900, status = "Observer")
  )
  expect_null(res)
})

test_that("Expect years", {
  # Compare last
  expect_silent(single <- igo_state_membership("wgermany"))

  comp <- igoR::state_year_format3
  comp <- comp[comp$state == "wgermany", ]

  expect_identical(max(comp$year), unique(single$year))


  # With an array of years
  expect_silent(single <- igo_state_membership("wgermany", year = 1700:2020))


  comp <- igoR::state_year_format3
  comp <- comp[comp$state == "wgermany", ]
  fullr <- range(comp$year)

  expect_equal(seq(fullr[1], fullr[2]), unique(single$year))
})

test_that("Extract several cntries", {
  # Compare last
  expect_snapshot(sev <- igo_state_membership(c(
    "UnitEd KingDom",
    "SPAIN",
    "aga haha",
    "1298",
    "WGeRMANy"
  )))

  expect_identical(c("uk", "spain", "wgermany"), unique(sev$state))
})

test_that("Extract several status", {
  lvs <- levels(igo_recode_igoyear(1))
  lvs <- lvs[!is.na(lvs)]
  expect_silent(
    sev <- igo_state_membership("kosovo", status = lvs, year = 1900:2014)
  )

  expect_identical(
    as.character(unique(sort(sev$category))),
    lvs[c(1:3, 5)]
  )
})

test_that("Object classes", {
  expect_silent(sev <- igo_state_membership("spain"))

  expect_s3_class(sev, "data.frame", exact = TRUE)

  expect_snapshot(
    vapply(sev, class, character(1))
  )
})

test_that("Cleanup", {
  expect_snapshot(var_err <- igo_state_membership(c("uk", "invented", "usa")))

  expect_identical(unique(var_err$state), c("uk", "usa"))
})
