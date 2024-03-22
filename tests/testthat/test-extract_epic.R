test_that("check_static detects an absence of a file in the extdata", {
  expect_equal(check_static("abcd/abcd"), FALSE)
})
