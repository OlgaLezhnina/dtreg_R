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
                             #' @param template_id The identifier of a template
                             #' @return Not implemented, this is an interface
                             get_template = function(template_id) {
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
    #' @param template_id The identifier of an ePIC template
    #' @return Extracted information from an ePIC template
    get_template = function(template_id) {
      self$template <- extract_epic(template_id)
    }
  )
)
