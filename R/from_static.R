#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return The template information from a JSON file, or NULL if not in static
#'
from_static <- function(template_doi) {
  part <- strsplit(template_doi, split = "/+")[[1]]
  id <- paste(part[[3]], part[[4]], sep = "/")
  final_template <- NULL
  for (static in the$static_all) {
    for (templ in static) {
      if (id == templ[[1]][[1]]$identifier) {
        final_template <- list(templ)
      }
    }
  }
  return(final_template)
}
