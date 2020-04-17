Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-17

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

    ## # A tibble: 714 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-17 Baden-Württemb…    26543       872          662            70
    ##  2 2020-04-17 Bayern             36027      1137          885            88
    ##  3 2020-04-17 Berlin              4945        84           97            10
    ##  4 2020-04-17 Brandenburg         2120        60           62             6
    ##  5 2020-04-17 Bremen               556        22           49             1
    ##  6 2020-04-17 Hamburg             4005        84           52             4
    ##  7 2020-04-17 Hessen              6705       197          235            10
    ##  8 2020-04-17 Mecklenburg-Vo…      634        13            0             0
    ##  9 2020-04-17 Niedersachsen       8442       274          254            26
    ## 10 2020-04-17 Nordrhein-West…    27030       726          647            63
    ## 11 2020-04-17 Rheinland-Pfalz     5211        92          124             5
    ## 12 2020-04-17 Saarland            2254        76           53             5
    ## 13 2020-04-17 Sachsen             4048        95           93             1
    ## 14 2020-04-17 Sachsen-Anhalt      1279        28           31             2
    ## 15 2020-04-17 Schleswig-Hols…     2349        59           55             4
    ## 16 2020-04-17 Thüringen           1682        49           81             4
    ## # … with 698 more rows

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

I’ll try to update the data daily. You can import the most recent
version directly from GitHub.

``` r
library(readr)
corona_rki <- read_csv("https://raw.githubusercontent.com/seb09/covid19-ger-rki/master/data/corona_deu_rki.csv")
```

I will also produce a plot from time to time, probably in German. You’re
welcome to use them.

-----

<img src="plots/covid19-deu-rki-entwicklung.png">

[Full
size](https://github.com/seb09/covid19-ger-rki/raw/master/plots/covid19-deu-rki-entwicklung.png)

-----

<img src="plots/covid19-deu-rki-faelle-pro-tag.png">

[Full
size](https://github.com/seb09/covid19-ger-rki/raw/master/plots/covid19-deu-rki-faelle-pro-tag.png)
