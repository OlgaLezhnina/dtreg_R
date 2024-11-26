test_that("from_static detects an absence of a file in the extdata", {
  expect_equal(from_static("https://doi.org/21.T11969/dddddddddddddddddddd"), NULL)
})

test_that("from_static gives info for a schema from the extdata", {
  info <- from_static("https://doi.org/21.T11969/3df63b7acb0522da685d")
  expect_equal(info$string[[1]]$dt_id, "3df63b7acb0522da685d")
})
