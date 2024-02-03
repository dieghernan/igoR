test_that("Testing messages ", {
  expect_error(igo_members())
  expect_snapshot(res <- igo_members("Error"))
  expect_null(res)

  expect_snapshot(res <- igo_members("EU", year = 1900))
  expect_null(res)

  expect_snapshot(res <- igo_members("IOLM",
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

  expect_snapshot(res <- igo_members("EU", status = "Observer"))
  expect_null(res)
})

test_that("Results", {
  expect_silent(igo_members("EU"))
  expect_silent(igo_members("EU", year = 2000))

  n1 <- nrow(igo_members("EU", year = 2000))
  n2 <- nrow(igo_members("EU", year = 1993))
  expect_false(n1 == n2)
  expect_silent(igo_members(c("NAFTA", "EU"), year = 1993))
  expect_silent(res <- igo_members(c("nafta", "un", "eu"), year = 1993:2000))

  expect_identical(unique(res$ioname), c("NAFTA", "UN", "EU"))
  expect_identical(as.integer(unique(res$year)), 1993:2000)
})
