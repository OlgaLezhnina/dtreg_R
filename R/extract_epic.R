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
    schema_type <- info$Schema$Type
    schema_df <- data.frame(name, identifier, schema_type)
    i <- 0
    all_props <- data.frame(
      prop_name = character(),
      type_id = character(),
      cardinality = character(),
      nested = logical(),
      stringsAsFactors = FALSE
    )
    for (prop in info$Schema$Properties) {
      specific_prop <- list()
      if (is.null(prop$Type)) {
        specific_prop[["prop_name"]] <- prop$Property
        specific_prop[["type_id"]] <- "value"
        specific_prop[["cardinality"]] <- "no_info"
        specific_prop[["nested"]] <- FALSE
      } else {
        specific_prop[["prop_name"]] <- prop$Name
        specific_prop[["type_id"]] <- prop$Type
        specific_prop[["cardinality"]] <-
          prop$Properties$Cardinality
        specific_prop[["nested"]] <- TRUE
        extractor_function(prop$Type)
      }
      i <- i + 1
      all_props[i, ] <- specific_prop
    }
    extracted <- list(schema_df, all_props)
    extract_all[[name]] <<- list(extracted)
    return(extract_all)
  }
  extractor_function(epic_id)
  return(extract_all)
}
