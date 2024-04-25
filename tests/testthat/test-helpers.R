test_that("format_string makes text lowcase, spaces and dashes to underscores", {
  expect_equal(format_string("a-B c"), "a_b_c")
})

test_that("show_fileds outputs no fields", {
  pd <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  no_fields <- show_fields(pd$pidinst_schemaobject())
  expect_equal(no_fields, "no fields")
})
