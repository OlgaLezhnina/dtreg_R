test_that("load_datatype loads a specific ePIC schema", {
  template <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  expect_equal(names(template), "pidinst_schemaobject")
})
