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
                             get_template = function(template_doi) {
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
    #' @field template The template in a DTR
    template = NULL,
    #' @description
    #' Create a new ePIC object
    #' @param template a template
    #' @return New template
    initialize = function(template = NA) {
      self$template <- template
    },
    #' @description
    #' Write information from an ePIC template
    #' @param template_doi The DOI of an ePIC template
    #' @return Extracted information from an ePIC template
    get_template = function(template_doi) {
      self$template <- extract_epic(template_doi)
    }
  )
)

#' Title
#'
#' @param template_doi The DOI of a DTR template
#' @return An R6 class for the specific DTR
#'
select_dtr <- function(template_doi){
  part <- strsplit(template_doi, split = "[/ //]+")
  if(part[[1]][[3]] == "21.T11969"){
    datypreg <- Epic$new()
  }
  return(datypreg)
}
