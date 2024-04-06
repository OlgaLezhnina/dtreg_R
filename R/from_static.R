#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return The template information from a JSON file, or "none" if not in static
#'
from_static <- function(template_doi) {
  part <- strsplit(template_doi, split = "/+")[[1]]
  id <- paste(part[[3]], part[[4]], sep = "/")
  final_template <- NULL
  for (i in length(TEMPLATES)) {
    if (id %in% TEMPLATES[[i]]) {
      static_template <-
        eval(parse(text = paste("the$template_", i, sep = "")))
      for (templ in static_template) {
        if (id == templ[[1]][[1]]$identifier) {
          final_template <- templ
        }
      }
    }
  }
  return(final_template)
}

TEMPLATE_1 <- list("21.T11969/3df63b7acb0522da685d",
                   "21.T11969/33cc57788c0036ad3bdc",
                   "21.T11969/f9bdfd1810b999e3b11e")
TEMPLATE_2 <- list("21.T11969/f76ad9d0324302fc47dd")

TEMPLATES <- list(TEMPLATE_1,
                  TEMPLATE_2)
show <- function(){
  return(the$template_2)
}
