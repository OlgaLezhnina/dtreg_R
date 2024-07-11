test_that("differ_input returns the list for a numeric input", {
  expect_equal(differ_input(3), 3)
})

test_that("df_structure writes a dataframe in a specified way", {
  df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
  the$uid <- generate_uid()
  result <- df_structure(df, label = "Table")
  expect_equal(result$columns[[1]]$col_titles, "A")
})

test_that("df_structure writes a tuple in a specified way", {
  df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
  the$uid <- generate_uid()
  result <- df_structure(df, label = "Table")
  expect_equal(result$columns[[1]]$col_titles, "A")
})
