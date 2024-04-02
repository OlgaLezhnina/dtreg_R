#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return Boolean, whether the template JSON file is in the static data
#'
check_static <- function(template_doi) {
  part <- strsplit(template_doi, split = "[/ //]+")
  id <- paste(part[[1]][[3]], part[[1]][[4]], sep = "/")
  checked <- id %in% TEMPLATE_1
  return(checked)
}

TEMPLATE_1 <- c("21.T11969/3df63b7acb0522da685d",
                "21.T11969/33cc57788c0036ad3bdc",
                "21.T11969/f9bdfd1810b999e3b11e")
TEMPLATE_2 <- c("21.T11969/f76ad9d0324302fc47dd")
