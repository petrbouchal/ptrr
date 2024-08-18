
#' @rdname Colours
#' @md
#' @description Normal theme blue in hex
#' @family Theme colours
#' @export
ptclr_n <- "#0000ff"

#' @rdname Colours
#' @md
#' @description Dark theme blue in hex
#' @family Theme colours
#' @export
ptclr_d <- "#00008b"

#' Colours
#' @rdname Colours
#' @aliases Colours
#' @md
#' @description Light theme blue in hex
#' @family Theme colours
#' @export
ptclr_l <- "#e3f1ff"

#' A custom ggplot2 theme
#'
#' A wrapper around `theme()` which provides several shortcuts to setting common options
#' and several defaults. See more in Details.
#'
#' In particular, the theme:
#' - displays only major gridlines, allowing you to quickly switch which ones; gridlines are thinner, panel has white background
#' - provides quick option to draw a scatter with grey background
#' - switches defaults for title alignment
#' - turns axis labels off by default: in practice, x axes are often obvious and
#' y axes are better documented in a subtitle
#' - sets backgrounds to a ptrr-style shade
#' - sets plot title in bold and 120% of base_size
#'
#' All the changed defaults can be overriden by another call to `theme()`.
#'
#' @note The default fonts - IBM Plex Sans and IBM Plex Sans Condensed - are contained in this package and
#' can be registered with the system using `import_fonts()`. You should then install them onto your
#' system like any font, using files in the directories described in the `import_fonts()` messsage.
#' You can also set the  `ptrr.loadfonts` option to TRUE for the fonts
#' to be registered at package load.
#'
#' @param base_size Numeric text size in pts, affects all text in plot. Defaults to 11.
#' @param gridlines Whether to display major gridlines along `"y"` (the default),
#' `"x"`, `"both"`, or draw a `"scatter"`, which has both gridlines and inverted colours.
#' @param family,title_family font family to use for the (title of the) plot. Defaults to `"IBM Plex Sans"` for title and `"IBM Plex Sans Condensed"` for plot.
#' @param margin_side,margin_bottom size of left and right / bottom margin around plot, in pts. Defaults to 6. Set to 0 to align flush with text in a Word document.
#' @param plot.title.position where to align the title. Either "plot" (the default, difference from `theme()` default) or `"panel"`.
#' @param axis_titles whether to display axis titles: `"none"` (default), `"x"`, `"y"`, or `"both"`.
#' @param multiplot if set to TRUE, provides better styling for small multiples created using `facet_*`.
#' @param map if set to TRUE, provides better styling for maps created using `geom_sf()`. Overrides `gridlines`.
#' @inheritDotParams ggplot2::theme -text -plot.title -panel.grid.minor
#'   -panel.grid.major.x -panel.grid.major.y -panel.background -axis.title
#'   -strip.text.x -plot.margin -strip.background
#'
#' @return a ggtheme object
#' @family Making charts
#' @examples
#' library(ggplot2)
#'
#' # NB when `theme_ptrr()` is used in these examples, fonts
#' # are set to 'sans' to pass checks on computers without the
#' # sans included. If you have these fonts (see Note) you can
#' # leave these parameters at their default values.
#'
#' # the basic plot for illustration, theme not used
#'
#' p <- ggplot(mpg) +
#'   geom_bar(aes(y = class)) +
#'   labs(title = "Lots of cars", subtitle = "Count of numbers")
#'
#' # using `theme_ptrr()` defaults
#'
#' p +
#'   theme_ptrr("x", family = "sans", title_family = "sans")
#'
#' # in combination with `flush_axis`:
#'
#' p +
#'   theme_ptrr("x", family = "sans", title_family = "sans") +
#'   scale_x_continuous(expand = flush_axis)
#'
#' # scatter
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_ptrr("scatter", family = "sans", title_family = "sans") +
#'   labs(title = "Lots of cars", subtitle = "Point by point")
#'
#' # Smaller text, flush alignment
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_ptrr("scatter", base_size = 9, margin_side = 0,
#'                 family = "sans", title_family = "sans") +
#'   labs(title = "Lots of cars", subtitle = "Point by point")
#'
#' # Override defaults changed inside `theme_ptrr()`
#'
#' ggplot(mpg) +
#'   geom_point(aes(cty, hwy)) +
#'   theme_ptrr("scatter", base_size = 9, margin_side = 0,
#'                family = "sans", title_family = "sans") +
#'   labs(title = "Lots of cars", subtitle = "Point by point") +
#'   theme(panel.background = element_rect(fill = "lightpink"))
#'
#' @export
theme_ptrr <- function(gridlines = c("y", "x", "both", "scatter", "none"),
                         base_size = 11,
                         family = "IBM Plex Sans Condensed",
                         title_family = "IBM Plex Sans",
                         multiplot = FALSE,
                         tonecol = ptclr_l,
                         margin_side = 6,
                         margin_bottom = 6,
                         plot.title.position = "plot",
                         axis_titles = c("none", "y", "x", "both"),
                         richtext = FALSE,
                         richtext_style = NULL,
                         map = FALSE,
                         inverse = FALSE,
                         ...) {

  if(richtext) {
    if(!requireNamespace("marquee")) stop("Package marquee needed.")
  }

  element_switch <- if (!richtext) {
    function(...) {
      funArgs <-  list(...)
      # remove style argument if not using richtext, dont pass it to element_text
      newArgs <- funArgs[is.na(match(names(funArgs), "style"))]
      do.call(ggplot2::element_text, newArgs)
    }
  }  else {
    function(...) {
      funArgs <-  list(...)
      do.call(marquee::element_marquee, funArgs)
    }
  }

  grd <- match.arg(gridlines)
  if(axis_titles == TRUE) axis_titles <- "both"
  if(axis_titles == FALSE) axis_titles <- "none"
  axttl <- match.arg(axis_titles)

  grid_col <- if(grd == "scatter" | multiplot) "white" else tonecol
  bg_col <- if(grd == "scatter" | multiplot) tonecol else "white"

  if(!inverse & grd != "scatter" & !multiplot) {
    plot_bg_col <- "white"
    bg_col <- tonecol
    grid_col <- "white"
  } else if (inverse & (grd == "scatter" | multiplot)) {
    plot_bg_col <- tonecol
    bg_col <- "white"
    grid_col <- tonecol
  } else if (inverse == TRUE) {
    plot_bg_col <- tonecol
    bg_col <- "white"
    grid_col <- tonecol
  } else if (!inverse == TRUE & grd == "scatter") {
    plot_bg_col <- "white"
    bg_col <- tonecol
    grid_col <- "white"
  } else {
    plot_bg_col <- "white"
    bg_col <- "white"
    grid_col <- tonecol
  }

  if(is.null(richtext_style)) {
    richtext_style <- marquee::classic_style() |>
      marquee::modify_style(tag = "body", lineheight = 1,
                            margin = marquee::trbl(0, 0, 0, 0))
  }

  plt_title <- if(richtext) {

    marquee::element_marquee(size = base_size * 1.2, family = title_family,
                             style = richtext_style |>
                               marquee::modify_style(tag = "body", weight = 700))
  } else {
    ggplot2::element_text(face = "bold", size = base_size * 1.2,
                          family = title_family)
  }

  element_gridline <- ggplot2::element_line(colour = grid_col, size = 0.3)
  thm <- ggplot2::theme_minimal(base_size = base_size, base_family = family) +
    ggplot2::theme(plot.title.position = plot.title.position,
                   plot.title = plt_title,
                   plot.subtitle = element_switch(),
                   plot.caption = element_switch(colour = "grey60"),
                   panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major.x = if(!grd %in% c("y", "none"))
                     element_gridline else ggplot2::element_blank(),
                   panel.grid.major.y = if(!grd %in% c("x", "none"))
                     element_gridline else ggplot2::element_blank(),
                   # axis.line = ggplot2::element_line(),
                   panel.background = ggplot2::element_rect(fill = bg_col,
                                                            colour = NA),
                   axis.title = if(axttl == "both" | axttl == TRUE) element_switch() else ggplot2::element_blank(),
                   axis.title.x = if(axttl == "both" | axttl == "x") element_switch() else ggplot2::element_blank(),
                   axis.title.y = if(axttl == "both" | axttl == "y") element_switch() else ggplot2::element_blank(),
                   strip.text.x = element_switch(hjust = 0, style = richtext_style),
                   strip.text.y = element_switch(hjust = 0, style = richtext_style),
                   plot.background = element_rect(fill = plot_bg_col, colour = NA),
                   axis.text.x = element_switch(style = richtext_style),
                   axis.text.y = element_switch(style = richtext_style),
                   plot.margin = ggplot2::unit(c(10, margin_side + 5,
                                                 margin_bottom, margin_side),
                                               units = "pt"))
  if(multiplot & !inverse) {thm <- thm +
    ggplot2::theme(strip.background = ggplot2::element_rect(fill = tonecol,
                                                            colour = NA))
  } else if(multiplot & inverse) {
    thm <- thm +
      ggplot2::theme(strip.background = ggplot2::element_rect(fill = "white",
                                                              colour = NA))
  }

  if(map) thm <- thm +
    ggplot2::theme(panel.grid.major = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_blank())

  thm <- thm +
    ggplot2::theme(...)

  return(thm)
}

#' A shorcut for making axis text flush with axis
#'
#' A shorcut for making axis text flush with axis
#'
#' @examples
#' library(ggplot2)
#' ggplot(mpg) +
#'   geom_bar(aes(y = class)) +
#'   scale_x_continuous(expand = flush_axis)
#' @family Making charts
#' @export
"flush_axis" <- ggplot2::expansion(mult = c(0, 0.05))


#' Set geom defaults for ptrr package/theme
#'
#' @param color color, defaults to "blue"
#'
#' @export
set_geom_defaults <- function(color = "blue") {
  ggplot2::update_geom_defaults(
    "point", list(fill = color, color = color, size = 1.5)
  )
  ggplot2::update_geom_defaults(
    "bar", list(fill = color, color = NA)
  )
  ggplot2::update_geom_defaults(
    "rect", list(fill = color, color = NA)
  )
  ggplot2::update_geom_defaults(
    "line", list(color = color, size = 1.5)
  )
}


