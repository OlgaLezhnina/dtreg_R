#' From static
#' @description
#' Get schema information from static files, or NULL if not in static
#' @param datatype_id The identifier of a datatype, such as URL
#' @return The R object with schema from a JSON file, or NULL if not in static
#' @keywords internal
#'
from_static <- function(datatype_id) {
  id <- strsplit(datatype_id, split = "/+")[[1]][[4]]
  schema_info <- NULL
  static_names <- names(the$static_all)
  for (name in static_names) {
    if (stringr::str_detect(name, id)) {
      schema_info <- the$static_all[[name]]
      break
    }
  }
  return(schema_info)
}
