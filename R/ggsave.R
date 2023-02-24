#' Save plot for Twitter
#'
#' Save at the right dimensions at 300 dpi
#'
#' @inheritParams ggplot2::ggsave
#'
#' @return filename, quietly
#' @export
ggsave_twitter <- function(filename,
                           plot = ggplot2::last_plot(),
                           device = ragg::agg_png,
                           path = NULL,
                           scale = 3,
                           width = 1200,
                           height = 675,
                           units = "px",
                           dpi = 300,
                           limitsize = FALSE,
                           bg = "white",
                           ...) {
  ggplot2::ggsave(filename = filename, plot = plot, path = path, bg = bg, scale = scale, dpi = dpi, device = device,
                  width = width, height = height, limitsize = limitsize, units = units, ...)
}

#' Save plot for Facebook
#'
#' Save at the right dimensions at 300 dpi
#'
#' @inheritParams ggplot2::ggsave
#'
#' @return filename, quietly
#' @export
ggsave_facebook <- function(filename,
                            plot = ggplot2::last_plot(),
                            device = NULL,
                            path = NULL,
                            scale = 3,
                            width = 1200,
                            height = 630,
                            units = "px",
                            dpi = 300,
                            limitsize = FALSE,
                            bg = "white",
                            ...) {
  ggplot2::ggsave(filename = filename, plot = plot, path = path, bg = bg, scale = scale, dpi = dpi, device = device,
                  width = width, height = height, limitsize = limitsize, units = units, ...)
}
