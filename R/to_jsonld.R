#' Detect the input length to apply or lapply a function
#' @param input A single element or a list
#' @param func A function to be applied to the input
#' @return The result of the function applied in the differentiated way
#'
differ_length <- function(input, func) {
  if (length(input) == 1) {
    output <- func(input)
  } else {
    output <- lapply(input, func)
  }
  return(output)
}

#' Write an instance as JSON-LD
#' @param instance An instance of an R6 class
#' @return JSON string in JSON-LD format
#' @export
#' @examples
#'
to_jsonld <- function(instance) {
  the$uid <- generate_uid()
  context <- list()
  context[[instance$identifier]] <-
    paste0("https://doi.org/", instance$identifier)
  write_info <- function(instance) {
    result <- list()
    result[["@id"]] <- paste0("_:n", the$uid())
    result[["label"]] <- instance$label
    result[["@type"]] <-
      paste0("https://doi.org/", instance$identifier)
    field_list <- show_fields(instance)
    for (field in field_list) {
      instance_field <-
        eval(parse(text = paste0("instance$", field)))
      if (length(instance_field) == 1 && is.na(instance_field)) {
        next
      } else {
        if (inherits(instance_field, "R6")) {
          result[[field]] <- write_info(instance_field)
        } else {
          result[[field]] <- list(instance_field)
        }
      }
    }
    return(result)
  }
  result <- write_info(instance)
  result[["@context"]] <- context
  inst_json <-
    jsonlite::toJSON(result, pretty = TRUE, auto_unbox = TRUE)
  return(inst_json)
}
