Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-06-07

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

    ## # A tibble: 1,530 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-06-07 Baden-Württemb…    34912      1791           14             1
    ##  2 2020-06-07 Bayern             47334      2501            8            12
    ##  3 2020-06-07 Berlin              6997       205           33             4
    ##  4 2020-06-07 Brandenburg         3297       158            3             0
    ##  5 2020-06-07 Bremen              1517        44            4             0
    ##  6 2020-06-07 Hamburg             5113       254            2             0
    ##  7 2020-06-07 Hessen             10203       484           32             1
    ##  8 2020-06-07 Mecklenburg-Vo…      773        20            7             0
    ##  9 2020-06-07 Niedersachsen      12466       605           67             0
    ## 10 2020-06-07 Nordrhein-West…    38616      1623           92             1
    ## 11 2020-06-07 Rheinland-Pfalz     6775       230           14             0
    ## 12 2020-06-07 Saarland            2747       166            7             0
    ## 13 2020-06-07 Sachsen             5323       214            2             2
    ## 14 2020-06-07 Sachsen-Anhalt      1720        56            3             1
    ## 15 2020-06-07 Schleswig-Hols…     3109       147            2             0
    ## 16 2020-06-07 Thüringen           3077       170           11             0
    ## # … with 1,514 more rows

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
