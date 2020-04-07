Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-07

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

    ## # A tibble: 554 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-07 Baden-Württemb…    20141       433          746            46
    ##  2 2020-04-07 Bayern             26163       481         1189            44
    ##  3 2020-04-07 Berlin              3845        28          175             2
    ##  4 2020-04-07 Brandenburg         1384        20           39             1
    ##  5 2020-04-07 Bremen               399         9            2             1
    ##  6 2020-04-07 Hamburg             3059        20           66             1
    ##  7 2020-04-07 Hessen              4837        73          163            12
    ##  8 2020-04-07 Mecklenburg-Vo…      531         8            3             2
    ##  9 2020-04-07 Niedersachsen       6200       111          240            19
    ## 10 2020-04-07 Nordrhein-West…    20220       282          836            27
    ## 11 2020-04-07 Rheinland-Pfalz     3992        34          110             2
    ## 12 2020-04-07 Saarland            1532        16           49             2
    ## 13 2020-04-07 Sachsen             2997        38           94             4
    ## 14 2020-04-07 Sachsen-Anhalt       987        12           31             0
    ## 15 2020-04-07 Schleswig-Hols…     1730        24           59             4
    ## 16 2020-04-07 Thüringen           1208        18           32             6
    ## # … with 538 more rows

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
