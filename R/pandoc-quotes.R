
#' Insert Pandoc argument into YAML to use quotes filter
#'
#' To be used as the `pandoc_args` YAML param in Rmd documents. Configure by setting the `lang` YAML param ("en"/"cs") in top-level YAML
#'
#' See [LUA filter manual](https://github.com/pandoc/lua-filters/blob/master/pandoc-quotes.lua/man/pandoc-quotes.lua.md) for more granular settings.
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # output:
#' #   html_document:
#' #     pandoc_args: !expr ptrr::pandoc_quotes()
#' @export
pandoc_quotes <- function() {
  rmarkdown::pandoc_lua_filter_args(rmarkdown::pkg_file_lua('pandoc-quotes.lua', 'ptrr'))
}
