#' Title
#'
#' @param template_doi The DOI of an ePIC template
#' @return Requested information about an ePIC template
#'
request_epic <- function(template_doi) {
  path <-
    paste(template_doi, "?locatt=view:json", sep = "")
  req <- httr2::request(path)
  resp <- httr2::req_perform(req)
  info <- httr2::resp_body_json(resp)
  return(info)
}
