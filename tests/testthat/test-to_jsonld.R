test_that("differ_input returns the list for a numeric input", {
  expect_equal(differ_input(3), 3)
})

test_that("differ_input calls the df_structure for a dataframe", {
  df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
  the$uid <- generate_uid()
  result <- differ_input(df)
  expect_equal(result$rows[[1]]$cells[[1]]$value, "1")
})

test_that("df_structure writes a dataframe in a specified way", {
  df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
  the$uid <- generate_uid()
  result <- df_structure(df, label = "Table")
  expect_equal(result$columns[[1]]$col_titles, "A")
})

test_that("to_jsonld writes an instance in a specified way", {
  schema <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
  instance <- schema$pidinst_schemaobject()
  result <- to_jsonld(instance)
  expected <- c(
                "{",
                "  \"pidinst_schemaobject\": {",
                "    \"@id\": \"_:n1\",",
                "    \"@type\": \"doi:1ea0e148d9bbe08335cd\"",
                "  },",
                "  \"@context\": {",
                "    \"doi:\": \"https://doi.org/21.T11969/\",",
                "    \"columns:\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#columns\",",
                "    \"col_number:\": \"https://doi.org/21.T11969/65ba00e95e60fb8971e6#number\",",
                "    \"col_titles:\": \"https://doi.org/21.T11969/65ba00e95e60fb8971e6#titles\",",
                "    \"rows:\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#rows\",",
                "    \"row_number:\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#number\",",
                "    \"row_titles:\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#titles\",",
                "    \"cells:\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#cells\",",
                "    \"column:\": \"https://doi.org/21.T11969/4607bc7c42ac8db29bfc#column\",",
                "    \"value:\": \"https://doi.org/21.T11969/4607bc7c42ac8db29bfc#value\"",
                "  }",
                "} ")

  expect_equal(capture.output(print(result)), expected)
})
