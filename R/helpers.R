#' Format a string
#' @param text A character vector
#' @return A character vector formatted in the required way
#'
format_string  <- function(text) {
  return(stringr::str_replace_all(
    stringr::str_replace_all(tolower(text), "[ -]", "_"),
    "[^a-zA-Z0-9_]",
    ""
  ))
}

#' Generate a counting function
#' used for assigning unique identifiers
#' @return The counting function
#'
generate_uid <- function() {
  i <- 0
  return(function() {
    i <<- i + 1
    return(i)
  })
}

#' Title
#'
#' @param object An object from dtreg::load_objects
#'
#' @return Fields to use in an instance
#' @export
#'
#' @examples
#' pd <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
#' show_fields(pd$pidinst_schemaobject())
#'
show_fields <- function(object) {
  all_fields <- names(object)
  written <- c(".__enclos_env__",
               "clone",
               "initialize",
               "name",
               "identifier")
  output <- all_fields[!(all_fields %in% written)]
  if (length(output) == 0) {
    output <- NULL
  }
  return(output)
}
