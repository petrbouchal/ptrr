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


#' Render README.Rmd for Github
#'
#' Useful when inside a Markdown website. Wrapper around `rmarkdown::render`.
#'
#' @param path path to file. Default is "README.Rmd"
#' @param output_format output format passed to `rmarkdown::render`. Defaults to "github_document".
#' @param output_file output format passed to `rmarkdown::render`. Defaults to "{filename}.md".
#' @param ... Passed to `rmarkdown::render()`
#'
#' @return RETURN_DESCRIPTION
#' @export
#' @examples
#' # ADD_EXAMPLES_HERE
render_readme <- function(path = "README.Rmd", output_format = "github_document", output_file = NULL, ...) {
  if(is.null(output_file)) output_file <- gsub("\\.Rmd$", ".md", path)
  rmarkdown::render(path, output_format, output_file, ...)
}


#' Produce Github URL
#'
#' Useful for pointing to files on Github that live in a local clone of a repo
#'
#' @param path path to file (the bit that goes after /tree/{branch},
#' so presumably the local path from project root)
#' @param repo repo name; used if `remote` is not provided.
#' @param user Github user; used if `remote` is not provided. Defaults to `"petrbouchal"`
#' @param remote remote in the form of user/repo.
#' @param branch branch. Default `"main"`
#'
#' @export
#' @return character vector of same length as inputs
#'
#' Inputs are recycled if not all of the same length
#'
gh_url <- function(path, repo, user = "petrbouchal", remote = NULL, branch = "main") {
  if(is.null(remote)) rmt <- paste0(user, "/", repo)
  paste("https://github.com", rmt, "tree", branch, path, sep = "/")
}


#' Produce Github link in Markdown
#'
#' Useful for linking to files on Github that live in a local clone of a repo
#'
#' @param text Link text
#' @inheritParams gh_url
#'
#' @export
#' @return character vector of same length as inputs
#'
#' Inputs are recycled if not all of the same length

gh_link <- function(text = NULL, path, repo, user = "petrbouchal", remote = NULL, branch = "main") {
  url <- gh_url(path, repo, user, remote, branch)
  if(is.null(text)) text <- url

  paste0("[", text, "](", url, ")")

}

