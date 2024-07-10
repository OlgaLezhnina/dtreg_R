#' From static, to get information from static files
#'
#' @param datatype_id The identifier, such as URL, of a datatype
#' @return The R object with schema from a JSON file, or NULL if not in static
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
