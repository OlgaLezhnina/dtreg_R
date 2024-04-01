.onLoad <- function(libname, pkgname) {
  the$template_1 <-
    jsonlite::fromJSON(system.file("extdata", "pidinst_instrumentidentifier.json", package = "dtreg"))
}
