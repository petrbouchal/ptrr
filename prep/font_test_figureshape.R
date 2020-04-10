library(ggplot2)
library(magrittr)

theme_encode <- theme_minimal() +
  theme(text = element_text(family = "Titillium Web"),
        # plot.subtitle = element_text(family = "Lato"),
        # plot.title = element_text(family = "Lato", face = "bold"),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        strip.text = element_text(hjust = 0),
        plot.caption = element_text(family = "Clear Sans",
                                    color = "darkgrey"))

gg <- ggplot(mtcars) +
  geom_point(aes(mpg, wt)) +
  theme_encode +
  labs(title = "Fshdkdhs fsdkhkfsjdhj reuoweu",
       subtitle = "1111 Hello\n9999 there \n3000 stranger",
       caption = "Zdroj: fsdhjdf fsdhkfwurewoi rewiuewr wreuiocmn, siu.\nYhkjrwh fshk jpewropo fdshjksdh") +
  # hrbrthemes::ft_geom_defaults() +
  facet_wrap(~ gear)
gg

# hrbrthemes::flush_ticks(gg) %>% print()

