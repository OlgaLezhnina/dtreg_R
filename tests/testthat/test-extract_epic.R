test_that("extract_epic gives the specified schema", {
  result_extract_epic <- extract_epic("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  string_representation <- capture.output(print(result_extract_epic))
  expected <- c("$pidinst_schemaobject", "$pidinst_schemaobject[[1]]",
                "               dt_name                dt_id dt_class",
                "1 pidinst_schemaobject 1ea0e148d9bbe08335cd   Object",
                "", "$pidinst_schemaobject[[2]]",
                "[1] dtp_name       dtp_id         dtp_card_min   dtp_card_max   dtp_value_type",
                "<0 rows> (or 0-length row.names)",
                "", "")
  expect_equal(string_representation, expected)
})

test_that("extract_epic extracts properties correctly", {
  dt <- extract_epic("https://doi.org/21.T11969/31483624b5c80014b6c7")
  prop_names <- dt$matrix_size[[2]]$dtp_name
  expected <- c("number_of_rows", "number_of_columns")
  expect_equal(prop_names, expected)
})
