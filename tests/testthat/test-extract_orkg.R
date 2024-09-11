test_that("extract_orkg gives the specified template", {
  result_extractor <- extract_orkg("https://incubating.orkg.org/template/R937648")
  string_representation <- capture.output(print(result_extractor))
  expected <- c("$measurement_scale",
                "$measurement_scale[[1]]",
                "            dt_name   dt_id dt_class",
                "1 measurement_scale R937648   C75002",
                "",
                "$measurement_scale[[2]]",
                "  dtp_name dtp_id dtp_card_min dtp_card_max dtp_value_type",
                "1    label  label            0            1         string",
                "",
                "")
  expect_equal(string_representation, expected)
})

test_that("extract_orkg extracts properties correctly", {
  dt <- extract_orkg("https://incubating.orkg.org/template/R855534")
  prop_names <- dt$inferential_test_output[[2]]$dtp_name
  expected <- c("has_format", "has_description", "comment", "label")
  expect_equal(prop_names, expected)
})

test_that("extract_orkg extracts nested templates", {
  dt <- dtreg:::extract_orkg("https://incubating.orkg.org/template/R903086")
  expected <- c("statistical_variable", "sample_size", "data_input")
  expect_equal(names(dt), expected)
})
