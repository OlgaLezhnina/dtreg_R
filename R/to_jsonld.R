#' An internal function to deal differently with inputs of different types
#' @param input Can be NA, a dataframe, a tuple, or another input
#' @return An R object to be used by to_jsonld function
#'
differ_type <- function(input) {
  if (methods::is(input, "data.frame")) {
    output <- df_structure(df = input, label = "Table")
  } else if (methods::is(input, "tuple")) {
    output <- df_structure(df = input[[1]], label = input[[2]])
  } else if (length(input) == 1 && is.na(input)) {
    output <- NULL
  } else {
    output <- list(input)
  }
  return(output)
}

#' An internal function to help writing a dataframe into JSON-LD
#' @param df A dataframe
#' @param label A character string
#' @return An R object to be used by to_jsonld function
#'
df_structure <- function(df, label) {
  result <- list()
  result[["@type"]] <-
    "https://doi.org/21.T11969/0424f6e7026fa4bc2c4a"
  result[["label"]] <- label
  index <- list()
  result[["columns"]] <- list()
  for (i in seq_len(ncol(df))) {
    column <- list()
    column[["@type"]] <-
      "https://doi.org/21.T11969/65ba00e95e60fb8971e6"
    column[["titles"]] <- colnames(df)[i]
    column[["number"]] <- i
    column[["@id"]] <- paste0("_:n", the$uid())
    index <- append(index, column[["@id"]])
    result[["columns"]] <-
      append(result[["columns"]], list(column))
  }
  result[["rows"]] <- list()
  for (i in seq_len(nrow(df))) {
    row <- list()
    row[["@type"]] <-
      "https://doi.org/21.T11969/9bf7a8e8909bfd491b38"
    row[["number"]] <- i
    row[["titles"]] <- rownames(df)[i]
    row[["cells"]] <- list()
    for (y in seq_len(ncol(df))) {
      cell <- list()
      cell[["@type"]] <-
        "https://doi.org/21.T11969/4607bc7c42ac8db29bfc"
      if (!is.null(df[[y]][[i]])) {
        cell[["value"]] <- as.character(df[[y]][[i]])
      } else {
        cell["value"] <- list(NULL)
      }
      cell[["column"]] <- index[[y]]
      row[["cells"]] <- append(row[["cells"]], list(cell))
    }
    result[["rows"]] <- append(result[["rows"]], list(row))
  }
  result[["@id"]] <- paste0("_:n", the$uid())
  return(result)
}

#' Writes an instance as JSON-LD
#' @param instance An instance of an R6 class
#' @return JSON string in JSON-LD format
#' @export
#' @examples
#'
to_jsonld <- function(instance) {
  the$uid <- generate_uid()
  write_info <- function(instance) {
    result <- list()
    result[["@id"]] <- paste0("_:n", the$uid())
    result[["@type"]] <- paste0("doi:", instance$dt_id)
    result[["label"]] <- instance$label
    field_list <- show_fields(instance)
    for (field in field_list) {
      instance_field <- instance[[field]]
      if (inherits(instance_field, "R6")) {
        result[[field]] <- write_info(instance_field)
      } else {
        result[[field]] <- differ_type(instance_field)
      }
    }
    return(result)
  }
  result_all <- list()
  result_all[[instance$dt_name]] <- write_info(instance)
  result_all[["@context"]] <- instance$add_context()
  inst_json <-
    jsonlite::toJSON(result_all, pretty = TRUE, auto_unbox = TRUE)
  return(inst_json)
}
