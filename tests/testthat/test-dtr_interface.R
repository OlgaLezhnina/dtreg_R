test_that("select_dtr creates an ePIC object for an ePIC template_doi", {
  templ <- select_dtr("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  expected <- c(".__enclos_env__", "template_info", "clone", "add_df_constants", "add_dtp_type",
                "add_dt_type",  "add_context", "get_template_info", "initialize")
  expect_equal(names(templ$new()), expected)
})

test_that("select_dtr creates an ORKG object for an ORKG template URL", {
  templ <- select_dtr("https://incubating.orkg.org/template/R937648")
  expected <- c(".__enclos_env__", "template_info", "clone", "add_df_constants", "add_dtp_type",
                "add_dt_type", "add_context", "get_template_info", "initialize")
  expect_equal(names(templ$new()), expected)
})
