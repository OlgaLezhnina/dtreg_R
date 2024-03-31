test_that("extract_epic gives the specified template", {
  result_extract_epic <- extract_epic("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  string_representation <- capture.output(print(result_extract_epic))
  expected <- c("$`PIDINST-SchemaObject`",                                           "$`PIDINST-SchemaObject`[[1]]",
                "$`PIDINST-SchemaObject`[[1]][[1]]",                                 "                  name                     identifier schema_type",
                "1 PIDINST-SchemaObject 21.T11969/1ea0e148d9bbe08335cd      Object", "",
                "$`PIDINST-SchemaObject`[[1]][[2]]",                                 "[1] prop_name   type_id     cardinality nested     ",
                "<0 rows> (or 0-length row.names)",                                  "",
                "",                                                                  ""    )
  expect_equal(string_representation, expected)
})
