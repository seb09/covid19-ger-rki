Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-24

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

    ## # A tibble: 826 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-24 Baden-Württemb…    29792      1153          349            40
    ##  2 2020-04-24 Bayern             39939      1525          544            49
    ##  3 2020-04-24 Berlin              5459       112          135             7
    ##  4 2020-04-24 Brandenburg         2536        90           89             6
    ##  5 2020-04-24 Bremen               707        27           35             0
    ##  6 2020-04-24 Hamburg             4358       122           72             9
    ##  7 2020-04-24 Hessen              7712       296          119            10
    ##  8 2020-04-24 Mecklenburg-Vo…      661        16            2             1
    ##  9 2020-04-24 Niedersachsen       9544       364          153            24
    ## 10 2020-04-24 Nordrhein-West…    31106      1052          522            53
    ## 11 2020-04-24 Rheinland-Pfalz     5731       136           88             5
    ## 12 2020-04-24 Saarland            2445       105           50             6
    ## 13 2020-04-24 Sachsen             4377       135           50             8
    ## 14 2020-04-24 Sachsen-Anhalt      1436        35           11             1
    ## 15 2020-04-24 Schleswig-Hols…     2557        88           27             4
    ## 16 2020-04-24 Thüringen           2023        65           91             4
    ## # … with 810 more rows

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
