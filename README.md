Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-03-29

This repository contains data on reported COVID-19 cases in Germany and
its federal states that is published daily by the Robert-Koch-Institut
(RKI).

``` r
library(tidyverse)
corona_rki <- read_csv("data/corona_deu_rki.csv")
corona_rki
```

    ## # A tibble: 410 x 4
    ##    Datum      Bundesland             Fallzahl Todeszahl
    ##    <date>     <chr>                     <dbl>     <dbl>
    ##  1 2020-03-04 Brandenburg                   1         0
    ##  2 2020-03-04 Berlin                        7         0
    ##  3 2020-03-04 Baden-Württemberg            50         0
    ##  4 2020-03-04 Bayern                       48         0
    ##  5 2020-03-04 Bremen                        3         0
    ##  6 2020-03-04 Hessen                       12         0
    ##  7 2020-03-04 Hamburg                       3         0
    ##  8 2020-03-04 Mecklenburg-Vorpommern        4         0
    ##  9 2020-03-04 Niedersachsen                 7         0
    ## 10 2020-03-04 Nordrhein-Westfalen         115         0
    ## # … with 400 more rows

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

    ## # A tibble: 17 x 2
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
    ## 17 Deutschland             83019213

I’ll try to update the data daily and produce a plot from time to time.
Most plots will probably be in German. You’re welcome to use them.

-----

<img src="plots/covid19-deu-rki-entwicklung.png">
