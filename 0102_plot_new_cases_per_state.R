
library(tidyverse)
library(geofacet)
library(ggtext)
library(lubridate)
library(patchwork)

theme_set(theme_minimal(base_size = 12))

# import data ------------------------------------------------------------------

pop <- read_csv("data/einwohner_bundesland.csv")
corona_rki <- read_csv("data/corona_deu_rki.csv") 

# prepare DE grid --------------------------------------------------------------

de_grid_pre <- de_states_grid1 %>% 
  mutate(name_de = str_replace(name_de, "Westphalen", "Westfalen")) %>% 
  mutate(name_de = str_replace(name_de, "Niedersachen", "Niedersachsen"))

de_region <- de_grid_pre %>% 
  select(code, name_de) %>% 
  mutate(Region = case_when(
    code %in% c("NI", "SH", "MV", "HB", "HH") ~ "Norden",
    code %in% c("ST", "BB", "TH", "SN", "BE") ~ "Osten",
    code %in% c("BW", "BY") ~ "Süden",
    code %in% c("NW", "HE", "RP", "SL") ~ "Westen",
  ))

de_grid <- de_grid_pre %>% 
  select(-name) %>%
  rename(name = name_de) %>% 
  mutate(row = case_when(
    code %in% c("NI", "SH", "MV") ~ 1,
    #code %in% c("HB", "HH", "BE") ~ 2,
    code %in% c("NW", "ST", "BB") ~ 2,
    code %in% c("SL", "RP", "HE", "TH", "SN") ~ 3,
    code %in% c("BW", "BY") ~ 4
  )) %>% 
  mutate(col = case_when(
    code %in% c("SL") ~ 1,
    code %in% c("NW", "RP") ~ 2,
    code %in% c("NI", "HE", "BW") ~ 3,
    code %in% c("SH", "ST", "TH", "BY") ~ 4,
    code %in% c("MV", "BB", "SN") ~ 5
  )) %>% 
  na.exclude() %>% 
  mutate(name2 = case_when(
    name == "Schleswig-Holstein" ~ "Schleswig-Holstein (+Hamburg)",
    name == "Niedersachsen" ~ "Niedersachsen (+Bremen)",
    name == "Brandenburg" ~ "Brandenburg (+Berlin)",
    TRUE ~ name
  ))

# prepare federal state data ---------------------------------------------------

de_pop <- pop %>% 
  mutate(Bundesland = case_when(
    Bundesland == "Hamburg" ~ "Schleswig-Holstein",
    Bundesland == "Bremen" ~ "Niedersachsen",
    Bundesland == "Berlin" ~ "Brandenburg",
    TRUE ~ Bundesland
  )) %>% 
  group_by(Bundesland) %>% 
  summarise(Einwohner = sum(Einwohner)) %>% 
  ungroup() %>% 
  left_join(de_grid, by = c("Bundesland" = "name")) %>% 
  left_join(de_region %>% select(-name_de), by = "code") %>% 
  select(-row, -col)

# prepare data on new cases over time ------------------------------------------

new_cases <- corona_rki %>% 
  mutate(Bundesland = case_when(
    Bundesland == "Hamburg" ~ "Schleswig-Holstein",
    Bundesland == "Bremen" ~ "Niedersachsen",
    Bundesland == "Berlin" ~ "Brandenburg",
    TRUE ~ Bundesland
  )) %>% 
  left_join(de_pop, by = "Bundesland") %>% 
  group_by(code, Region, Bundesland, Einwohner, Datum) %>% 
  summarise(Fallzahl_neu = sum(Fallzahl_neu, na.rm=TRUE)) %>% 
  ungroup() %>% 
  mutate(Fallzahl_neu = pmax(Fallzahl_neu, 0, na.rm = TRUE)) %>% 
  mutate(Fallzahl_neu_norm = Fallzahl_neu / Einwohner * 10^5)

# colors -----------------------------------------------------------------------

color_region <- c("#DF8F44", "#00A1D5", "#79AF97FF", "#B24745")
names(color_region) <- c("Norden", "Osten", "Süden", "Westen")

# plot: new cases per federal state and day -------------------------

plot_per_state <- function(yvar, title){
  
  # yvar <- "Fallzahl_neu_norm"
  # title <- "nach Bundesland
 
  d_plot <- new_cases
  
  p_bl <- d_plot %>% 
    ggplot(aes(Datum, !!sym(yvar), fill = Region)) +
    geom_col() +
    facet_geo(~code, grid = de_grid, label = "name2") +
    scale_x_date(
      breaks = seq(ymd("2020-03-09"), ymd(max(d_plot$Datum)), by = "weeks"),
      minor_breaks = seq(ymd("2020-03-04"), ymd(max(d_plot$Datum)), by = "days"),
      date_labels = "%d.%m.",
      expand = expansion(add = c(0,1))
    ) +
    scale_fill_manual(values = color_region) +
    scale_y_continuous(labels = function(x) scales::comma(x, big.mark = ".", accuracy = 1, decimal.mark = ",")) +
    labs(
      subtitle = glue::glue("**{title}**")
    ) +
    theme(
      legend.position = "none",
      strip.text = element_text(size = 10),
      panel.grid.minor.x = element_blank(),
      panel.grid.minor.y = element_blank(),
      #axis.title.x = element_text(margin = margin(t = 0.5, unit = "lines")),
      axis.title.x = element_blank(),
      axis.text.x = element_text(size = 8),
      #axis.title.y = element_text(margin = margin(r = 0.5, unit = "lines")),
      axis.title.y = element_blank(),
      plot.title = element_markdown(),
      plot.subtitle = element_markdown(),
      #plot.caption = element_text(color = "#444444", size = 9, lineheight = 1.05),
      plot.margin = margin(t = 1, b = 1, unit = "lines")
    )

  p_bl
  
}

# plot: new cases overall ------------------------------------------------------

d_plot <- new_cases %>%
  group_by(Region, Datum) %>%
  summarise(Fallzahl_neu= sum(Fallzahl_neu)) %>%
  ungroup() %>% 
  arrange(desc(Datum)) %>% 
  mutate(Region = fct_reorder2(Region, Datum, Fallzahl_neu) %>% fct_rev())

xmax <- d_plot %>% 
  group_by(Datum) %>% 
  summarise(x = sum(Fallzahl_neu)) %>% 
  pull(x) %>% 
  max()

p_total <- d_plot %>% 
  ggplot(aes(Datum, Fallzahl_neu, fill = Region)) +
  #geom_col(position = position_dodge()) +
  geom_col() +
  scale_x_date(
    breaks = seq(ymd("2020-03-09"), ymd(max(d_plot$Datum)), by = "weeks"),
    minor_breaks = seq(ymd("2020-03-04"), ymd(max(d_plot$Datum)), by = "days"),
    date_labels = "%d.%m.",
    expand = expansion(add = c(0,1))
  ) +
  scale_y_continuous(
    limits = c(0,max(100, xmax)),
    labels = function(x) scales::comma(x, big.mark = ".", accuracy = 1, decimal.mark = ",")
  ) +
  scale_fill_manual(values = color_region) +
  labs(
    x = "Datum",
    y = "Gemeldete Infektionen pro 100.000 Einwohner",
    subtitle = "**Gesamt-Deutschland**"
  ) +
  theme(
    legend.position = "none",
    # panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    # axis.title.x = element_text(margin = margin(t = 0.5, unit = "lines")),
    axis.title.x = element_blank(),
    axis.text.x = element_text(size = 9),
    # axis.title.y = element_text(margin = margin(r = 0.5, unit = "lines"))
    axis.title.y = element_blank(),
    plot.title = element_markdown(),
    plot.subtitle = element_markdown(),
    plot.margin = margin(t = 1, b = 1, unit = "lines")
  )

# plot: german map -------------------------------------------------------------

d_shade_deu <- readRDS("data/gadm36_DEU_1_sf.rds")

p_map <- d_shade_deu %>% 
  left_join(de_region, by = c("NAME_1" = "name_de")) %>% 
  ggplot() +
  geom_sf(aes(fill = Region), color = "#FFFFFF") +
  scale_fill_manual(values = color_region) +
  theme_void() +
  theme(
    legend.position = "none",
    panel.border = element_rect(color = "#000000", size = 0.33, fill = NA)
  )


# combine plots ----------------------------------------------------------------

layout <- c(
  area(t = 1, l = 1, b = 4, r = 16),
  area(t = 1, l = 18, b = 3, r = 20),
  area(t = 5, l = 1, b = 11, r = 20),
  area(t = 12, l = 1, b = 18, r = 20)
)

p <- p_total + p_map + 
  plot_per_state("Fallzahl_neu", "nach Bundesland") +
  plot_per_state("Fallzahl_neu_norm", "nach Bundesland (Fälle pro 100.000 Einwohner)") +
  plot_layout(design = layout) + 
  plot_annotation(
    title = glue::glue(
      "Gemeldete COVID-19 Fälle pro Tag"
    ),
    subtitle = glue::glue(
      "in 
      **<span style='color:{color_region[\"Norden\"]};'>Nord-</span>**,
      **<span style='color:{color_region[\"Osten\"]};'>Ost-</span>**,
      **<span style='color:{color_region[\"Süden\"]};'>Süd-</span>**, und
      **<span style='color:{color_region[\"Westen\"]};'>West-</span>**Deutschland"
    ),
    caption = glue::glue(
      "Quelle: Robert-Koch-Institut",
      "Daten seit dem {min(new_cases$Datum) %>% format(\"%d.%m.%Y\")}, letzte Aktualisierung am {max(new_cases$Datum) %>% format(\"%d.%m.%Y\")}",
      "github.com/seb09/covid19-ger-rki",
      .sep = "\n"
    )
  ) &
  theme(
    plot.title = element_markdown(size = 14),
    plot.subtitle = element_markdown(size = 12, lineheight = 1.25),
    plot.caption = element_text(color = "#444444", size = 9, lineheight = 1.05)
  )

ggsave(fs::path("plots", "covid19-deu-rki-faelle-pro-tag.png"), p, width = 10, height = 18, dpi = 200, scale = 1.2)
