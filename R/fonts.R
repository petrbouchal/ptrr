#' Make ggplot2 use chosen font in geom_text/label
#'
#' Wrapper around update_geom_font_defaults(), different default
#'
#' @param font font, defaults to `"IBM Plex Sans"`
#' @param fontface face, defaults to `"plain"`
#' @param size size, defaults to 3.5
#' @param lineheight lineheight, defaults to 0.95
#' @param color color, defaults to "black"
#' @family Font helpers and shortcuts
#' @export
#'
set_ptrr_ggplot_fonts <- function(family = "IBM Plex Sans Condensed",
                                  fontface = "plain", size = 3.5, color = "black",
                                  lineheight = .95) {

  update_geom_defaults("text", list(family = family, fontface = fontface,
                                    lineheight = lineheight,
                                    size = size, color = color))
  update_geom_defaults("label", list(family = family, fontface = fontface,
                                     lineheight = lineheight,
                                     size = size, color = color))

}
