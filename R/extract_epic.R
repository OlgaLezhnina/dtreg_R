#' Title
#'
#' @param epic_id The identifier of an ePIC object
#' @return Boolean, whether the file is in the extdata
#'
check_static <- function(epic_id)
{
  id_1 <- strsplit(epic_id, split = "/")[[1]][1]
  name <- paste(id_1, ".json", sep = "")
  all_static <-
    system.file("extdata", package = "dtreg") |> list.files()
  checked <- name %in% all_static
  return(checked)
}
