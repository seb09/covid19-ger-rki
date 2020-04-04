Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-04

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

    ## # A tibble: 506 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-04 Baden-Württemb…    17014       316          955            31
    ##  2 2020-04-04 Bayern             21908       349         1671            42
    ##  3 2020-04-04 Berlin              3471        22          269             2
    ##  4 2020-04-04 Brandenburg         1211        12          136             3
    ##  5 2020-04-04 Bremen               354         6           13             0
    ##  6 2020-04-04 Hamburg             2697        16          101             0
    ##  7 2020-04-04 Hessen              4279        42          286             9
    ##  8 2020-04-04 Mecklenburg-Vo…      501         5           33             1
    ##  9 2020-04-04 Niedersachsen       5571        85          490            20
    ## 10 2020-04-04 Nordrhein-West…    17885       200         1279            22
    ## 11 2020-04-04 Rheinland-Pfalz     3504        29          142             3
    ## 12 2020-04-04 Saarland            1265        14          186             2
    ## 13 2020-04-04 Sachsen             2591        24          255             3
    ## 14 2020-04-04 Sachsen-Anhalt       896        11           60             0
    ## 15 2020-04-04 Schleswig-Hols…     1559        17          116             2
    ## 16 2020-04-04 Thüringen           1072        10           90             1
    ## # … with 490 more rows

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
