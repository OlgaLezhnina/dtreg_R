#' Title
#'
#' @param epic_id The identifier of an ePIC object
#' @return Requested information about an ePIC object
#'
request_epic <- function(epic_id) {
  path <-
    paste("https://doi.org/", epic_id, "?locatt=view:json", sep = "")
  req <- httr2::request(path)
  resp <- httr2::req_perform(req)
  info <- httr2::resp_body_json(resp)
  return(info)
}
