Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-26

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

    ## # A tibble: 858 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-26 Baden-Württemb…    30761      1237          592            48
    ##  2 2020-04-26 Bayern             40912      1596          365            30
    ##  3 2020-04-26 Berlin              5600       123           75            10
    ##  4 2020-04-26 Brandenburg         2694       100           67             3
    ##  5 2020-04-26 Bremen               739        27           20             0
    ##  6 2020-04-26 Hamburg             4429       140           29             1
    ##  7 2020-04-26 Hessen              7946       315          109            10
    ##  8 2020-04-26 Mecklenburg-Vo…      673        16            6             0
    ##  9 2020-04-26 Niedersachsen       9785       384           94             7
    ## 10 2020-04-26 Nordrhein-West…    31669      1096          204            12
    ## 11 2020-04-26 Rheinland-Pfalz     5835       147           68             9
    ## 12 2020-04-26 Saarland            2482       107           14             0
    ## 13 2020-04-26 Sachsen             4428       147           22             6
    ## 14 2020-04-26 Sachsen-Anhalt      1494        36           14             1
    ## 15 2020-04-26 Schleswig-Hols…     2630        96           18             1
    ## 16 2020-04-26 Thüringen           2098        73           40             2
    ## # … with 842 more rows

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
