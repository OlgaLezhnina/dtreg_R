#' Title
#'
#' @param dt_id The DOI of an ePIC schema
#' @return An R object that contains information about the ePIC schema
#'
extract_epic <- function(dt_id) {
  extract_all <- list()
  extractor_function <- function(dt_id) {
    info <- request_dtr(paste0(dt_id, "?locatt=view:json"))
    dt_name <- info$name
    dt_id <- info$Identifier
    dt_class <- info$Schema$Type
    schema_df <- data.frame(dt_name, dt_id, dt_class)
    i <- 0
    all_props <- data.frame(
      dtp_name = character(),
      dtp_id = character(),
      dtp_cardinality = character(),
      dtp_value_type = character(),
      stringsAsFactors = FALSE
    )
    for (prop in info$Schema$Properties) {
      specific_prop <- list()
      card <- range_split(prop$Properties$Cardinality)
      if (is.null(prop$Type)) {
        specific_prop[["dtp_name"]] <- prop$Property
        specific_prop[["dtp_id"]] <- paste0(dt_id, "#", prop$Property)
        specific_prop[["dtp_card_min"]] <- NA
        specific_prop[["dtp_card_max"]] <- NA
        specific_prop[["dtp_value_type"]] <- prop$Value
      } else {
        specific_prop[["dtp_name"]] <- prop$Name
        specific_prop[["dtp_id"]] <- paste0(dt_id, "#", prop$Name)
        specific_prop[["dtp_card_min"]] <- card[["min"]]
        specific_prop[["dtp_card_max"]] <- card[["max"]]
        specific_prop[["dtp_value_type"]] <- prop$Type
        extractor_function(paste0("https://doi.org/", prop$Type))
      }
      i <- i + 1
      all_props[i, ] <- specific_prop
    }
    extracted <- list(schema_df, all_props)
    extract_all[[dt_name]] <<- extracted
    return(extract_all)
  }
  extractor_function(dt_id)
  return(extract_all)
}
