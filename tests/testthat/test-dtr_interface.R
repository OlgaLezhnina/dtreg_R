test_that("select_dtr selects class ePIC object for an ePIC schema URL", {
  schema <- select_dtr("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  expected <- c(".__enclos_env__", "schema_info", "clone", "add_df_constants", "add_dtp_type",
                "add_dt_type",  "add_context", "get_schema_info", "initialize")
  expect_equal(names(schema$new()), expected)
})

test_that("select_dtr selects class ORKG for an ORKG template URL", {
  schema <- select_dtr("https://incubating.orkg.org/template/R937648")
  expected <- c(".__enclos_env__", "schema_info", "clone", "add_df_constants", "add_dtp_type",
                "add_dt_type", "add_context", "get_schema_info", "initialize")
  expect_equal(names(schema$new()), expected)
})

test_that("select_dtr gives error when the URL is neither ePIC nor ORKG", {
  wrong_URL <- "https://stackoverflow.com/questions"
  expect_error(select_dtr(wrong_URL), "Please check whether the schema belongs to the ePIC or the ORKG dtr", fixed = TRUE)
})
