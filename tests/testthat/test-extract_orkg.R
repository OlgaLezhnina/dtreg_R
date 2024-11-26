test_that("extract_orkg gives the specified template", {
  result_extractor <- extract_orkg("https://orkg.org/template/R758316")
  string_representation <- capture.output(print(result_extractor))
  expected <- c("$dtreg_test_template2",
                "$dtreg_test_template2[[1]]",
                "               dt_name   dt_id dt_class",
                "1 dtreg_test_template2 R758316  C102007",
                "",
                "$dtreg_test_template2[[2]]",
                "   dtp_name  dtp_id dtp_card_min dtp_card_max dtp_value_type",
                "1 property3 P160024            0           NA        Integer",
                "2     label   label            0            1         string",
                "",
                "")
  expect_equal(string_representation, expected)
})

test_that("extract_orkg extracts properties correctly", {
  dt <- extract_orkg("https://orkg.org/template/R758316")
  prop_names <- dt$dtreg_test_template2[[2]]$dtp_name
  expected <- c("property3", "label")
  expect_equal(prop_names, expected)
})

test_that("extract_orkg extracts nested templates", {
  dt <- extract_orkg("https://orkg.org/template/R758315")
  expected <- c("dtreg_test_template2", "dtreg_test_template1")
  expect_equal(names(dt), expected)
})
