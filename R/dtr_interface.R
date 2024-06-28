dummy_r6 <- function() R6::R6Class
#' R6 Class Representing a Data Type Registry
#'
#' @description
#' Tba
#'
#' @details
#' Tba

DataTypeReg <- R6::R6Class("DataTypeReg",
                           public = list(
                             #' @description
                             #' The function used in any DTR to get a template
                             #' @param template_doi The DOI of a DTR template
                             #' @return Not implemented, this is an interface
                             get_template_info = function(template_doi) {
                               #' Not implemented, this is an interface
                             },
                             #' @description
                             #' The function to write context for JSON-LD
                             #' @param prefix The URL prefix
                             #' @return Not implemented, this is an interface
                             add_context = function(prefix) {
                               #' Not implemented, this is an interface
                             }
                           ))

#' R6 Class Representing the ePIC DTR
#'
#' @description
#' Tba
#'
#' @details
#' Tba
Epic <- R6::R6Class(
  "Epic",
  inherit = DataTypeReg,
  public = list(
    #' @field template_info An ePIC template information
    template_info = NULL,
    #' @description
    #' Create a new object with the template information
    #' @param template_info An ePIC template information
    #' @return A new object with the template information
    initialize = function(template_info = NA) {
      self$template_info <- template_info
    },
    #' @description
    #' Write information from an ePIC template
    #' @param template_doi The DOI of an ePIC template
    #' @return Extracted information from an ePIC template
    get_template_info = function(template_doi) {
      static <- from_static(template_doi)
      if (is.null(static)) {
        self$template_info <- extract_epic(template_doi)
      } else {
        self$template_info <- static
      }
      return(self$template_info)
    },
    #' @description
    #' Give ePIC-specific context for writing JSON-LD
    #' @param prefix The URL prefix
    #' @return Context to include in JSON-LD file
    add_context = function(prefix) {
      context_info <- list()
      context_info[["doi:"]] <- prefix
      return(context_info)
    }
  )
)

#' R6 Class Representing the ORKG DTR
#'
#' @description
#' Tba
#'
#' @details
#' Tba
Orkg <- R6::R6Class(
  "Orkg",
  inherit = DataTypeReg,
  public = list(
    #' @field template_info An ORKG template information
    template_info = NULL,
    #' @description
    #' Create a new object with the template information
    #' @param template_info An ORKG template information
    #' @return A new object with the template information
    initialize = function(template_info = NA) {
      self$template_info <- template_info
    },
    #' @description
    #' Write information from an ORKG template
    #' @param template_doi The URL of an ORKG template
    #' @return Extracted information from an ORKG template
    get_template_info = function(template_doi) {
      self$template_info <- extract_orkg(template_doi)
      return(self$template_info)
    },
    #' @description
    #' Give ORKG-specific context for writing JSON-LD
    #' @param prefix The URL prefix
    #' @return Context to include in JSON-LD file
    add_context = function(prefix) {
      context_info <- list()
      context_info[["orkgr:"]] <- paste0(prefix, "resource/")
      context_info[["orkgp:"]] <- paste0(prefix, "property/")
      return(context_info)
    }
  )
)


#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return An R6 class for the specific DTR
#'
select_dtr <- function(template_doi) {
  part <- strsplit(template_doi, split = "[/ //]+")[[1]]
  if (part[[3]] == "21.T11969") {
    datypreg <- Epic
  } else if (stringr::str_detect(part[[2]], "orkg.org")) {
    datypreg <- Orkg
  } else {
    stop("Please check whether the schema belongs to the ePIC or the ORKG dtr")
  }
  return(datypreg)
}
