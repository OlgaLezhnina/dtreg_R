.onLoad <- function(libname, pkgname) {
  templates <-
    jsonlite::fromJSON(system.file("extdata", "21.T11969.f9bdfd1810b999e3b11e.json", package = "dtreg"))
}
