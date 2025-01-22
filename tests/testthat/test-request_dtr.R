test_that("request_dtr gets info from an epic schema", {
  local_mocked_bindings(request_dtr = mocked_request_epic)
  info <- request_dtr("https://doi.org/21.T11969/3df63b7acb0522da685d?locatt=view:json")
  expect_equal(info$name, "String")
})

test_that("request_dtr gets info from an orkg template", {
  local_mocked_bindings(request_dtr = mocked_request_orkg)
  info <- request_dtr("https://orkg.org/api/templates/R758316")
  expect_equal(info$label, "dtreg_test_template2")
})
