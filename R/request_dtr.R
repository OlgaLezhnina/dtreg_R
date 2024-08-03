#' Request dtr
#' @description
#' Request an API of a datatype registry
#' @param route The path for requesting a dtr API
#' @return Requested information about a datatype schema
#' @keywords internal
#'
request_dtr <- function(route) {
  req <- httr2::request(route)
  resp <- httr2::req_perform(req)
  info <- httr2::resp_body_json(resp)
  return(info)
}
