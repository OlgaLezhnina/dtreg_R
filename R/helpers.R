#' Format a string
#' @description
#' Format a string to lowercase, spaces and dashes as underscores
#' @param string A character vector
#' @return A character vector formatted in the required way
#' @noRd
#'
format_string  <- function(string) {
  return(stringr::str_replace_all(
    stringr::str_replace_all(tolower(string), "[ -]", "_"),
    "[^a-zA-Z0-9_]",
    ""
  ))
}
#' Get prefix
#' @description
#' Get prefix of a URL string
#' @param url_string A URL string
#' @return The prefix string indicating a datatype
#' @noRd
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

#' Specify cardinality
#' @description Write cardinality of an ePIC property as a named list
#' @param cardinality_string An ePIC string for cardinality
#' @return A named list with min and max values as integers or NA
#' @noRd
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

#' Generate uid function
#' @description
#' Generate a counting function for assigning identifiers
#' @return The counting function
#' @noRd
#'
generate_uid <- function() {
  i <- 0
  return(function() {
    i <<- i + 1
    return(i)
  })
}

#' Show schema fields
#' @description
#' Show which fields of a schema can be used for creating an instance
#' @param datatype An R6 class from dtreg::load_datatype
#'
#' @return A character vector of available fields
#' @export
#'
#' @examples
#' dt <- dtreg::load_datatype("https://doi.org/21.T11969/74bc7748b8cd520908bc")
#' dtreg::show_fields(dt$inferential_test_output())
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
