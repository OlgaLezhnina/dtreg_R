test_that("differ_input returns the list for a numeric input", {
  expect_equal(differ_input(3), 3)
})

test_that("differ_input calls the df_structure for a dataframe", {
  df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
  the$uid <- generate_uid()
  result <- differ_input(df)
  expect_equal(result$rows[[1]]$cells[[1]]$value, "1")
})

test_that("differ_input calls the df_structure for a tuple", {
  df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
  my_tuple <- sets::tuple(df, "my_tuple")
  the$uid <- generate_uid()
  result <- differ_input(my_tuple)
  expect_equal(result$rows[[1]]$cells[[1]]$value, "1")
})

test_that("df_structure writes column titles", {
  df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
  the$uid <- generate_uid()
  result <- df_structure(df, label = "Table")
  expect_equal(result$columns[[1]]$col_titles, "A")
})

test_that("df_structure writes missing values", {
  df <- data.frame(A = 1, B = NA, stringsAsFactors = FALSE)
  the$uid <- generate_uid()
  result <- df_structure(df, label = "Table")
  expect_equal(is.na(result$rows[[1]]$cells[[2]]$value), TRUE)
})

test_that("to_jsonld gives error when a field is a function", {
  abc <- function(x) {
    return(x + 1)
  }
  dt <- load_datatype("https://doi.org/21.T11969/74bc7748b8cd520908bc")
  instance <- dt$inferential_test_output(has_format = abc)
  expect_error(to_jsonld(instance),
               "Input in  has_format  should not be a function",
               fixed = TRUE)
})

test_that("to_jsonld writes an ePIC instance into JSONLD", {
  dt <- load_datatype("https://doi.org/21.T11969/aff130c76e68ead3862e")
  df <- data.frame(A = 1, stringsAsFactors = FALSE)
  instance <- dt$data_item(source_table = df)
  result <- to_jsonld(instance)
  expected <- c("{",
                "  \"@id\": \"_:n1\",",
                "  \"@type\": \"doi:aff130c76e68ead3862e\",",
                "  \"doi:aff130c76e68ead3862e#source_table\": {",
                "    \"@type\": \"doi:0424f6e7026fa4bc2c4a\",",
                "    \"tab_label\": \"Table\",",
                "    \"columns\": [",
                "      {",
                "        \"@type\": \"doi:65ba00e95e60fb8971e6\",",
                "        \"col_number\": 1,",
                "        \"col_titles\": \"A\",",
                "        \"@id\": \"_:n2\"",
                "      }",
                "    ],",
                "    \"rows\": [",
                "      {",
                "        \"@type\": \"doi:9bf7a8e8909bfd491b38\",",
                "        \"row_number\": 1,",
                "        \"row_titles\": \"1\",",
                "        \"@id\": \"_:n3\",",
                "        \"cells\": [",
                "          {",
                "            \"@type\": \"doi:4607bc7c42ac8db29bfc\",",
                "            \"@id\": \"_:n4\",",
                "            \"value\": \"1\",",
                "            \"column\": \"_:n2\"",
                "          }",
                "        ]",
                "      }",
                "    ],",
                "    \"@id\": \"_:n5\"",
                "  },",
                "  \"@context\": {",
                "    \"doi\": \"https://doi.org/21.T11969/\",",
                "    \"columns\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#columns\",",
                "    \"col_number\": \"https://doi.org/21.T11969/65ba00e95e60fb8971e6#number\",",
                "    \"col_titles\": \"https://doi.org/21.T11969/65ba00e95e60fb8971e6#titles\",",
                "    \"rows\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#rows\",",
                "    \"row_number\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#number\",",
                "    \"row_titles\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#titles\",",
                "    \"cells\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#cells\",",
                "    \"column\": \"https://doi.org/21.T11969/4607bc7c42ac8db29bfc#column\",",
                "    \"value\": \"https://doi.org/21.T11969/4607bc7c42ac8db29bfc#value\",",
                "    \"tab_label\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#label\"",
                "  }",
                "} ")

  expect_equal(capture.output(print(result)), expected)
})

test_that("to_jsonld writes an ePIC instance with a nested component", {
  dt <- load_datatype("https://doi.org/21.T11969/aff130c76e68ead3862e")
  url <- dt$url()
  instance <- dt$data_item(has_expression = url)
  result <- to_jsonld(instance)
  expected <- c("{",
                "  \"@id\": \"_:n1\",",
                "  \"@type\": \"doi:aff130c76e68ead3862e\",",
                "  \"doi:aff130c76e68ead3862e#has_expression\": {",
                "    \"@id\": \"_:n2\",",
                "    \"@type\": \"doi:e0efc41346cda4ba84ca\"",
                "  },",
                "  \"@context\": {",
                "    \"doi\": \"https://doi.org/21.T11969/\",",
                "    \"columns\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#columns\",",
                "    \"col_number\": \"https://doi.org/21.T11969/65ba00e95e60fb8971e6#number\",",
                "    \"col_titles\": \"https://doi.org/21.T11969/65ba00e95e60fb8971e6#titles\",",
                "    \"rows\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#rows\",",
                "    \"row_number\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#number\",",
                "    \"row_titles\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#titles\",",
                "    \"cells\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#cells\",",
                "    \"column\": \"https://doi.org/21.T11969/4607bc7c42ac8db29bfc#column\",",
                "    \"value\": \"https://doi.org/21.T11969/4607bc7c42ac8db29bfc#value\",",
                "    \"tab_label\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#label\"",
                "  }",
                "} ")

  expect_equal(capture.output(print(result)), expected)
})

test_that("to_jsonld writes an ePIC instance with a list of nested components", {
  dt <- load_datatype("https://doi.org/21.T11969/aff130c76e68ead3862e")
  url_1 <- dt$url()
  url_2 <- dt$url()
  instance <- dt$data_item(has_expression = c(url_1, url_2))
  result <- to_jsonld(instance)
  expected <- c("{",
                "  \"@id\": \"_:n1\",",
                "  \"@type\": \"doi:aff130c76e68ead3862e\",",
                "  \"doi:aff130c76e68ead3862e#has_expression\": [",
                "    {",
                "      \"@id\": \"_:n2\",",
                "      \"@type\": \"doi:e0efc41346cda4ba84ca\"",
                "    },",
                "    {",
                "      \"@id\": \"_:n3\",",
                "      \"@type\": \"doi:e0efc41346cda4ba84ca\"",
                "    }",
                "  ],",
                "  \"@context\": {",
                "    \"doi\": \"https://doi.org/21.T11969/\",",
                "    \"columns\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#columns\",",
                "    \"col_number\": \"https://doi.org/21.T11969/65ba00e95e60fb8971e6#number\",",
                "    \"col_titles\": \"https://doi.org/21.T11969/65ba00e95e60fb8971e6#titles\",",
                "    \"rows\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#rows\",",
                "    \"row_number\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#number\",",
                "    \"row_titles\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#titles\",",
                "    \"cells\": \"https://doi.org/21.T11969/9bf7a8e8909bfd491b38#cells\",",
                "    \"column\": \"https://doi.org/21.T11969/4607bc7c42ac8db29bfc#column\",",
                "    \"value\": \"https://doi.org/21.T11969/4607bc7c42ac8db29bfc#value\",",
                "    \"tab_label\": \"https://doi.org/21.T11969/0424f6e7026fa4bc2c4a#label\"",
                "  }",
                "} ")

  expect_equal(capture.output(print(result)), expected)
})


test_that("to_jsonld writes an ORKG instance into JSONLD", {
  dt <- load_datatype("https://orkg.org/template/R758316")
  instance <- dt$dtreg_test_template2(label = "test")
  result <- to_jsonld(instance)
  expected <- c("{",
                "  \"@id\": \"_:n1\",",
                "  \"@type\": \"orkgr:R758316\",",
                "  \"label\": \"test\",",
                "  \"@context\": {",
                "    \"orkgc\": \"https://orkg.org/class/\",",
                "    \"orkgr\": \"https://orkg.org/resource/\",",
                "    \"orkgp\": \"https://orkg.org/property/\",",
                "    \"columns\": \"https://orkg.org/property/CSVW_Columns\",",
                "    \"col_number\": \"https://orkg.org/property/CSVW_Number\",",
                "    \"col_titles\": \"https://orkg.org/property/CSVW_Titles\",",
                "    \"rows\": \"https://orkg.org/property/CSVW_Rows\",",
                "    \"row_number\": \"https://orkg.org/property/CSVW_Number\",",
                "    \"row_titles\": \"https://orkg.org/property/CSVW_Titles\",",
                "    \"cells\": \"https://orkg.org/property/CSVW_Cells\",",
                "    \"column\": \"https://orkg.org/property/CSVW_Column\",",
                "    \"value\": \"https://orkg.org/property/CSVW_Value\",",
                "    \"label\": \"http://www.w3.org/2000/01/rdf-schema#label\",",
                "    \"tab_label\": \"http://www.w3.org/2000/01/rdf-schema#label\"",
                "  }",
                "} ")

  expect_equal(capture.output(print(result)), expected)
})
