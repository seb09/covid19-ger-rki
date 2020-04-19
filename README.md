Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-19

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

    ## # A tibble: 746 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-19 Baden-Württemb…    27883       968          625            49
    ##  2 2020-04-19 Bayern             37407      1256          526            58
    ##  3 2020-04-19 Berlin              5159        92           93             1
    ##  4 2020-04-19 Brandenburg         2221        66           60             4
    ##  5 2020-04-19 Bremen               585        25           18             1
    ##  6 2020-04-19 Hamburg             4167        91           49             1
    ##  7 2020-04-19 Hessen              7108       230          192            18
    ##  8 2020-04-19 Mecklenburg-Vo…      651        15            6             1
    ##  9 2020-04-19 Niedersachsen       8797       288          148             7
    ## 10 2020-04-19 Nordrhein-West…    28471       814          465            23
    ## 11 2020-04-19 Rheinland-Pfalz     5432       106          108             7
    ## 12 2020-04-19 Saarland            2303        91           14             5
    ## 13 2020-04-19 Sachsen             4190       107           50             4
    ## 14 2020-04-19 Sachsen-Anhalt      1350        30           35             1
    ## 15 2020-04-19 Schleswig-Hols…     2417        62           30             1
    ## 16 2020-04-19 Thüringen           1756        53           39             3
    ## # … with 730 more rows

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
