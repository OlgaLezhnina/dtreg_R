.onLoad <- function(libname, pkgname) {
  the$onloaded_all <-
    system.file("extdata", package = "dtreg") |> list.files()
  the$static_all <- list()
  for (file in the$loaded_all) {
    the$static_all[file] <- jsonlite::fromJSON(file)
  }
}
