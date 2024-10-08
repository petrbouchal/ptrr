#' Basic ptrr word document
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard ptrr word document formatting. By default,
#' it uses the Word template built into the package as the `reference_docx`
#' YAML option
#' @param reference_docx Reference docx file to use, defaults to file included in package.
#' @param number_sections Whether to number sections, defaults to FALSE.
#' @param ... Arguments to be passed to `[bookdown::word_document2]`
#'
#' @return A modified `word_document2` with the standard ptrr formatting.
#' @family Report templates and formats
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ptrr::ptrr_word
#' }
ptrr_word <- function(reference_docx = find_resource("ptrr_word", "template.docx"),
                      number_sections = FALSE,
                      ...) {
  base <- bookdown::word_document2(reference_docx = reference_docx,
                                   number_sections = number_sections,
                                   ...)
  base$pandoc$lua_filters <- c(
    rmarkdown::pkg_file_lua("pandoc-quotes.lua", package = "ptrr"),
    base$pandoc$lua_filters)

  # nolint start
  base$knitr$opts_chunk$comment <- ""
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 6.29 # 15.98 cm i.e. 2 x 2.5 cm margins
  base$knitr$opts_chunk$dpi <- 300
  # base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.asp <- .618 # default height is in golden ratio
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.path <- "figures/"
  # nolint end

  base
}
