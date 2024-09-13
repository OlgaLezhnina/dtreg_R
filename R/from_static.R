#' From static
#' @description
#' Get schema information from static files
#' @param datatype_id A schema identifier
#' @return The requested schema information, or NULL if not in static
#' @noRd
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
