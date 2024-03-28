test_that("format_string makes text lowcase, spaces and dashes to underscores", {
  expect_equal(format_string("a-B c"), "a_b_c")
})
