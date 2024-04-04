test_that("select_dtr creates an ePIC object for an ePIC template_doi", {
  templ <- select_dtr("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  expected <- c(".__enclos_env__", "template_info",        "clone",           "get_template_info",    "initialize")
  expect_equal(names(templ), expected)
})
