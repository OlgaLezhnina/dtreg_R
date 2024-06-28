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
#' Format a string
#' @param string A URL string
#' @return The string which is the prefix of the URL
#'
get_prefix <- function(string) {
  part <- strsplit(string, split = "[/ //]+")[[1]]
  prefix <- paste0(part[[1]], "//", part[[2]], "/")
  return(prefix)
}

#' Split an ePIC cardinality string into min and max values
#' @param range_str An ePIC string for cardinality range
#' @return A named list with min and max values as integer or NA
#'
range_split <- function(range_str) {
  output <- list()
  range_parts <- strsplit(range_str, split = " - ")[[1]]
  if (length(range_parts) == 1) {
    output[["min"]] <- as.integer(range_str)
    output[["max"]] <- as.integer(range_str)
  } else {
    output[["min"]] <- as.integer(range_parts[[1]])
    if (range_parts[[2]] == "n") {
      output[["max"]] <- NA
    } else {
      output[["max"]] <- as.integer(range_parts[[2]])
    }
  }
  return(output)
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
               "template_info",
               "get_template_info",
               "add_context",
               "dt_name",
               "dt_id")
  output <- all_fields[!(all_fields %in% written)]
  if (length(output) == 0) {
    output <- NULL
  }
  return(output)
}
