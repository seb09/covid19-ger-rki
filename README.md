Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-01

This repository contains data on reported COVID-19 cases in Germany and
its federal states that is published daily by the Robert-Koch-Institut
(RKI).

``` r
library(tidyverse)
corona_rki <- read_csv("data/corona_deu_rki.csv")
corona_rki %>% 
  arrange(desc(Datum), Bundesland) %>% 
  print(n = 16)
```

    ## # A tibble: 458 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-03-31 Baden-Württemb…    13410       197         1076            32
    ##  2 2020-03-31 Bayern             16497       225         1687            63
    ##  3 2020-03-31 Berlin              2754        16          179             3
    ##  4 2020-03-31 Brandenburg          881         4           83             2
    ##  5 2020-03-31 Bremen               311         5           17             1
    ##  6 2020-03-31 Hamburg             2311        14          120             5
    ##  7 2020-03-31 Hessen              3445        21          162             4
    ##  8 2020-03-31 Mecklenburg-Vo…      406         3           40             2
    ##  9 2020-03-31 Niedersachsen       4382        42          319             8
    ## 10 2020-03-31 Nordrhein-West…    14351       134         1126            17
    ## 11 2020-03-31 Rheinland-Pfalz     2899        23          173             4
    ## 12 2020-03-31 Saarland             829         8           47             1
    ## 13 2020-03-31 Sachsen             2034        17          152             5
    ## 14 2020-03-31 Sachsen-Anhalt       750         7           70             1
    ## 15 2020-03-31 Schleswig-Hols…     1246        10          126             1
    ## 16 2020-03-31 Thüringen            860         6           76             0
    ## # … with 442 more rows

Data is downloaded each day at 11am from the [website of the
RKI](https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html)
(and updated again at 11pm). Population sizes of the federal states were
scraped from
[Wikipedia](https://de.wikipedia.org/wiki/Liste_der_deutschen_Bundesl%C3%A4nder_nach_Bev%C3%B6lkerung)
and are also available in this repo.

``` r
population <- read_csv("data/einwohner_bundesland.csv")
population
```

    ## # A tibble: 16 x 2
    ##    Bundesland             Einwohner
    ##    <chr>                      <dbl>
    ##  1 Baden-Württemberg       11069533
    ##  2 Bayern                  13076721
    ##  3 Berlin                   3644826
    ##  4 Brandenburg              2511917
    ##  5 Bremen                    682986
    ##  6 Hamburg                  1841179
    ##  7 Hessen                   6265809
    ##  8 Mecklenburg-Vorpommern   1609675
    ##  9 Niedersachsen            7982448
    ## 10 Nordrhein-Westfalen     17932651
    ## 11 Rheinland-Pfalz          4084844
    ## 12 Saarland                  990509
    ## 13 Sachsen                  4077937
    ## 14 Sachsen-Anhalt           2208321
    ## 15 Schleswig-Holstein       2896712
    ## 16 Thüringen                2143145

I’ll try to update the data daily and produce a plot from time to time.
Most plots will probably be in German. You’re welcome to use them.

-----

<img src="plots/covid19-deu-rki-entwicklung.png">
