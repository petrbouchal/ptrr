# Helper functions from bookdown and rticles -----------------------------------
# copied from https://github.com/atlas-aai/ratlas/

find_file <- function(template, file) {
  template <- system.file("rmarkdown", "templates", template, file,
                          package = "ptrr")
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }

  template
}

find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

ptrr_file <- function(...) {
  system.file(..., package = "ptrr", mustWork = TRUE)
}

copy_word_template <- function(template = "ptrr_word", destination = NULL) {
  dest <- ifelse(is.null(destination), getwd(), file.path(getwd(), destination))
  res <- find_resource(template, "template.docx")

  file.copy(res, dest)

  rslt <- ifelse(utils::file_test("-f", dest),
                 file.path(dest),
                 file.path(dest, basename(res))
  )
  return(rslt)
}
