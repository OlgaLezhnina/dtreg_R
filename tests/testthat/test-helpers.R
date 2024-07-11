test_that("format_string makes text lowcase, spaces and dashes to underscores", {
  expect_equal(format_string("a-B c"), "a_b_c")
})

test_that("get_prefix returns the epic prefix", {
  expect_equal(get_prefix("https://doi.org/21.T11969/74bc7748b8cd520908bc"), "https://doi.org/21.T11969/")
})

test_that("get_prefix returns the orkg prefix", {
  expect_equal(get_prefix("https://incubating.orkg.org/template/R855534"), "https://incubating.orkg.org/")
})

test_that("specify_cardinality outputs the specific list for min_max", {
  expect_equal(specify_cardinality("0 - 1"), list(min = 0, max = 1))
})

test_that("generate_uid returns a function", {
  expect_equal(class(generate_uid()), "function")
})

test_that("show_fileds outputs no fields", {
  pd <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  no_fields <- show_fields(pd$pidinst_schemaobject())
  expect_equal(no_fields, NULL)
})
