test_that("check_static detects an absence of a file in the extdata", {
  expect_equal(check_static("abcd/abcd"), FALSE)
})

test_that("extract_epic gives the specified template", {
  result_extract_epic <- extract_epic("21.T11969/1ea0e148d9bbe08335cd")
  string_representation <- capture.output(print(result_extract_epic))
  expected <- c("$`PIDINST-SchemaObject`",                               "$`PIDINST-SchemaObject`[[1]]",
                "$`PIDINST-SchemaObject`[[1]][[1]]",                     "                  name                     identifier",
                "1 PIDINST-SchemaObject 21.T11969/1ea0e148d9bbe08335cd", "",
                "$`PIDINST-SchemaObject`[[1]][[2]]",                     "list()",
                "",                                                      "",
                ""    )
  expect_equal(string_representation, expected)
})
