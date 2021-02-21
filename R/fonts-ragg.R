#' Register IBM font with system
#'
#' Register the IBM Plex Sans Condensed font files contained in the package with the OS font system. Wrapper around `systemfonts::register_font()`.
#' Useful in situations where you cannot install fonts into the system font location, e.g. on CI systems.
#'
#' @param family What you want the resulting font family to be called in the registry. Defaults to "IBM Plex Sans Condensed"
#' @param features Unused for now
#' @param warn Whether to warn when a font family of the same name already exists.
#'
#' @return TRUE if a font was successfully registered, FALSE otherwise. Called for side effects.
#' @examples
#' register_plexsans_condensed("ibmps")
#' @export
register_plexsans_condensed <- function(family = "IBM Plex Sans Condensed", features = NULL, warn = TRUE) {

  if(family %in% systemfonts::system_fonts()[["family"]]) {
    if(warn) usethis::ui_warn(" Family {usethis::ui_value(family)} already exists in system font registry. Skipping.")
    invisible(FALSE)
  } else {

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
    invisible(TRUE)
  }
}

#' Register IBM font with system
#'
#' Register the IBM Plex Sans font files contained in the package with the OS font system. Wrapper around `systemfonts::register_font()`
#' Useful in situations where you cannot install fonts into the system font location, e.g. on CI systems.
#'
#' @param family What you want the resulting font family to be called in the registry. Defaults to "IBM Plex Sans"
#' @inheritParams register_plexsans_condensed
#'
#' @return TRUE if a font was successfully registered, FALSE otherwise. Called for side effects.
#' @examples
#' register_plexsans_condensed("ibmpsc")
#' @export
register_plexsans <- function(family = "IBM Plex Sans", features = NULL, warn = TRUE) {

  if(family %in% systemfonts::system_fonts()[["family"]]) {
    if(warn) usethis::ui_warn(" Family {usethis::ui_value(family)} already exists in system font registry. Skipping.")
    invisible(FALSE)
  } else {

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
    invisible(TRUE)
    }
}
