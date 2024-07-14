test_that("select_dtr selects class ePIC object for an ePIC schema URL", {
  schema <- select_dtr("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  expect_equal(schema$classname, "Epic")
})

test_that("select_dtr selects class ORKG for an ORKG template URL", {
  schema <- select_dtr("https://incubating.orkg.org/template/R937648")
  expect_equal(schema$classname, "Orkg")
})

test_that("select_dtr gives error when the URL is neither ePIC nor ORKG", {
  wrong_url <- "https://stackoverflow.com/questions"
  expect_error(select_dtr(wrong_url), "Please check whether the schema belongs to the ePIC or the ORKG dtr", fixed = TRUE)
})
