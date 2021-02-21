#' @export
pandoc_quotes <- function() {
  rmarkdown::pandoc_lua_filter_args(rmarkdown::pkg_file_lua('pandoc-quotes.lua', 'ptrr'))
}
