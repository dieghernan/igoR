test_that("internal result binding drops empty results and resets rows", {
  results <- list(
    data.frame(id = 1, value = "a"),
    NULL,
    data.frame(id = 2, value = "b")
  )

  bound <- igo_bind_results(results, "No results.")

  expect_equal(bound$id, 1:2)
  expect_identical(row.names(bound), as.character(1:2))
})

test_that("internal result binding warns when every result is empty", {
  expect_warning(
    bound <- igo_bind_results(list(NULL, NULL), "No results."),
    "No results."
  )

  expect_null(bound)
})

test_that("internal status validation reports invalid values only", {
  valid_status <- c("No Membership", "Full Membership")

  expect_warning(
    igo_warn_invalid_status(
      c("Full Membership", "Invalid"),
      valid_status
    ),
    "Unknown values for"
  )

  expect_silent(igo_warn_invalid_status("Full Membership", valid_status))
})
