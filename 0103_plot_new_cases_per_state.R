
library(tidyverse)
library(geofacet)

theme_set(theme_minimal(base_size = 12))

# import data ------------------------------------------------------------------

pop <- read_csv("data/einwohner_bundesland.csv")
corona_rki <- read_csv("data/corona_deu_rki.csv") 

# prepare DE grid --------------------------------------------------------------

de_grid <- de_states_grid1 %>% 
  mutate(name_de = str_replace(name_de, "Westphalen", "Westfalen")) %>% 
  mutate(name_de = str_replace(name_de, "Niedersachen", "Niedersachsen")) %>% 
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
  mutate(Region = case_when(
    code %in% c("NI", "SH", "MV") ~ "Norden",
    code %in% c("ST", "BB", "TH", "SN") ~ "Osten",
    code %in% c("BW", "BY") ~ "Süden",
    code %in% c("NW", "HE", "RP", "SL") ~ "Westen",
  )) %>% 
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

# plot. new cases per federal state and day ------------------------------------

color_region <- c("#DF8F44", "#00A1D5", "#79AF97FF", "#B24745")
names(color_region) <- c("Norden", "Osten", "Süden", "Westen")

p1 <- new_cases %>% 
  ggplot(aes(Datum, Fallzahl_neu_norm, fill = Region)) +
  geom_col() +
  facet_geo(~code, grid = de_grid, label = "name2") +
  scale_x_date(
    breaks = seq(ymd("2020-03-09"), ymd(max(d_plot$Datum)), by = "weeks"),
    minor_breaks = seq(ymd("2020-03-04"), ymd(max(d_plot$Datum)), by = "days"),
    date_labels = "%d.%m.",
    expand = expansion(mult = c(mult_x[1],0))
  ) +
  scale_fill_manual(values = color_region) +
  labs(
    x = "Datum",
    y = "Gemeldete Infektionen pro 100.000 Einwohner",
    title = glue::glue(
      "Gemeldete COVID-19 Fälle pro 100.000 Einwohner"
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
      "Daten seit dem {min(d_plot$Datum) %>% format(\"%d.%m.%Y\")}, letzte Aktualisierung am {max(d_plot$Datum) %>% format(\"%d.%m.%Y\")}",
      "github.com/seb09/covid19-ger-rki",
      .sep = "\n"
    )
  ) +
  theme(
    legend.position = "none",
    strip.text = element_text(size = 8),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.title.x = element_text(margin = margin(t = 0.5, unit = "lines")),
    axis.text.x = element_text(size = 6),
    axis.title.y = element_text(margin = margin(r = 0.5, unit = "lines")),
    plot.title = element_markdown(),
    plot.subtitle = element_markdown(lineheight = 1.25),
    plot.caption = element_text(color = "#444444", size = 9, lineheight = 1.05)
  )

p1

# new_cases %>% 
#   group_by(Bundesland, Datum) %>% 
#   summarise(Fallzahl_neu_norm = sum(Fallzahl_neu_norm)) %>% 
#   ggplot(aes(Datum, Fallzahl_neu_norm)) +
#   geom_col()
