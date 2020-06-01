Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-06-01

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

    ## # A tibble: 1,434 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-06-01 Baden-Württemb…    34784      1752           66          1752
    ##  2 2020-06-01 Bayern             47004      2451           87          2451
    ##  3 2020-06-01 Berlin              6816       198           16           198
    ##  4 2020-06-01 Brandenburg         3273       155            2           155
    ##  5 2020-06-01 Bremen              1398        42            0            42
    ##  6 2020-06-01 Hamburg             5089       253            2           253
    ##  7 2020-06-01 Hessen             10047       480           14           480
    ##  8 2020-06-01 Mecklenburg-Vo…      761        20            0            20
    ##  9 2020-06-01 Niedersachsen      12043       593           51           593
    ## 10 2020-06-01 Nordrhein-West…    38046      1598           46          1598
    ## 11 2020-06-01 Rheinland-Pfalz     6703       230            9           230
    ## 12 2020-06-01 Saarland            2724       163            0           163
    ## 13 2020-06-01 Sachsen             5309       214            5           214
    ## 14 2020-06-01 Sachsen-Anhalt      1706        55            1            55
    ## 15 2020-06-01 Schleswig-Hols…     3097       145            3           145
    ## 16 2020-06-01 Thüringen           3015       162           31           162
    ## # … with 1,418 more rows

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
