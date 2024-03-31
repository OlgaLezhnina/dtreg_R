#' Title
#'
#' @param template_doi The DOI of an ePIC template
#' @return An R object that contains information about the ePIC template
#'
extract_epic <- function(template_doi) {
  extract_all <- list()
  extractor_function <- function(template_doi) {
    info <- request_epic(template_doi)
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
  extractor_function(template_doi)
  return(extract_all)
}
