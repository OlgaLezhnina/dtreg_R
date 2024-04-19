.onLoad <- function(libname, pkgname) {
  file_names <-
    system.file("extdata", package = "dtreg") |> list.files()
  the$static_all <- list()
  for (name in file_names) {
    the$static <-
      list(jsonlite::fromJSON(system.file("extdata", name, package = "dtreg")))
    the$static_all[name] <- the$static
  }
}
