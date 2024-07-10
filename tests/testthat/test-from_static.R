test_that("from_static detects an absence of a file in the extdata", {
  expect_equal(from_static("https://incubating.orkg.org/template/R836000"), NULL)
})
