test_that("request_dtr gets info from epic object", {
  info <- request_dtr("https://doi.org/21.T11969/6128ce5def6ffac006e0?locatt=view:json")
  expect_equal(info$name, "B2INST-Schema")
})
