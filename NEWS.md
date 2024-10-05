# ptrr (development version)

# ptrr 0.2.2

## New features and impromvements

* new `inverse` param in `theme_ptrr()` to create plot with light background and white panels
* `ggsave_*` functions for Twitter and Facebook images
* new functions to work with colour palettess:
  - `tabulate_palette()` to turn a list of palettes into a data frame for easy export, with colour codes and names
  - `vis_palette()` to visualise a list of palettes, showing their names, colour names and colour codes.

## Updates and fixes

* axis_titles now takes a character, one of "both", "none", "x" or "y" in addition TRUE and FALSE (which work like "both" and "none", respectively)
* switch to `{marquee}` for rich text labeling

# ptrr 0.2.1

* add excel() function for viewing data in Excel
* update lua filter to latest at https://github.com/pandoc/lua-filters/blob/master/pandoc-quotes.lua/pandoc-quotes.lua
* removed font functions relying on {extrafont}
* removed drat/rhub functions
* new templates: site, repo docs pages, xaringan slides
* switch default font to IBM Plex Sans
* light tone colour is now parameterised in theme
* fixed logic in ptrr_word() to allow overrding docx template
* incorporated quotes Lua filter into package and Rmd template and helper function
* use non-breaking space in number formats
* initial basic support for using IBM Plex Sans via systemfonts
* `theme_ptrr()` now has a `map` argument
* new utilities for building Github URLs and links and rendering README.Rmd

# ptrr 0.2.0

* new basic Rmarkdown template
* new date formatting functions
* new ggplot2 utilities: themes, axes
* new number formatters
* new font utilities
* new function to set geom defaults

# ptrr 0.1.0

* completed `insert_package_into_drat()`

# ptrr 0.0.0.9000

* added `theme_ipr()`
* Added a `NEWS.md` file to track changes to the package.
