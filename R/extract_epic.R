#' Extract ePIC datatype information
#'
#' @param datatype_id An identifier of an ePIC datatype
#' @return A named list that contains information about the ePIC datatype
#' @noRd
#'
extract_epic <- function(datatype_id) {
  extract_all <- list()
  extractor_function <- function(datatype_id) {
    info <- request_dtr(paste0(datatype_id, "?locatt=view:json"))
    dt_name <- format_string(info$name)
    dt_id <- stringr::str_split_i(info$Identifier, "/", 2)
    dt_class <- info$Schema$Type
    schema_df <- data.frame(dt_name, dt_id, dt_class)
    i <- 0
    all_props <- data.frame(
      dtp_name = character(),
      dtp_id = character(),
      dtp_card_min = integer(),
      dtp_card_max = integer(),
      dtp_value_type = character(),
      stringsAsFactors = FALSE
    )
    for (prop in info$Schema$Properties) {
      specific_prop <- list()
      if (is.null(prop$Type)) {
        specific_prop[["dtp_name"]] <- format_string(prop$Property)
        specific_prop[["dtp_id"]] <-
          paste0(dt_id, "#", format_string(prop$Property))
        specific_prop[["dtp_card_min"]] <- NA
        specific_prop[["dtp_card_max"]] <- NA
        specific_prop[["dtp_value_type"]] <- prop$Value
      } else {
        specific_prop[["dtp_name"]] <- format_string(prop$Name)
        specific_prop[["dtp_id"]] <-
          paste0(dt_id, "#", format_string(prop$Name))
        card <- specify_cardinality(prop$Properties$Cardinality)
        specific_prop[["dtp_card_min"]] <- card[["min"]]
        specific_prop[["dtp_card_max"]] <- card[["max"]]
        specific_prop[["dtp_value_type"]] <- prop$Type
        if (prop$Type != "") {
          extractor_function(paste0("https://doi.org/", prop$Type))
        }
      }
      i <- i + 1
      all_props[i, ] <- specific_prop
    }
    extracted <- list(schema_df, all_props)
    extract_all[[dt_name]] <<- extracted
  }
  extractor_function(datatype_id)
  return(extract_all)
}
