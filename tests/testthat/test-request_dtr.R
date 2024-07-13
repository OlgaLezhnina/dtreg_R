test_that("request_dtr gets info from an epic schema", {
  info <- request_dtr("https://doi.org/21.T11969/6128ce5def6ffac006e0?locatt=view:json")
  expect_equal(info$name, "B2INST-Schema")
})

test_that("request_dtr gets info from an orkg template", {
  info <- request_dtr("https://incubating.orkg.org//api/templates/R855534")
  expect_equal(info$label, "inferential_test_output")
})
