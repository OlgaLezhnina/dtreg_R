#' Request dtr
#' @description
#' Request an API of a datatype registry to get information about a schema
#' @param route A path for requesting a dtr API
#' @return Requested information about the schema
#' @noRd
#'
request_dtr <- function(route) {
  req <- httr2::request(route)
  resp <- httr2::req_perform(req)
  info <- httr2::resp_body_json(resp)
  return(info)
}
