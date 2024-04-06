.onLoad <- function(libname, pkgname) {
  the$template_1 <-
    jsonlite::fromJSON(system.file("extdata", "pidinst_instrumentidentifier.json", package = "dtreg"))
  the$template_2 <-
    jsonlite::fromJSON(system.file("extdata", "pidinst_instrumenttype.json", package = "dtreg"))
  static_all <- list(the$template_1, the$template_2)
}
