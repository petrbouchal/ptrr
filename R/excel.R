
# https://twitter.com/brodriguesco/status/1447468259725434886?ref_src=twsrc%5Etfw

#' View a data frame in Excel
#'
#' View a data frame in Excel
#'
#' @param .data data
#'
#' @return NULL, quietly
#' @export
excel <- function(.data) {

  tmp <- tempfile(fileext = ".csv")

  write.csv2(.data, tmp, row.names = TRUE)

  browseURL(url = tmp)
}
