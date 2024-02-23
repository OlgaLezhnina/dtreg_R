#' Title
#'
#' @param route
#' @return
#'
request_epic <- function(route) {
  path <- with_host(route)
  req <- httr2::request(path)
  resp <- httr2::req_perform(req)
  info <- httr2::resp_body_json(resp)
  return(info)
}
