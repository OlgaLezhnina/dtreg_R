#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return The template information from a JSON file, or NULL if not in static
#'
from_static <- function(template_doi) {
  id <- strsplit(template_doi, split = "/+")[[1]][[4]]
  final_template <- NULL
  static_names <- names(the$static_all)
  for (name in static_names) {
    if (stringr::str_detect(name, id)) {
      final_template <- the$static_all[[name]]
      break
    }
  }
  return(final_template)
}
