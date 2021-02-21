#' @export
register_plexsans_condensed <- function(family = "IBM Plex Sans", features = NULL) {
  systemfonts::register_font(family,
                             plain = system.file("fonts", "plex",
                                                 "IBMPlexSansCondensed-Regular.ttf",
                                                 package = "ptrr"),
                             italic = system.file("fonts", "plex",
                                                  "IBMPlexSansCondensed-Italic.ttf",
                                                  package = "ptrr"),
                             bold = system.file("fonts", "plex",
                                                "IBMPlexSansCondensed-Bold.ttf",
                                                package = "ptrr"),
                             bolditalic = system.file("fonts", "plex",
                                                      "IBMPlexSansCondensed-BoldItalic.ttf",
                                                      package = "ptrr")
  )
}

#' @export
register_plexsans <- function(family = "IBM Plex Sans", features = NULL) {
  systemfonts::register_font(family,
                             plain = system.file("fonts", "plex",
                                                 "IBMPlexSans-Regular.ttf",
                                                 package = "ptrr"),
                             italic = system.file("fonts", "plex",
                                                  "IBMPlexSans-Italic.ttf",
                                                  package = "ptrr"),
                             bold = system.file("fonts", "plex",
                                                "IBMPlexSans-Bold.ttf",
                                                package = "ptrr"),
                             bolditalic = system.file("fonts", "plex",
                                                      "IBMPlexSans-BoldItalic.ttf",
                                                      package = "ptrr")  )
  }
