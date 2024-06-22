test_that("extract_orkg gives the specified template", {
  result_extractor <- extract_orkg("https://incubating.orkg.org/template/R937648")
  string_representation <- capture.output(print(result_extractor))
  expected <- c("$measurement_scale",
                "$measurement_scale[[1]]",
                "            dt_name   dt_id dt_class",
                "1 measurement_scale R937648   C75002",
                "",
                "$measurement_scale[[2]]",
                "[1] dtp_name       dtp_id         dtp_card_min   dtp_card_max   dtp_value_type",
                "<0 rows> (or 0-length row.names)",
                "",
                 "")
  expect_equal(string_representation, expected)
})
