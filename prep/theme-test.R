library(ggplot2)
library(marquee)

sss <- marquee::classic_style() |>
  marquee::modify_style("sheep", background = "red") |>
  marquee::modify_style("greet", background = "blue", color = "white") |>
  marquee::modify_style(tag = "body", lineheight = 1, margin = trbl(0, 0, 0, 0))

ggplot(tibble::tibble(x = 1:100, y = (1:100)/100,
       z = rep(c("{.sheep a}", "{.greet b}"), 50))) +
  geom_point(aes(y, x)) +
  scale_x_percent_cz() +
  scale_y_number_cz() +
  theme(plot.margin = unit(c(0, 12, 0, 0), "pt")) +
  facet_wrap(~ z) +
  labs(title = "{.greet Hello} _{.sheep dolly}_.",
       subtitle = "{.greet Hello} _{.sheep dolly}_.",
       x = "{.sheep Blah}",
       caption = "And a caption") +
  theme_ptrr(inverse = TRUE,
             multiplot = TRUE,
             richtext = TRUE,
             gridlines = "scatter",
             richtext_style = sss,
             margin_side = 6,
             margin_bottom = 0,
             axis_titles = "x")

sss[[1]]
