test_that("check_static detects an absence of a file in the extdata", {
  expect_equal(check_static("https://incubating.orkg.org/template/R836000"), "none")
})
