
library(tidyverse)
library(cowplot)
library(ggtext)
library(lubridate)
library(plotly)

theme_set(theme_minimal(base_size = 12))

# import data ------------------------------------------------------------------

pop <- read_csv("data/einwohner_bundesland.csv")
corona_rki <- read_csv("data/corona_deu_rki.csv") %>% 
  left_join(pop, by = "Bundesland")


# data for plotting ------------------------------------------------------------

d_total <- corona_rki %>% 
  group_by(Datum) %>% 
  summarise(
    Fallzahl = sum(Fallzahl, na.rm = TRUE),
    Todeszahl = sum(Todeszahl, na.rm = TRUE),
    Einwohner = sum(Einwohner, na.rm = TRUE)
  ) %>% 
  mutate(Bundesland = "Gesamt")

d_plot <- corona_rki %>% 
  bind_rows(d_total) %>% 
  mutate(Bundesland = fct_reorder2(Bundesland, Datum, Fallzahl))

# prepare labels ---------------------------------------------------------------

# latest numbers per Bundesland
d_plot_end <- d_plot %>% 
  arrange(-as.numeric(Datum)) %>% 
  group_by(Bundesland) %>%
  top_n(1, Datum) %>% 
  ungroup() %>%
  mutate(Anteil = Fallzahl/Einwohner)

# evenly spread label coordinates
y_log <- log10(d_plot$Fallzahl)
lab_min <- min(y_log) + 0.5 * diff(range(y_log))
lab_max <- max(y_log)
lab_coord <- 10^seq(lab_min, lab_max, length.out = nlevels(d_plot$Bundesland))

# set colors
#colorRamp(c("#FFFFFF", "#374E55"))(0.87) %>% rgb(maxColorValue = 255)
color_text_total <- "#30453C"
color_line_total <- colorRamp(c("#FFFFFF", color_text_total))(0.9) %>% rgb(maxColorValue = 255)
#colorRamp(c("#FFFFFF", "#79AF97", "#000000"))(0.8) %>% rgb(maxColorValue = 255)
color_text_top <- "#6C9D87"
color_line_top <- colorRamp(c("#FFFFFF", color_text_top))(1) %>% rgb(maxColorValue = 255)
color_text_std <- "#000000"
color_line_std <- colorRamp(c("#FFFFFF", color_text_std))(0.4) %>% rgb(maxColorValue = 255)

# number of colored Bundesländer
top_color <- 3

# create label data set
d_plot_label_tot <- d_plot_end %>% 
  filter(Bundesland == "Gesamt") %>% 
  mutate(Ranking = 99)

d_plot_label_rest <- d_plot_end  %>% 
  arrange(-Anteil) %>% 
  filter(Bundesland != "Gesamt") %>% 
  mutate(Ranking = 1:n())

d_plot_label <- d_plot_label_tot %>% 
  bind_rows(d_plot_label_rest) %>% 
  mutate(color_text = if_else(Ranking <= top_color, color_text_top, color_text_std)) %>% 
  mutate(color_text = if_else(Ranking == 99, color_text_total, color_text)) %>% 
  mutate(color_line = if_else(Ranking <= top_color, color_line_top, color_line_std)) %>% 
  mutate(color_line = if_else(Ranking == 99, color_line_total, color_line)) %>% 
  mutate(pct = paste0(format(round(Anteil*100, 2), nsmall = 2),"%")) %>% 
  mutate(
    tot = format(Fallzahl) %>%
      str_replace_all(" ", "<span style='color:#ffffff00;'>0</span>") %>% 
      paste0("<span style='color:#ffffff00;'>0</span>", .)
  ) %>% 
  mutate(label = glue::glue("
    <span style='color:{color_text};'>
      <span style='font-family:\"Lucida Console\";font-size:9pt;'>
        {format(tot)} ({pct})
      </span>
      <span style='font-size:10pt;'>
        **{ifelse(Bundesland == \"Gesamt\", toupper(Bundesland), as.character(Bundesland))}**
      </span>
    </span>
  ")) %>% 
  arrange(Fallzahl) %>% 
  mutate(pos_x = Datum + 1) %>% 
  mutate(pos_y = lab_coord)

# create plot ------------------------------------------------------------------

# calculate x- and y-range (for label background)
mult_x <- c(0.05, 0.5)
mult_y <- c(0.025,0.025)
xrg <- range(d_plot$Datum) + c(-1, 1)*mult_x*diff(range(d_plot$Datum))
yrg <- range(d_plot$Fallzahl)

d_plot <- d_plot_label %>% 
  select(Bundesland, Anteil, Ranking) %>% 
  left_join(d_plot, ., by = "Bundesland") %>%
  filter(Bundesland != "Gesamt")

size_line_top <- 0.9
size_line_std <- 0.5

d_plot_top <- d_plot %>% 
  filter(Ranking <= top_color)

d_plot_std <- d_plot %>% 
  filter(Ranking > top_color)


p_geom_std_line <- geom_line(
    data = d_plot_std,
    mapping = aes(x = Datum, y = Fallzahl, group = Bundesland),
    alpha = 0.8, size = size_line_std, color = color_line_std
  )

p_geom_std_pt <- geom_point(
    data = d_plot_std,
    mapping = aes(x = Datum, y = Fallzahl, group = Bundesland),
    alpha = 0.8, size = 1.25*size_line_std, shape = 21,
    fill = color_line_std, color = "#FFFFFF"
  )

p_geom_top_line <- geom_line(
    data = d_plot_top,
    mapping = aes(x = Datum, y = Fallzahl, group = Bundesland),
    alpha = 0.8, size = size_line_top, color = color_line_top
  )

p_geom_top_pt <- geom_point(
    data = d_plot_top,
    mapping = aes(x = Datum, y = Fallzahl, group = Bundesland),
    alpha = 0.8, size = 1.25*size_line_top, shape = 21,
    fill = color_line_top, color = "#FFFFFF"
  )

p_geom_total_line <- geom_line(
    data = d_total,
    aes(Datum, Fallzahl),
    size = 1.2,
    color = color_line_total,
    inherit.aes = FALSE
  )

p_geom_total_pt <- geom_point(
    data = d_total,
    aes(Datum, Fallzahl),
    size = 1.5,
    fill = color_line_total,
    color = "#FFFFFF",
    shape = 21,
    inherit.aes = FALSE
  )

p_main <- ggplot() +
  annotate(
    "rect",
    xmin = max(d_plot_label$Datum),
    xmax = xrg[2],
    ymin = yrg[1]-0.5,
    ymax = yrg[2]+0.5,
    fill = "#FFFFFF"
  ) +
  geom_richtext(
    data = d_plot_label,
    mapping = aes(x = pos_x, y = pos_y, label = label),
    hjust = 0,
    vjust = 0.5,
    fill = NA,
    label.color = NA,
    label.padding = grid::unit(rep(0, 4), "pt"),
    show.legend = FALSE
  ) +
  geom_segment(
    data = d_plot_label,
    mapping = aes(x = Datum, xend = pos_x + 0.5, y = Fallzahl, yend =pos_y),
    alpha = 0.1, color = "#000000",
    inherit.aes = FALSE
  ) +
  p_geom_std_line +
  p_geom_std_pt +
  p_geom_top_line +
  p_geom_top_pt +
  p_geom_total_line +
  p_geom_total_pt +
  scale_x_date(
    breaks = seq(ymd("2020-03-09"), ymd(max(d_plot$Datum)), by = "weeks"),
    minor_breaks = seq(ymd("2020-03-04"), ymd(max(d_plot$Datum)), by = "days"),
    date_labels = "%d.%m",
    expand = expansion(mult = c(mult_x[1],0))
  ) +
  scale_y_continuous(
    trans = scales::log10_trans(),
    breaks = 10^c(0:5),
    expand = expansion(mult = mult_y),
    labels = function(x) scales::comma(x, big.mark = ".", accuracy = 1, decimal.mark = ",")
  ) +
  scale_color_manual(values = c(color_line_std, color_line_top)) +
  scale_fill_manual(values = c(color_line_std, color_line_top)) +
  labs(
    x = "Datum",
    y = glue::glue(
      "Gesamtanzahl gemeldeter Infektionen",
      "(logarithmische Skala)",
      .sep = "\n"
    ),
    title = glue::glue(
      "Entwicklung der Anzahl gemeldeter COVID-19 Fälle in **<span style='color:{color_text_total};'>Deutschland</span>**"
    ),
    subtitle = glue::glue(
      "Die {top_color} Bundesländer mit dem **<span style='color:{color_text_top};'>höchsten infizierten Bevölkerungsanteil</span>** sind farblich markiert"
    ),
    caption = glue::glue(
      "Quelle: Robert-Koch-Institut",
      "Daten seit dem {min(d_plot$Datum) %>% format(\"%d.%m.%Y\")}, letzte Aktualisierung am {max(d_plot$Datum) %>% format(\"%d.%m.%Y\")}",
      "github.com/seb09/covid19-ger-rki",
      .sep = "\n"
    )
  ) +
  theme(
    legend.position = "none",
    panel.grid.minor.y = element_blank(),
    axis.title.x = element_text(margin = margin(t = 0.5, unit = "lines"), hjust = 0.35),
    axis.title.y = element_text(margin = margin(r = 0.5, unit = "lines")),
    plot.title = element_markdown(),
    plot.subtitle = element_markdown(lineheight = 1.25),
    plot.caption = element_text(color = "#444444", size = 9, lineheight = 1.05)
  )

p_main

p_sub <- ggplot() +
  p_geom_std_line +
  p_geom_top_line +
  #p_geom_total_line +
  labs(title = "Original Skala") +
  theme(
    panel.grid.minor.y = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.background = element_rect(fill = "#FFFFFF"),
    panel.border = element_rect(color = "#000000", size = 0.33, fill = NA),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    plot.title = element_text(size = 10)
  )

p <- ggdraw() +
  draw_plot(p_main) +
  draw_plot(p_sub, x = 0.98, y = 0.12, width = 0.23, height = 0.36, hjust = 1, vjust = 0)

p

ggsave(fs::path("plots", "covid19-deu-rki-entwicklung.png"), p, width = 10, height = 6.66, dpi = 200, scale = 1.3)


