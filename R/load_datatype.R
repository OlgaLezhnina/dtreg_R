#' Load datatype
#'
#' @param datatype_id The identifier of a datatype
#'
#' @return a list of schemata for creating new instances
#' @export
#'
#' @examples
#' pd <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
#'
load_datatype <- function(datatype_id) {
  r6_classes <- write_r6_classes(datatype_id)
  schemata <- write_proxies(r6_classes)
  return(schemata)
}

#' Write proxies
#'
#' @param r6_classes A list of R6 classes for a specified datatype
#' @return a list of objects for creating new instances
#'
write_proxies <- function(r6_classes) {
  proxies <- list()
  for (object in r6_classes) {
    name <- stringr::str_sub(object$classname, end = -4)
    proxies[[name]] <- object$new
  }
  return(proxies)
}

#' Write R6 classes for a specified datatype
#'
#' @param datatype_id The identifier of a datatype
#' @return a list of R6 classes for the datatype
#'
write_r6_classes <- function(datatype_id) {
  selected_class <- select_dtr(datatype_id)
  schema_info <- selected_class$new()$get_schema_info(datatype_id)
  all_classes <- list()
  for (t in seq_along(schema_info)) {
    schema_data <- schema_info[[t]]
    r6_class <-
      R6::R6Class(
        paste0(schema_data[[1]]$dt_name, "_r6"),
        inherit = selected_class,
        public = c(
          list(
            prefix = get_prefix(datatype_id),
            dt_name = schema_data[[1]]$dt_name,
            dt_id = schema_data[[1]]$dt_id,
            prop_names = schema_data[[2]]$dtp_name,
            prop_info = schema_data[[2]],
            initialize = function(...) {
              args <- list(...)
              for (dtp_name in self$prop_names) {
                self[[dtp_name]] <- args[[dtp_name]]
              }
            }
          ),
          sapply(schema_data[[2]]$dtp_name, function(x)
            NULL)
        )
      )
    all_classes[[format_string(schema_data[[1]]$dt_name)]] <- r6_class
  }
  return(all_classes)
}
