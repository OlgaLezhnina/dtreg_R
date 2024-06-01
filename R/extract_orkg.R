#' Title
#'
#' @param dt_id The URL of an ORKG template
#' @return An R object that contains information about the ORKG template
#'
extract_orkg <- function(dt_id) {
  extract_all <- list()
  extractor_function <- function(dt_id) {
    part <- strsplit(dt_id, split = "[/ //]+")[[1]]
    orkg_prefix <-
      paste0(part[[1]], "/", part[[2]], "//api/templates/")
    info <- request_dtr(paste0(orkg_prefix, part[[4]]))
    dt_name <- info$label
    dt_id <- info$id
    dt_class <- info$target_class$id
    schema_df <- data.frame(dt_name, dt_id, dt_class)
    i <- 0
    all_props <- data.frame(
      dtp_name = character(),
      dtp_id = character(),
      dtp_cardinality = character(),
      dtp_value_type = character(),
      stringsAsFactors = FALSE
    )
    for (prop in info$properties) {
      specific_prop <- list()
      specific_prop[["dtp_name"]] <- prop$path$label
      specific_prop[["dtp_id"]] <- prop$path$id
      specific_prop[["dtp_card_min"]] <- prop$min_count
      specific_prop[["dtp_card_max"]] <- prop$max_count
      if (is.null(prop$class$id)) {
        specific_prop[["dtp_value_type"]] <- prop$datatype$id
      } else {
        specific_prop[["dtp_value_type"]] <- prop$class$id
        info_n <-
          request_dtr(paste0(orkg_prefix, "?target_class=", prop$class$id))
        if (length(info_n$content) > 0) {
          nested_id <- info_n$content[[1]]$id
          nested_name <- info_n$content[[1]]$label
          if (!nested_name %in% names(extract_all)) {
            extractor_function(nested_id)
          }
        }
        i <- i + 1
        all_props[i, ] <- specific_prop
      }
    }
    extracted <- list(schema_df, all_props)
    extract_all[[dt_name]] <<- extracted
    return(extract_all)
  }
  extractor_function(dt_id)
  return(extract_all)
}
