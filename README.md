Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-05-15

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

    ## # A tibble: 1,162 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-05-15 Baden-Württemb…    33851      1628          181            20
    ##  2 2020-05-15 Bayern             45143      2260          163            31
    ##  3 2020-05-15 Berlin              6397       177           55             4
    ##  4 2020-05-15 Brandenburg         3158       148           23            10
    ##  5 2020-05-15 Bremen              1129        37           25             0
    ##  6 2020-05-15 Hamburg             4981       228            5             0
    ##  7 2020-05-15 Hessen              9204       429           35             6
    ##  8 2020-05-15 Mecklenburg-Vo…      740        20            1             0
    ##  9 2020-05-15 Niedersachsen      11087       534           84            10
    ## 10 2020-05-15 Nordrhein-West…    35967      1493          226            10
    ## 11 2020-05-15 Rheinland-Pfalz     6413       213           31             1
    ## 12 2020-05-15 Saarland            2684       147            7             2
    ## 13 2020-05-15 Sachsen             5061       195           30             0
    ## 14 2020-05-15 Sachsen-Anhalt      1668        54           12             2
    ## 15 2020-05-15 Schleswig-Hols…     2988       126            6             1
    ## 16 2020-05-15 Thüringen           2681       135           29             4
    ## # … with 1,146 more rows

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
