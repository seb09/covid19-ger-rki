Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-03-30

This repository contains data on reported COVID-19 cases in Germany and
its federal states that is published daily by the Robert-Koch-Institut
(RKI).

``` r
library(tidyverse)
corona_rki <- read_csv("data/corona_deu_rki.csv")
corona_rki %>% 
  arrange(-as.numeric(Datum), Bundesland)
```

    ## # A tibble: 426 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-03-30 Baden-Württemb…    10943       119         1149            18
    ##  2 2020-03-30 Bayern             13989       127         1108            20
    ##  3 2020-03-30 Berlin              2464        11          104             2
    ##  4 2020-03-30 Brandenburg          761         2           40             1
    ##  5 2020-03-30 Bremen               286         2           11             0
    ##  6 2020-03-30 Hamburg             2053         5          207             1
    ##  7 2020-03-30 Hessen              3091        13          486             4
    ##  8 2020-03-30 Mecklenburg-Vo…      356         1            8             0
    ##  9 2020-03-30 Niedersachsen       3732        26          282             5
    ## 10 2020-03-30 Nordrhein-West…    12178       101          778             3
    ## # … with 416 more rows

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
