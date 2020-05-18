Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-05-18

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

    ## # A tibble: 1,194 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-05-17 Baden-Württemb…    33950      1648           57             4
    ##  2 2020-05-17 Bayern             45427      2283           87            10
    ##  3 2020-05-17 Berlin              6447       182           19             1
    ##  4 2020-05-17 Brandenburg         3171       149            2             0
    ##  5 2020-05-17 Bremen              1164        37           14             0
    ##  6 2020-05-17 Hamburg             5029       232           12             1
    ##  7 2020-05-17 Hessen              9317       435           56             3
    ##  8 2020-05-17 Mecklenburg-Vo…      748        20            2             0
    ##  9 2020-05-17 Niedersachsen      11155       544           63             9
    ## 10 2020-05-17 Nordrhein-West…    36286      1505          221             5
    ## 11 2020-05-17 Rheinland-Pfalz     6449       216            0             0
    ## 12 2020-05-17 Saarland            2696       149            8             0
    ## 13 2020-05-17 Sachsen             5115       196           26            -1
    ## 14 2020-05-17 Sachsen-Anhalt      1676        54            0             0
    ## 15 2020-05-17 Schleswig-Hols…     3000       126            2             0
    ## 16 2020-05-17 Thüringen           2725       138           14             1
    ## # … with 1,178 more rows

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

<img src="plots/covid19-deu-rki-entwicklung-original-skala.png">

[Full
size](https://github.com/seb09/covid19-ger-rki/raw/master/plots/covid19-deu-rki-entwicklung-original-skala.png)

-----

<img src="plots/covid19-deu-rki-entwicklung.png">

[Full
size](https://github.com/seb09/covid19-ger-rki/raw/master/plots/covid19-deu-rki-entwicklung.png)

-----

<img src="plots/covid19-deu-rki-faelle-pro-tag.png">

[Full
size](https://github.com/seb09/covid19-ger-rki/raw/master/plots/covid19-deu-rki-faelle-pro-tag.png)
