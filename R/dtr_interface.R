DataTypeReg <- R6::R6Class("DataTypeReg",
                           public = list(
                             get_template = function(template_id) {

                             }
                           ))

Epic <- R6::R6Class(
  "Epic",
  inherit = DataTypeReg,
  public = list(
    template = NULL,
    initialize = function(template = NA) {
      self$template <- template
    },
    get_template = function(template_id) {
      self$template = extractor_epic(template_id)
    }
  )
)
