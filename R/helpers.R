#' Format a string
#' @param string A character vector
#' @return A character vector formatted in the required way
#'
format_string  <- function(string) {
  return(stringr::str_replace_all(
    stringr::str_replace_all(tolower(string), "[ -]", "_"),
    "[^a-zA-Z0-9_]",
    ""
  ))
}
#' Get prefix
#' @param url_string A URL string
#' @return The prefix string indicating the datatype
#'
get_prefix <- function(url_string) {
  part <- strsplit(url_string, split = "[/ //]+")[[1]]
  if (stringr::str_detect(part[[2]], "orkg.org")) {
    prefix <- paste0(part[[1]], "//", part[[2]], "/")
  } else if (part[[3]] == "21.T11969") {
    prefix <- paste0(part[[1]], "//", part[[2]], "/", part[[3]], "/")
  }
  return(prefix)
}

#' Specify cardinality of an ePIC property
#' @param cardinality_string An ePIC string for cardinality
#' @return A named list with min and max values as integers or NA
#'
specify_cardinality <- function(cardinality_string) {
  min_max <- list()
  card_parts <- strsplit(cardinality_string, split = " - ")[[1]]
  if (length(card_parts) == 1) {
    min_max[["min"]] <- as.integer(cardinality_string)
    min_max[["max"]] <- as.integer(cardinality_string)
  } else {
    min_max[["min"]] <- as.integer(card_parts[[1]])
    if (card_parts[[2]] == "n") {
      min_max[["max"]] <- NA
    } else {
      min_max[["max"]] <- as.integer(card_parts[[2]])
    }
  }
  return(min_max)
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

#' Show fields that can be filled by the user when writing a datatype instance
#'
#' @param datatype An R object from dtreg::load_datatype
#'
#' @return Fields that can be used in an instance
#' @export
#'
#' @examples
#' pd <- load_datatype("https://doi.org/21.T11969/1ea0e148d9bbe08335cd")
#' show_fields(pd$pidinst_schemaobject())
#'
show_fields <- function(datatype) {
  all_fields <- names(datatype)
  implicit <- c(".__enclos_env__",
                "clone",
                "initialize",
                "schema_info",
                "get_schema_info",
                "add_context",
                "add_dt_type",
                "add_dtp_type",
                "add_df_constants",
                "dt_name",
                "dt_id",
                "prefix",
                "prop_names",
                "prop_info")
  fields_to_show <- all_fields[!(all_fields %in% implicit)]
  if (length(fields_to_show) == 0) {
    fields_to_show <- NULL
  }
  return(fields_to_show)
}
