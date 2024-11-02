#' Extract ORKG template information
#'
#' @param datatype_id An identifier of an ORKG template
#' @return A named list that contains information about the ORKG template
#' @noRd
#'
extract_orkg <- function(datatype_id) {
  part <- strsplit(datatype_id, split = "[/ //]+")[[1]]
  orkg_hostname <- paste0(part[[1]], "//", part[[2]])
  resource_id <- part[[4]]
  extract_all <- list()
  extractor_function <- function(resource_id) {
    info <-
      request_dtr(paste0(orkg_hostname, "/api/templates/", resource_id))
    dt_name <- format_string(info$label)
    dt_id <- info$id
    dt_class <- info$target_class$id
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
    for (prop in info$properties) {
      specific_prop <- list()
      specific_prop[["dtp_name"]] <- format_string(prop$path$label)
      specific_prop[["dtp_id"]] <- prop$path$id
      specific_prop[["dtp_card_min"]] <- prop$min_count
      specific_prop[["dtp_card_max"]] <- prop$max_count
      if (is.null(specific_prop[["dtp_card_max"]])) {
        specific_prop[["dtp_card_max"]] <- NA
      }
      if (is.null(prop$class$id)) {
        if (is.null(prop$datatype$id)) {
          specific_prop[["dtp_value_type"]] <- ""
        } else {
          specific_prop[["dtp_value_type"]] <- prop$datatype$id
        }
      } else {
        specific_prop[["dtp_value_type"]] <- prop$class$id
        info_n <-
          request_dtr(paste0(
            orkg_hostname,
            "/api/templates/?target_class=",
            prop$class$id
          ))
        if (length(info_n$content) > 0) {
          nested_id <- info_n$content[[1]]$id
          nested_name <- info_n$content[[1]]$label
          if (!nested_name %in% names(extract_all)) {
            extractor_function(nested_id)
          }
        }
      }
      i <- i + 1
      all_props[i, ] <- specific_prop
    }
    label_prop <- list(
      "dtp_name" = "label",
      "dtp_id" = "label",
      "dtp_card_min" = 0,
      "dtp_card_max" = 1,
      "dtp_value_type" = "string"
    )
    all_props <- rbind(all_props, label_prop)
    extracted <- list(schema_df, all_props)
    extract_all[[dt_name]] <<- extracted
  }
  extractor_function(resource_id)
  return(extract_all)
}
