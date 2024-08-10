test_that("load_datatype loads a specific ePIC schema", {
  schema <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  expect_equal(names(schema), "pidinst_schemaobject")
})

test_that("load_datatype loads ePIC schema properties correctly", {
  dt <- load_datatype("https://doi.org/21.T11969/74bc7748b8cd520908bc")
  prop_names <- dt$inferential_test_output()$prop_names
  expected <- c("label", "has_description", "comment", "has_format")
  expect_equal(prop_names, expected)
})

test_that("load_datatype loads ORKG template properties correctly", {
  dt <- load_datatype("https://incubating.orkg.org/template/R855534")
  prop_names <- dt$inferential_test_output()$prop_names
  expected <- c("has_format", "has_description", "comment", "label")
  expect_equal(prop_names, expected)
})
