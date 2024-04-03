#' Title
#'
#' @param template_doi The DOI of a DTR template
#'
#' @return an R6 object
#' @export
#'
#' @examples load_objects("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
#'
load_objects <- function(template_doi) {
  datypreg <- select_dtr(template_doi)
  datypreg$get_template_info(template_doi)
  templ_info <- datypreg$template_info
  result <- write_r6_classes(templ_info)
  return(result)
}


#' Title
#'
#' @param templ_info an R object with a template structured information
#' @return an R6 object for the template
#'
write_r6_classes <- function(templ_info) {
  result <- list()
  for (t in seq_along(templ_info)) {
    templ_data <- templ_info[[t]][[1]]
    r6_template <-
      paste(
        "R6::R6Class('",
        paste(format_string(templ_data[[1]]$name), "_r6", sep = ""),
        "',
        public = list(
        name = NULL,
        identifier = NULL",
        paste(sprintf(
          ",\n%s = NULL",
          format_string(templ_data[[2]]$prop_name)
        ), collapse = ""),
        ",
        initialize = function(
        name = NA",
        paste(sprintf(
          ",\n%s = NA",
          format_string(templ_data[[2]]$prop_name)
        ), collapse = ""),
        ") {
        self$name = '",
        format_string(templ_data[[1]]$name),
        "'
        self$identifier = '",
        templ_data[[1]]$identifier,
        "'",
        paste(sprintf(
          "\nself$%1$s = %1$s",
          format_string(templ_data[[2]]$prop_name)
        ),
        collapse = ""),
        "}))",
        sep = ""
      )
    result[[format_string(templ_data[[1]]$name)]] <-
      eval(parse(text = r6_template))
  }
  return(result)
}
