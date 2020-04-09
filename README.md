Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-09

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

    ## # A tibble: 586 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-09 Baden-Württemb…    21603       519          923            55
    ##  2 2020-04-09 Bayern             28827       635         1263            71
    ##  3 2020-04-09 Berlin              4202        37          174             5
    ##  4 2020-04-09 Brandenburg         1578        30          106             8
    ##  5 2020-04-09 Bremen               445        11           21             1
    ##  6 2020-04-09 Hamburg             3320        44          155            21
    ##  7 2020-04-09 Hessen              5242       100          277            16
    ##  8 2020-04-09 Mecklenburg-Vo…      572        11           17             0
    ##  9 2020-04-09 Niedersachsen       6804       141          419            20
    ## 10 2020-04-09 Nordrhein-West…    21961       384         1032            36
    ## 11 2020-04-09 Rheinland-Pfalz     4336        50          188             5
    ## 12 2020-04-09 Saarland            1693        23           56             0
    ## 13 2020-04-09 Sachsen             3261        52          117             2
    ## 14 2020-04-09 Sachsen-Anhalt      1075        16           55             0
    ## 15 2020-04-09 Schleswig-Hols…     1932        34          105             6
    ## 16 2020-04-09 Thüringen           1351        20           66             0
    ## # … with 570 more rows

Data is downloaded each day at 11am from the [website of the
RKI](https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html)
(and updated again at 11pm). The time stamp refers to the day when the
data was downloaded.

Population sizes of the federal states were scraped from
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
