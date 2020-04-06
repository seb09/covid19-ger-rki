Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-06

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

    ## # A tibble: 538 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-06 Baden-Württemb…    19395       387          781            20
    ##  2 2020-04-06 Bayern             24974       437         1128            41
    ##  3 2020-04-06 Berlin              3670        26           57             2
    ##  4 2020-04-06 Brandenburg         1345        19           40             2
    ##  5 2020-04-06 Bremen               397         8            3             2
    ##  6 2020-04-06 Hamburg             2993        19           48             0
    ##  7 2020-04-06 Hessen              4674        61           99             5
    ##  8 2020-04-06 Mecklenburg-Vo…      528         6            5             1
    ##  9 2020-04-06 Niedersachsen       5960        92          248             3
    ## 10 2020-04-06 Nordrhein-West…    19384       255          649            10
    ## 11 2020-04-06 Rheinland-Pfalz     3882        32          219             0
    ## 12 2020-04-06 Saarland            1483        14          125             0
    ## 13 2020-04-06 Sachsen             2903        34          162             2
    ## 14 2020-04-06 Sachsen-Anhalt       956        12           37             0
    ## 15 2020-04-06 Schleswig-Hols…     1671        20           40             2
    ## 16 2020-04-06 Thüringen           1176        12           36             2
    ## # … with 522 more rows

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
