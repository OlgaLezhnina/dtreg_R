#' Title
#'
#' @param epic_id The identifier of an ePIC object
#' @return Boolean, whether the file is in the extdata
#'
check_static <- function(epic_id) {
  id_1 <- strsplit(epic_id, split = "/")[[1]][1]
  name <- paste(id_1, ".json", sep = "")
  all_static <-
    system.file("extdata", package = "dtreg") |> list.files()
  checked <- name %in% all_static
  return(checked)
}

#' Title
#'
#' @param epic_id The identifier of an ePIC object
#' @return An R object that contains information about the ePIC object
#'
extract_epic <- function(epic_id) {
  extract_all <- list()
  extractor_function <- function(epic_id) {
    info <- request_epic(epic_id)
    name <- info$name
    identifier <- info$Identifier
    schema_df <- data.frame(name, identifier)
    all_props <- list()
    if (info$Schema$Type == "Object" ||
          info$Schema$Type == "Array") {
      for (prop in info$Schema$Properties) {
        specific_prop <- list()
        specific_prop[["predicate_label"]] <- prop$Name
        specific_prop[["nested_name"]] <- prop$Type
        specific_prop[["cardinality"]] <-
          prop$Properties$Cardinality
        if (!is.null(prop$Type) &&
              !"nested_name" %in% names(extract_all)) {
          extractor_function(prop$Type)
        }
        all_props <- append(all_props, list(specific_prop))
      }
    }
    extracted <- list(schema_df, all_props)
    extract_all[[name]] <<- list(extracted)
    return(extract_all)
  }
  extractor_function(epic_id)
  return(extract_all)
}
