#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return Boolean, whether the template JSON file is in the static data
#'
check_static <- function(template_doi) {
  part <- strsplit(template_doi, split = "[/ //]+")
  name <- paste(part[[1]][[3]], part[[1]][[4]], "json", sep = ".")
  all_static <-
    system.file("extdata", package = "dtreg") |> list.files()
  checked <- name %in% all_static
  return(checked)
}
