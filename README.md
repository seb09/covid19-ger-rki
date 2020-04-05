Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-05

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

    ## # A tibble: 522 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-05 Baden-Württemb…    18614       367         1600            51
    ##  2 2020-04-05 Bayern             23846       396         1938            47
    ##  3 2020-04-05 Berlin              3613        24          142             2
    ##  4 2020-04-05 Brandenburg         1305        17           94             5
    ##  5 2020-04-05 Bremen               394         6           40             0
    ##  6 2020-04-05 Hamburg             2945        19          248             3
    ##  7 2020-04-05 Hessen              4575        56          296            14
    ##  8 2020-04-05 Mecklenburg-Vo…      523         5           22             0
    ##  9 2020-04-05 Niedersachsen       5712        89          141             4
    ## 10 2020-04-05 Nordrhein-West…    18735       245          850            45
    ## 11 2020-04-05 Rheinland-Pfalz     3663        32          159             3
    ## 12 2020-04-05 Saarland            1358        14           93             0
    ## 13 2020-04-05 Sachsen             2741        32          150             8
    ## 14 2020-04-05 Sachsen-Anhalt       919        12           23             1
    ## 15 2020-04-05 Schleswig-Hols…     1631        18           72             1
    ## 16 2020-04-05 Thüringen           1140        10           68             0
    ## # … with 506 more rows

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
