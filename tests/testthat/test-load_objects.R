test_that("load_objects loads a specific ePIC template", {
  template <- load_objects("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  expect_equal(names(template), "pidinst_schemaobject")
})
