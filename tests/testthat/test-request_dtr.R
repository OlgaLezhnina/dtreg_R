test_that("request_dtr gets info from an epic schema", {
  info <- request_dtr("https://doi.org/21.T11969/6128ce5def6ffac006e0?locatt=view:json")
  expect_equal(info$name, "B2INST-Schema")
})

test_that("request_dtr gets info from an orkg template", {
  info <- request_dtr("https://orkg.org//api/templates/R758316")
  expect_equal(info$label, "dtreg_test_template2")
})
