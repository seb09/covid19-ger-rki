Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-08

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

    ## # A tibble: 570 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-08 Baden-Württemb…    20680       464          539            31
    ##  2 2020-04-08 Bayern             27564       564         1401            83
    ##  3 2020-04-08 Berlin              4028        32          183             4
    ##  4 2020-04-08 Brandenburg         1472        22           88             2
    ##  5 2020-04-08 Bremen               424        10           25             1
    ##  6 2020-04-08 Hamburg             3165        23          106             3
    ##  7 2020-04-08 Hessen              4965        84          128            11
    ##  8 2020-04-08 Mecklenburg-Vo…      555        11           24             3
    ##  9 2020-04-08 Niedersachsen       6385       121          185            10
    ## 10 2020-04-08 Nordrhein-West…    20929       348          709            66
    ## 11 2020-04-08 Rheinland-Pfalz     4148        45          156            11
    ## 12 2020-04-08 Saarland            1637        23          105             7
    ## 13 2020-04-08 Sachsen             3144        50          147            12
    ## 14 2020-04-08 Sachsen-Anhalt      1020        16           33             4
    ## 15 2020-04-08 Schleswig-Hols…     1827        28           97             4
    ## 16 2020-04-08 Thüringen           1285        20           77             2
    ## # … with 554 more rows

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
