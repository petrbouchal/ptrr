#' Tabulate Palette
#'
#' This function takes a list of color palettes and returns a data frame with detailed information about each color.
#'
#' @param palette_list A list of color palettes. Each element of the list should be a character vector of color names or hex codes.
#'
#' @return A data frame with columns for RGB values, color names, hex codes, and palette identifiers.
#' @export
#'
#' @examples
#' palette_list <- list(
#'   palette1 = c("red", "green", "blue"),
#'   palette2 = c("#FF0000", "#00FF00", "#0000FF")
#' )
#' tabulate_palette(palette_list)
tabulate_palette <- function(palette_list) {
  pals_df <- purrr::imap_dfr(palette_list, \(x, y) {
    rgbx <- purrr::map(x, \(x) grDevices::col2rgb(x))
    hex <- purrr::map(rgbx, \(x) rgb(x[[1]]/255, x[[2]]/255, x[[3]]/255))
    rgb_text <- purrr::map_chr(rgbx, \(x) paste0("rgb(", x[[1]], ", ", x[[2]],  ", ", x[[3]], ")"))

    tibble::tibble(
      rgb = rgb_text,
      color = x,
      name = if (!is.null(names(x))) names(x) else rep("", length(x)),
      code = x,
      hex = hex
    ) |> dplyr::mutate(x = as.factor(dplyr::row_number()), y = y)
  })
  return(pals_df)
}


#' Visualize Color Palettes
#'
#' This function takes a list of color palettes and visualizes them using `ggplot2`.
#'
#' The colour palettes inside the list can be named, as can be the individual colours.
#' The names are then displayed in the swatch plot.
#'
#' @param palette_list A (named) list of color palettes. Each element of the list should be a vector of color codes, optionally with names.
#' @return A `ggplot` object visualizing the color palettes.
#' @importFrom ggplot2 ggplot aes geom_tile geom_text scale_fill_identity theme_minimal theme element_blank after_scale
#' @importFrom dplyr mutate row_number
#' @importFrom purrr imap_dfr
#' @importFrom tibble tibble
#' @export
#' @examples
#' palettes <- list(
#'   palette1 = c(moc = "#FF0000", trochu = "#00FF00", malo = "#0000FF"),
#'   palette2 = c("#FFFF00", "#FF00FF", "#00FFFF")
#' )
#' vis_palette(palettes)
vis_palette <- function(palette_list) {

  pals_df <- tabulate_palette(palette_list)

  pals_plt <- ggplot(pals_df, aes(x = x, y = y, fill = code)) +
    geom_tile(colour = "white", linewidth = 2) +
    geom_text(aes(label = paste0(name, "\n", code, "\n", rgb, "\n", hex),
                  colour = after_scale(contrast(fill)))) +
    scale_fill_identity() +
    theme_minimal(base_line_size = 0) +
    theme(axis.title = element_blank(), axis.text.x = element_blank())
  return(pals_plt)
}

#' Contrast Colour Selector
#'
#' This function determines the appropriate contrast colour (either dark or light) for a given set of colours.
#'
#' @param colour A character vector of colour names or hex codes.
#' @param dark A character string specifying the colour to use for dark contrast (default is "black").
#' @param light A character string specifying the colour to use for light contrast (default is "white").
#'
#' @return A character vector of the same length as `colour`, containing the contrast colours (either `dark` or `light`).
#' @export
#'
#' @examples
#' contrast(c("grey20", "grey80"))
#' contrast(c("#000000", "#FFFFFF"), dark = "navy", light = "yellow")
contrast <- function(colour, dark = "black", light = "white") {
  out   <- rep(dark, length(colour))
  lightx <- farver::get_channel(colour, "l", space = "hcl")
  out[lightx < 50] <- light
  out
}
