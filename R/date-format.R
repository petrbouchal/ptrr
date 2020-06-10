
#' Pretty-format a date
#'
#' Returns a string represenation of a date, with month names in the chosen locale
#' and leading zeros removed. Month and date formats are customisable without having to
#' remember format codes. Defaults are geared towards Czech-locale dates.
#'
#' @param date a date, object of class POSIXct. Defaults to lubridate::now()
#' @param month_format Month format. `"long"` for full month name (the default),
#' `"short"` for month abbreviation, or `"number"` for numeric.
#' @param year_format `"long"` for 4-digit (default), `"short"` for 2-digit.
#' @param locale Locale string. Defaults to `"cs_CZ.UTF-8"`
#' @param day_dot Whether to put a dot after the day. Defaults to TRUE.
#'
#' @return a string of same length as input
#' @examples
#' format_date_human()
#' format_date_human(month_format = "short")
#' format_date_human(month_format = "number")
#' format_date_human(year_format = "long")
#' format_date_human(month_format = "short", locale = "fr_FR")
#' format_date_human(month_format = "short", locale = "en_US", day_dot = F)
#' format_date_human(date = c(lubridate::now(),
#'                            lubridate::now() - 100000),
#'                   month_format = "short", locale = "fr_FR", day_dot = F)
#' @export
format_date_human <- function(date = lubridate::now(),
                              month_format = c("long", "short", "number"),
                              year_format = c("long", "short"),
                              locale = "cs_CZ.UTF-8",
                              day_dot = TRUE) {
  orig_locale <- Sys.getlocale(category = "LC_TIME")

  Sys.setlocale("LC_TIME", locale)

  month_format2 <- match.arg(month_format, c("long", "short", "number"))
  year_format2 <- match.arg(year_format, c("long", "short"))

  month_format3 <- dplyr::case_when(month_format2 == "long" ~ "%B",
                                    month_format2 == "short" ~ "%b",
                                    month_format2 == "number" ~ "%m."
  )

  year_format3 <- dplyr::case_when(year_format2 == "long" ~ "%Y",
                                   year_format2 == "short" ~ "%y"
  )

  dot <- ifelse(day_dot, ".", "")

  if(month_format2 == "number") {
    date_formatted <- stringr::str_glue("{lubridate::day(date)}{dot} {lubridate::month(date)}. {format(date, year_format3)}")
  } else {
    mon_yr_fmt_string <- paste0(month_format3, " ", year_format3)
    mon_yr <- format(date, mon_yr_fmt_string)
    date_formatted <- stringr::str_glue("{lubridate::day(date)}{dot} {mon_yr}")
  }

  Sys.setlocale(category = "LC_TIME", orig_locale)
  return(date_formatted)
}
