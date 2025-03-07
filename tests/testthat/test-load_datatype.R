test_that("load_datatype loads a specific ePIC schema", {
  schema <- load_datatype("https://doi.org/21.T11969/fb2e379f820c6f8f9e82")
  expect_equal(names(schema), "integer_in_string")
})

test_that("load_datatype loads ePIC schema properties correctly", {
  dt <- load_datatype("https://doi.org/21.T11969/31483624b5c80014b6c7")
  prop_names <- dt$matrix_size()$prop_names
  expected <- c("number_of_rows", "number_of_columns")
  expect_equal(prop_names, expected)
})

test_that("load_datatype loads ORKG template properties correctly", {
  local_mocked_bindings(request_dtr = mocked_request_orkg)
  dt <- load_datatype("https://orkg.org/template/R758316")
  prop_names <- dt$dtreg_test_template2()$prop_names
  expected <- c("property3", "label")
  expect_equal(prop_names, expected)
})
