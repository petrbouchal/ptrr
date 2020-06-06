#' Basic Schola Empirica word document
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard Schola word document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::word_document2]`
#'
#' @return A modified `word_document2` with the standard Schola formatting.
#' @family Report templates and formats
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ptrr::ptrr_word
#' }
ptrr_word <- function(...) {
  template <- find_resource("ptrr_word", "template.docx")
  base <- bookdown::word_document2(reference_docx = template, ...)

  pandoc_quotes_arg <- paste0("--lua-filter=",
                              ptrr_file("pandoc-quotes.lua"))
  base <- bookdown::word_document2(pandoc_args = pandoc_quotes_arg, ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
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
