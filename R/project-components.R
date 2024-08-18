
#' FUNCTION_TITLE
#'
#' FUNCTION_DESCRIPTION
#'
#' @param file DESCRIPTION.
#' @param template DESCRIPTION.
#' @param package  DESCRIPTION.
#' @param edit DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # ADD_EXAMPLES_HERE
use_ptrr_docs <- function(file = "docs", template = "docs", package = "ptrr", edit = FALSE) {
  rmarkdown::draft(file = "docs",
                   template = "docs",
                   package = "ptrr",
                   edit = F)
  fs::file_move("docs/docs.Rmd", "docs/index.Rmd")
  fs::file_create("docs/.nojekyll")
}


#' FUNCTION_TITLE
#'
#' FUNCTION_DESCRIPTION
#'
#' @param path DESCRIPTION.
#' @param ghactions DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # ADD_EXAMPLES_HERE
use_ptrr_site <- function(path = ".", ghactions = TRUE) {
  rmarkdown::draft(file = "index",
                   template = "website",
                   package = "ptrr",
                   edit = F)

  if (ghactions) {
    wflw_dir <- fs::dir_create(".github/workflows", recurse = T)
    wflw_path <- system.file("website", "website.yml", package = "ptrr")
    fs::file_copy(wflw_path, file.path(wflw_dir, "website.yml"))
  }
}


#' FUNCTION_TITLE
#'
#' FUNCTION_DESCRIPTION
#'
#' @param path DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # ADD_EXAMPLES_HERE
use_ptrr_slides <- function(path = "docs") {
  fs::dir_create(path, recurse = T)
  rmarkdown::draft(file = "slides",
                   template = "slides",
                   package = "ptrr",
                   edit = F)
  fs::file_move(file.path(path, "slides/slides.Rmd"),
                file.path(path, "slides/index.Rmd"))
}
