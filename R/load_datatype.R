#' Title
#'
#' @param template_doi The DOI of a DTR template
#'
#' @return a list of objects for creating new instances
#' @export
#'
#' @examples
#' pd <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
#'
load_datatype <- function(template_doi) {
  r6_objects <- write_r6_classes(template_doi)
  result <- write_proxies(r6_objects)
  return(result)
}

#' Title
#'
#' @param object_list A list of R6 objects
#' @return a list of objects for creating new instances
#'
write_proxies <- function(object_list) {
  proxies <- list()
  for (object in object_list) {
    name <- stringr::str_sub(object$classname, end = -4)
    proxies[[name]] <- object$new
  }
  return(proxies)
}

#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return an R6 object for the template
#'
write_r6_classes <- function(template_doi) {
  selected_class <- select_dtr(template_doi)
  templ_info <- selected_class$new()$get_template_info(template_doi)
  result <- list()
  for (t in seq_along(templ_info)) {
    templ_data <- templ_info[[t]]
    r6_template <-
      paste0(
        "R6::R6Class('",
        paste0(format_string(templ_data[[1]]$dt_name), "_r6"),
        "',
        inherit = ",
        selected_class$classname,",
        public = list(
        prefix = NULL,
        dt_name = NULL,
        dt_id = NULL",
        paste(sprintf(
          ",\n%s = NULL",
          format_string(templ_data[[2]]$dtp_name)
        ), collapse = ""),
        ",
        initialize = function(
        prefix = NA,
        dt_name = NA",
        paste(sprintf(
          ",\n%s = NA",
          format_string(templ_data[[2]]$dtp_name)
        ), collapse = ""),
        ") {
        self$prefix = '",
        get_prefix(template_doi),
        "'
        self$dt_name = '",
        format_string(templ_data[[1]]$dt_name),
        "'
        self$dt_id = '",
        templ_data[[1]]$dt_id,
        "'",
        paste(sprintf(
          "\nself$%1$s = %1$s",
          format_string(templ_data[[2]]$dtp_name)
        ),
        collapse = ""),
        "}))"
      )
    result[[format_string(templ_data[[1]]$dt_name)]] <-
      eval(parse(text = r6_template))
  }
  return(result)
}
