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
      if (static == "none") {
        self$template_info <- extract_epic(template_doi)
      } else {
        self$template_info <- static
      }
      return(self$template_info)
    }
  )
)

#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return An R6 class for the specific DTR
#'
select_dtr <- function(template_doi) {
  part <- strsplit(template_doi, split = "[/ //]+")
  if (part[[1]][[3]] == "21.T11969") {
    datypreg <- Epic$new()
  }
  return(datypreg)
}
