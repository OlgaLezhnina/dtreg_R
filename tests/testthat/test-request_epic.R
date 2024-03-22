test_that("request_epic gets info from epic object", {
  info <- request_epic("21.T11969/6128ce5def6ffac006e0")
  expect_equal(info$name, "B2INST-Schema")
})
