Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-29

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

    ## # A tibble: 906 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-29 Baden-Württemb…    31336      1299          140            30
    ##  2 2020-04-29 Bayern             41830      1754          424            73
    ##  3 2020-04-29 Berlin              5734       137           65            10
    ##  4 2020-04-29 Brandenburg         2768       109           21             3
    ##  5 2020-04-29 Bremen               797        29           38             2
    ##  6 2020-04-29 Hamburg             4525       153           20            11
    ##  7 2020-04-29 Hessen              8184       346          158            13
    ##  8 2020-04-29 Mecklenburg-Vo…      687        17           12             0
    ##  9 2020-04-29 Niedersachsen       9972       406           46            12
    ## 10 2020-04-29 Nordrhein-West…    32429      1200          245            29
    ## 11 2020-04-29 Rheinland-Pfalz     5982       161           54             4
    ## 12 2020-04-29 Saarland            2514       129            5             6
    ## 13 2020-04-29 Sachsen             4509       153           19             5
    ## 14 2020-04-29 Sachsen-Anhalt      1525        39            5             0
    ## 15 2020-04-29 Schleswig-Hols…     2679       103           26             2
    ## 16 2020-04-29 Thüringen           2170        80           26             2
    ## # … with 890 more rows

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

<img src="plots/covid19-deu-rki-entwicklung-original-skala.png">

[Full
size](https://github.com/seb09/covid19-ger-rki/raw/master/plots/covid19-deu-rki-entwicklung-original-skala.png)

-----

<img src="plots/covid19-deu-rki-faelle-pro-tag.png">

[Full
size](https://github.com/seb09/covid19-ger-rki/raw/master/plots/covid19-deu-rki-faelle-pro-tag.png)
