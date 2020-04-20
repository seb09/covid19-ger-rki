Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-20

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

    ## # A tibble: 762 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-20 Baden-Württemb…    28253       982          370            14
    ##  2 2020-04-20 Bayern             37849      1286          442            30
    ##  3 2020-04-20 Berlin              5196        94           37             2
    ##  4 2020-04-20 Brandenburg         2238        66           17             0
    ##  5 2020-04-20 Bremen               604        25           19             0
    ##  6 2020-04-20 Hamburg             4185        91           18             0
    ##  7 2020-04-20 Hessen              7177       240           69            10
    ##  8 2020-04-20 Mecklenburg-Vo…      653        15            2             0
    ##  9 2020-04-20 Niedersachsen       8900       291          103             3
    ## 10 2020-04-20 Nordrhein-West…    28971       857          500            43
    ## 11 2020-04-20 Rheinland-Pfalz     5523       107           91             1
    ## 12 2020-04-20 Saarland            2314        91           11             0
    ## 13 2020-04-20 Sachsen             4229       109           39             2
    ## 14 2020-04-20 Sachsen-Anhalt      1369        30           19             0
    ## 15 2020-04-20 Schleswig-Hols…     2426        67            9             5
    ## 16 2020-04-20 Thüringen           1785        53           29             0
    ## # … with 746 more rows

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
