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
  write_info <- function(instance) {
    result <- list()
    field_list <- show_fields(instance)
    if (!is.null(field_list)) {
      for (field in field_list) {
        instance_field <-
          eval(parse(text = paste0("instance$", field)))
        if (inherits(instance_field, "R6")) {
          result[[field]] <-
            differ_length(instance_field, write_info)
        } else {
          result[[field]] <- list(instance_field)
        }
      }
    }
    return(result)
  }
  result <- write_info(instance)
  inst_json <-
    jsonlite::toJSON(result, pretty = TRUE, auto_unbox = TRUE)
  return(inst_json)
}
