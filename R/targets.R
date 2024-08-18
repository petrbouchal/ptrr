use_tar_interactive <- function(variables) {
  usethis::use_template("_interactive.R", package = "ptrr")
}

use_targets_deps <- function(cran = TRUE) {
  if (cran) {
     utils::install.packages("targets",
                      dependencies = TRUE)
  }  else {
    if(!require("remotes")) stop("Needs remotes package")
    remotes::install_github("ropensci/targets",
                            dependencies = TRUE)
  }
}
