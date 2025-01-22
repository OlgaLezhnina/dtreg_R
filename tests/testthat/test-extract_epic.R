test_that("extract_epic gives the specified schema", {
  local_mocked_bindings(request_dtr = mocked_request_epic)
  result_extract_epic <- extract_epic("https://doi.org/21.T11969/fb2e379f820c6f8f9e82")
  string_representation <- capture.output(print(result_extract_epic))
  expected <- c("$integer_in_string",
                "$integer_in_string[[1]]",
                "            dt_name                dt_id dt_class",
                "1 integer_in_string fb2e379f820c6f8f9e82   String",
                "",
                "$integer_in_string[[2]]",
                "  dtp_name                       dtp_id dtp_card_min dtp_card_max",
                "1  pattern fb2e379f820c6f8f9e82#pattern           NA           NA",
                "  dtp_value_type",
                "1       ^[0-9]+$",
                "",
                "")
  expect_equal(string_representation, expected)
})

test_that("extract_epic extracts properties correctly", {
  local_mocked_bindings(request_dtr = mocked_request_epic)
  dt <- extract_epic("https://doi.org/21.T11969/31483624b5c80014b6c7")
  prop_names <- dt$matrix_size[[2]]$dtp_name
  expected <- c("number_of_rows", "number_of_columns")
  expect_equal(prop_names, expected)
})
