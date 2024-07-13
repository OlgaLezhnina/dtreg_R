#' To_jsonld writes an instance as JSON-LD
#' @param instance An instance of an R6 class
#' @return JSON string in JSON-LD format
#' @export
#' @examples
#' dt <- load_datatype("https://doi.org/21.T11969/74bc7748b8cd520908bc")
#' instance <- dt$inferential_test_output(label = "my_results")
#' result <- to_jsonld(instance)
#'
to_jsonld <- function(instance) {
  the$constants <- instance$add_df_constants()
  the$uid <- generate_uid()
  write_info <- function(instance) {
    result <- list()
    result[["@id"]] <- paste0("_:n", the$uid())
    result[["@type"]] <- instance$add_dt_type(instance$dt_id)
    result[["label"]] <- instance$label
    field_list <- show_fields(instance)
    for (field in field_list) {
      instance_field <- instance[[field]]
      prop_id <-
        instance$prop_info$dtp_id[instance$prop_info$dtp_name == field]
      prop_type <- instance$add_dtp_type(prop_id)
      if (is.null(instance_field)) {
        next
      } else if (is.list(instance_field) &&
                   inherits(instance_field[[1]], "R6")) {
        result[[prop_type]] <- lapply(instance_field, write_info)
      } else if (inherits(instance_field, "R6")) {
        result[[prop_type]] <- write_info(instance_field)
      } else {
        result[[prop_type]] <- differ_input(instance_field)
      }
    }
    return(result)
  }
  result_all <- list()
  result_all[[instance$dt_name]] <- write_info(instance)
  result_all[["@context"]] <- instance$add_context(instance$prefix)
  inst_json <-
    jsonlite::toJSON(result_all, pretty = TRUE, auto_unbox = TRUE)
  return(inst_json)
}

#' Differ input deals differently with inputs of different types
#' @param input Can be NA, a dataframe, a tuple, or another input
#' @return An input-dependent R object or the df_structure function call
#' to be further used by to_jsonld function
#'
differ_input <- function(input) {
  if (methods::is(input, "data.frame")) {
    output <- df_structure(df = input, label = "Table")
  } else if (methods::is(input, "tuple")) {
    output <- df_structure(df = input[[1]], label = input[[2]])
  } else {
    output <- input
  }
  return(output)
}

#' Df structure function writes a dataframe into JSON-LD
#' @param df A dataframe
#' @param label A character string
#' @return An R object to be used by to_jsonld function
#'
df_structure <- function(df, label) {
  result <- list()
  result[["@type"]] <- the$constants$table
  result[["label"]] <- label
  index <- list()
  result[["columns"]] <- list()
  for (i in seq_len(ncol(df))) {
    column <- list()
    column[["@type"]] <- the$constants$column
    column[["col_titles"]] <- colnames(df)[i]
    column[["col_number"]] <- i
    column[["@id"]] <- paste0("_:n", the$uid())
    index <- append(index, column[["@id"]])
    result[["columns"]] <-
      append(result[["columns"]], list(column))
  }
  result[["rows"]] <- list()
  for (i in seq_len(nrow(df))) {
    row <- list()
    row[["@type"]] <- the$constants$row
    row[["row_number"]] <- i
    row[["row_titles"]] <- rownames(df)[i]
    row[["cells"]] <- list()
    for (y in seq_len(ncol(df))) {
      cell <- list()
      cell[["@type"]] <- the$constants$cell
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
