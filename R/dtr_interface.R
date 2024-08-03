#' Select dtr
#' @description
#' Select a dtr-related class based on the identifier
#' @param datatype_id The identifier of a datatype, such as URL
#' @return An R6 class for the specific datatype registry
#' @keywords internal
#'
select_dtr <- function(datatype_id) {
  part <- strsplit(datatype_id, split = "[/ //]+")[[1]]
  if (part[[3]] == "21.T11969") {
    selected_class <- Epic
  } else if (stringr::str_detect(part[[2]], "orkg.org")) {
    selected_class <- Orkg
  } else {
    stop("Please check whether the schema belongs to the ePIC or the ORKG dtr")
  }
  return(selected_class)
}

#' A dummy function explicitly referring to R6 package to declare the dependency
#' @keywords internal
dummy_r6 <- function() R6::R6Class

#' DatatypReg
#' @description
#' Interface for R6 class representing a datatype registry
#' @keywords internal
#'
DataTypeReg <- R6::R6Class(
  "DataTypeReg",
  public = list(
    #' @description
    #' Obtain information from a datatype schema
    #' @param datatype_id The identifier of a datatype
    #' @return Not implemented, this is an interface
    get_schema_info = function(datatype_id) {
      #' Not implemented, this is an interface
    },
    #' @description
    #' Write dtr-specific context for JSON-LD
    #' @details
    #' The dtr-specific information is provided by the dtr
    #' @param prefix The URL prefix
    #' @return Not implemented, this is an interface
    add_context = function(prefix) {
      #' Not implemented, this is an interface
    },
    #' @description
    #' Write schema type for JSON-LD
    #' @param identifier The schema identifier
    #' @return Not implemented, this is an interface
    add_dt_type = function(identifier) {
      #' Not implemented, this is an interface
    },
    #' @description
    #' Write property type for JSON-LD
    #' @param identifier The property identifier
    #' @return Not implemented, this is an interface
    add_dtp_type = function(identifier) {
      #' Not implemented, this is an interface
    },
    #' @description
    #' Write dataframe constants for JSON-LD
    #' @return Not implemented, this is an interface
    add_df_constants = function() {
      #' Not implemented, this is an interface
    }
  )
)

#' Epic
#' @description
#' R6 Class Representing the ePIC DTR
#' @keywords internal
#'
Epic <- R6::R6Class(
  "Epic",
  inherit = DataTypeReg,
  public = list(
    #' @field schema_info An ePIC schema information
    schema_info = NULL,
    #' @description
    #' Create a new object with the schema information
    #' @param schema_info An ePIC schema information
    #' @return A new object with the ePIC schema information
    initialize = function(schema_info = NA) {
      self$schema_info <- schema_info
    },
    #' @description
    #' Obtain information from an ePIC schema
    #' @param datatype_id The identifier of a datatype
    #' @return Extracted information from an ePIC schema
    get_schema_info = function(datatype_id) {
      static <- from_static(datatype_id)
      if (is.null(static)) {
        self$schema_info <- extract_epic(datatype_id)
      } else {
        self$schema_info <- static
      }
      return(self$schema_info)
    },
    #' @description
    #' Write ePIC-specific context for JSON-LD
    #' @details
    #' The ePIC-specific information is provided by the dtr
    #' @param prefix The URL prefix
    #' @return Context to include in JSON-LD file
    add_context = function(prefix) {
      context_info <- list()
      context_info[["doi:"]] <- prefix
      context_info[["columns:"]] <-
        paste0(prefix, "0424f6e7026fa4bc2c4a#columns")
      context_info[["col_number:"]] <-
        paste0(prefix, "65ba00e95e60fb8971e6#number")
      context_info[["col_titles:"]] <-
        paste0(prefix, "65ba00e95e60fb8971e6#titles")
      context_info[["rows:"]] <-
        paste0(prefix, "0424f6e7026fa4bc2c4a#rows")
      context_info[["row_number:"]] <-
        paste0(prefix, "9bf7a8e8909bfd491b38#number")
      context_info[["row_titles:"]] <-
        paste0(prefix, "9bf7a8e8909bfd491b38#titles")
      context_info[["cells:"]] <-
        paste0(prefix, "9bf7a8e8909bfd491b38#cells")
      context_info[["column:"]] <-
        paste0(prefix, "4607bc7c42ac8db29bfc#column")
      context_info[["value:"]] <-
        paste0(prefix, "4607bc7c42ac8db29bfc#value")
      return(context_info)
    },
    #' @description
    #' Write ePIC-specific schema type for writing JSON-LD
    #' @param identifier The ePIC schema identifier
    #' @return Type to include in JSON-LD file
    add_dt_type = function(identifier) {
      dt_type <- paste0("doi:", identifier)
      return(dt_type)
    },
    #' @description
    #' Write ePIC-specific property type for writing JSON-LD
    #' @param identifier The ePIC property identifier
    #' @return Type to include in JSON-LD file
    add_dtp_type = function(identifier) {
      dtp_type <- paste0("doi:", identifier)
      return(dtp_type)
    },
    #' @description
    #' Write ePIC-specific dataframe constants for writing JSON-LD
    #' @return Dataframe constants to include in JSON-LD file
    add_df_constants = function() {
      df_constants <- list()
      df_constants[["table"]] <- "doi:0424f6e7026fa4bc2c4a"
      df_constants[["column"]] <- "doi:65ba00e95e60fb8971e6"
      df_constants[["row"]] <- "doi:9bf7a8e8909bfd491b38"
      df_constants[["cell"]] <- "doi:4607bc7c42ac8db29bfc"
      return(df_constants)
    }
  )
)

#' ORKG
#' @description
#' R6 Class Representing the ORKG DTR
#' @keywords internal
#'
Orkg <- R6::R6Class(
  "Orkg",
  inherit = DataTypeReg,
  public = list(
    #' @field schema_info An ORKG template information
    schema_info = NULL,
    #' @description
    #' Create a new object with the schema information
    #' @param schema_info An ORKG template information
    #' @return A new object with the ORKG template information
    initialize = function(schema_info = NA) {
      self$schema_info <- schema_info
    },
    #' @description
    #' Obtain information from an ORKG template
    #' @param datatype_id The identifier of an ORKG template
    #' @return Extracted information from an ORKG template
    get_schema_info = function(datatype_id) {
      self$schema_info <- extract_orkg(datatype_id)
      return(self$schema_info)
    },
    #' @description
    #' Write ORKG-specific context for JSON-LD
    #' @details
    #' The ORKG-specific information is provided by the dtr
    #' @param prefix The URL prefix
    #' @return Context to include in JSON-LD file
    add_context = function(prefix) {
      context_info <- list()
      context_info[["orkgc:"]] <- paste0(prefix, "class/")
      context_info[["orkgr:"]] <- paste0(prefix, "resource/")
      context_info[["orkgp:"]] <- paste0(prefix, "property/")
      context_info[["columns:"]] <- paste0(prefix, "property/", "CSVW_Columns")
      context_info[["col_number:"]] <-
        paste0(prefix, "property/", "CSVW_Number")
      context_info[["col_titles:"]] <-
        paste0(prefix, "property/", "CSVW_Titles")
      context_info[["rows:"]] <- paste0(prefix, "property/", "CSVW_Rows")
      context_info[["row_number:"]] <-
        paste0(prefix, "property/", "CSVW_Number")
      context_info[["row_titles:"]] <-
        paste0(prefix, "property/", "CSVW_Titles")
      context_info[["cells:"]] <- paste0(prefix, "property/", "CSVW_Cells")
      context_info[["column:"]] <- paste0(prefix, "property/", "CSVW_Column")
      context_info[["value:"]] <- paste0(prefix, "property/", "CSVW_Value")
      context_info[["label"]] <- "http://www.w3.org/2000/01/rdf-schema#label"
      return(context_info)
    },
    #' @description
    #' Write ORKG-specific template type for writing JSON-LD
    #' @param identifier The ORKG template identifier
    #' @return Type to include in JSON-LD file
    add_dt_type = function(identifier) {
      dt_type <- paste0("orkgr:", identifier)
      return(dt_type)
    },
    #' @description
    #' Write ORKG-specific property type for writing JSON-LD
    #' @param identifier The ORKG property identifier
    #' @return Type to include in JSON-LD file
    add_dtp_type = function(identifier) {
      dtp_type <- paste0("orkgp:", identifier)
      return(dtp_type)
    },
    #' @description
    #' Write ORKG-specific dataframe constants for writing JSON-LD
    #' @return Constants to include in JSON-LD file
    add_df_constants = function() {
      df_constants <- list()
      df_constants[["table"]] <- "orkgc:Table"
      df_constants[["column"]] <- "orkgc:Column"
      df_constants[["row"]] <- "orkgc:Row"
      df_constants[["cell"]] <- "orkgc:Cell"
      return(df_constants)
    }
  )
)
