#' Load classes for a schema with the known identifier
#' @description
#' Load a list of R6 classes for a schema identifier, such as
#' an ePIC datatype DOI or an ORKG template URL.
#' The classes contain information of the requested schema and nested schemata.
#' @param datatype_id A schema identifier, such as a DOI or a URL
#' @return A list of R6 classes
#' @export
#'
#' @examples
#' dt <- dtreg::load_datatype("https://doi.org/21.T11969/aff130c76e68ead3862e")
#'
load_datatype <- function(datatype_id) {
  r6_classes <- write_r6_classes(datatype_id)
  schemata <- write_proxies(r6_classes)
  return(schemata)
}

#' Write proxies
#' @description
#' Rewrite R6 classes to remove $new notation for creating an instance
#' @param r6_classes A list of R6 classes
#' @return A list of rewritten R6 classes
#' @noRd
#'
write_proxies <- function(r6_classes) {
  proxies <- list()
  for (object in r6_classes) {
    name <- stringr::str_sub(object$classname, end = -4)
    proxies[[name]] <- object$new
  }
  return(proxies)
}

#' Write R6 classes for a schema with the known identifier
#'
#' @param datatype_id A schema identifier
#' @return A list of R6 classes for the schema
#' @noRd
#'
write_r6_classes <- function(datatype_id) {
  selected_class <- select_dtr(datatype_id)
  schema_info <- selected_class$new()$get_schema_info(datatype_id)
  all_classes <- list()
  for (t in seq_along(schema_info)) {
    schema <- schema_info[[t]]
    r6_class <-
      R6::R6Class(
        paste0(schema[[1]]$dt_name, "_r6"),
        inherit = selected_class,
        public = c(
          list(
            prefix = get_prefix(datatype_id),
            dt_name = schema[[1]]$dt_name,
            dt_id = schema[[1]]$dt_id,
            prop_names = schema[[2]]$dtp_name,
            prop_info = schema[[2]],
            initialize = function(...) {
              args <- list(...)
              for (dtp_name in self$prop_names) {
                self[[dtp_name]] <- args[[dtp_name]]
              }
            }
          ),
          sapply(schema[[2]]$dtp_name, function(x) NULL)
        )
      )
    all_classes[[format_string(schema[[1]]$dt_name)]] <- r6_class
  }
  return(all_classes)
}
