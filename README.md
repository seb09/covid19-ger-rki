Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-05-11

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

    ## # A tibble: 1,098 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-05-11 Baden-Württemb…    33190      1545          -97             3
    ##  2 2020-05-11 Bayern             44368      2155          103             2
    ##  3 2020-05-11 Berlin              6272       165           11             0
    ##  4 2020-05-11 Brandenburg         3106       134            5             0
    ##  5 2020-05-11 Bremen              1055        34           12             2
    ##  6 2020-05-11 Hamburg             4780       204            8             0
    ##  7 2020-05-11 Hessen              9012       412           14             1
    ##  8 2020-05-11 Mecklenburg-Vo…      728        19            2             0
    ##  9 2020-05-11 Niedersachsen      10854       498           27             0
    ## 10 2020-05-11 Nordrhein-West…    35132      1437          168            12
    ## 11 2020-05-11 Rheinland-Pfalz     6313       195           22             0
    ## 12 2020-05-11 Saarland            2665       142            2             0
    ## 13 2020-05-11 Sachsen             4915       187           29             0
    ## 14 2020-05-11 Sachsen-Anhalt      1643        48            3             0
    ## 15 2020-05-11 Schleswig-Hols…     2957       124           19             1
    ## 16 2020-05-11 Thüringen           2585       118           29             1
    ## # … with 1,082 more rows

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
