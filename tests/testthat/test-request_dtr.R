test_that("request_dtr gets info from an epic schema", {
  local_mocked_bindings(request_dtr = mocked_request_epic)
  info <- request_dtr("https://doi.org/21.T11969/fb2e379f820c6f8f9e82?locatt=view:json")
  expect_equal(info$name, "integer_in_string")
})

test_that("request_dtr gets info from an orkg template", {
  local_mocked_bindings(request_dtr = mocked_request_orkg)
  info <- request_dtr("https://orkg.org/api/templates/R758316")
  expect_equal(info$label, "dtreg_test_template2")
})
