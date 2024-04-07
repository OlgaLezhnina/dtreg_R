.onLoad <- function(libname, pkgname) {
  the$template_1 <-
    jsonlite::fromJSON(system.file("extdata", "empty_schema.json", package = "dtreg"))
  the$template_2 <-
    jsonlite::fromJSON(system.file("extdata", "stat_test_diff.json", package = "dtreg"))
  the$static_all <- list(the$template_1, the$template_2)
}
