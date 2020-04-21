Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-21

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

    ## # A tibble: 778 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-21 Baden-Württemb…    28712      1031          459            49
    ##  2 2020-04-21 Bayern             38310      1336          461            50
    ##  3 2020-04-21 Berlin              5237        97           41             3
    ##  4 2020-04-21 Brandenburg         2275        67           37             1
    ##  5 2020-04-21 Bremen               609        25            5             0
    ##  6 2020-04-21 Hamburg             4204        91           19             0
    ##  7 2020-04-21 Hessen              7231       251           54            11
    ##  8 2020-04-21 Mecklenburg-Vo…      655        15            2             0
    ##  9 2020-04-21 Niedersachsen       9098       306          198            15
    ## 10 2020-04-21 Nordrhein-West…    29389       896          418            39
    ## 11 2020-04-21 Rheinland-Pfalz     5561       116           38             9
    ## 12 2020-04-21 Saarland            2328        93           14             2
    ## 13 2020-04-21 Sachsen             4253       117           24             8
    ## 14 2020-04-21 Sachsen-Anhalt      1383        32           14             2
    ## 15 2020-04-21 Schleswig-Hols…     2414        70          -12             3
    ## 16 2020-04-21 Thüringen           1798        55           13             2
    ## # … with 762 more rows

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
