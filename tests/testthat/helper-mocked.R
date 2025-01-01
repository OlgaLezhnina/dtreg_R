mocked_request_dtr <- function(route) {
  if (route == "https://orkg.org/api/templates/R758315") {
    mocked_info <- info_template_1
  } else if (route == "https://orkg.org/api/templates/R758316") {
    mocked_info <- info_template_2
  } else if (route == "https://orkg.org/api/templates/?target_class=C102007") {
    mocked_info <- info_via_class
  } else {
    stop("Please check the URL for mocking")
  }
  return(mocked_info)
}

info_template_1 <- list(
  id = "R758315",
  label = "dtreg_test_template1",
  target_class = list(id = "C102006"),
  properties = list(
    list(
      min_count = 0,
      max_count = NULL,
      path = list(id = "P160020", label = "property1"),
      datatype = list(id = "String")
    ),
    list(
      min_count = 0,
      max_count = NULL,
      path = list(id = "P160021", label = "property2"),
      class = list(id = "C102007")
    )
  )
)

info_template_2 <- list(
  id = "R758316",
  label = "dtreg_test_template2",
  target_class = list(id = "C102007"),
  properties = list(list(
    min_count = 0,
    max_count = NULL,
    path = list(id = "P160024", label = "property3"),
    datatype = list(id = "Integer")
  ))
)

info_via_class <- list(content = list(list(id = "R758316",
                                           label = "dtreg_test_template2")))
