% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fonts.R
\name{set_ptrr_ggplot_fonts}
\alias{set_ptrr_ggplot_fonts}
\title{Make ggplot2 use chosen font in geom_text/label}
\usage{
set_ptrr_ggplot_fonts(
  family = "IBM Plex Sans Condensed",
  fontface = "plain",
  size = 3.5,
  color = "black",
  lineheight = 0.95
)
}
\arguments{
\item{family}{font, defaults to `"IBM Plex Sans"`}

\item{fontface}{face, defaults to `"plain"`}

\item{size}{size, defaults to 3.5}

\item{color}{color, defaults to "black"}

\item{lineheight}{lineheight, defaults to 0.95}
}
\description{
Wrapper around update_geom_font_defaults(), different default
}
\concept{Font helpers and shortcuts}
