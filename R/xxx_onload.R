.onLoad <- function(libname, pkgname) {
  templates <-
    jsonlite::fromJSON(system.file("extdata", "templates.json", package = "dtreg"))
}
