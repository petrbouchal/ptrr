


#' IPR theme for ggplot2
#'
#' Returns an IPR-style theme for adding to a ggplot2. See Details for font-specific instructions.
#'
#' In its default setting, it requires the Unit Pro and Unit Slab Pro fonts to
#' be present. As these are OTF files, they are automatically loaded using the
#' sysfonts package, assuming the files UnitPro[-Bold].otf and UnitSlabPro[-Bold].otf
#' exist in the usual font locations.
#'
#' The font is not rendered correctly in the RStudio graphics device, but works in
#' RMarkdown notebooks and PDFs. To make it work with knitr, add `fig.showtext=TRUE`
#' to your chunk options or
#' to your setup chunk using `knitr::opts_knit$set(fig.showtext=TRUE)`.
#' Call `showtext_auto()` before calling your ggplot2 object.
#'
#' Note that this only applies to HTML output. For Word output, a template is
#' needed and for PDF output much fiddling with TeX is needed. Single PDF images are fine.
#'
#'
#' @param grid character: which major gridlines to display. "x", "y" or "both". Defaults to "both".
#' @param richtext whether to render markdown/HTML using the `ggtext` package. Defaults to FALSE.
#' @param axis_titles whether to display axis titles. Defaults to FALSE.
#' @param scatter If TRUE, will add panel background and inverse x and y gridlines. Defaults to FALSE.
#' @param base_size base font size. Defaults to 12.
#' @param family Font family to use throughout the theme. Defaults to "Unit Pro".
#' @param title_family Font family to use in the title. Defaults to "Unit Slab Pro".
#' @param side_margin Size of left and right margin in pts.
#'
#' @return A ggplot2 theme object, an object of class theme and gg.
#' @export
#' @examples
#' # ADD_EXAMPLES_HERE
theme_ipr <- function(grid = "both", richtext = F, axis_titles = F, scatter = F,
                      base_size = 12, family = "Unit Pro", title_family = "Unit Slab Pro", side_margin = 5.5) {

  if(richtext) {
    if(!requireNamespace("ggtext")) stop("Package ggtext needed.")
  }

  element_switch <- if(richtext) ggtext::element_markdown else ggplot2::element_text
  x <- ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(text = element_switch(size = base_size, family = family),
          strip.text = element_switch(hjust = 0, family = family),
          axis.text.y =    element_switch(),
          axis.text.x =    element_switch(),
          axis.title =     if(axis_titles) element_switch() else ggplot2::element_blank(),
          axis.ticks =     ggplot2::element_blank(),
          plot.title =     element_switch(family = title_family, size = base_size + 2, face = "bold"),
          plot.subtitle  = element_switch(family = title_family, size = base_size + 1),
          plot.caption =   element_switch(family = family, size = base_size - 4, colour = "darkgrey"),
          panel.grid.minor = ggplot2::element_blank(),
          plot.margin = ggplot2::unit(c(5.5, side_margin, 5.5, side_margin), "pt"),
          plot.title.position = "plot",
    ) +
    if(grid == "both") {ggplot2::theme()} else if(grid == "x") {
      ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
    } else if(grid == "y") {
      ggplot2::theme(panel.grid.major.x = ggplot2::element_blank())
    } else if(grid == "none") {
      ggplot2::theme(panel.grid.major = ggplot2::element_blank())
    } else stop("Invalid grid spec")
  x <- if(scatter) x + ggplot2::theme(panel.background = ggplot2::element_rect(fill = "grey92", colour = NA),
                             panel.grid = ggplot2::element_line(colour = "white")) else x
}
