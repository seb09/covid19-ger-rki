Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-03

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

    ## # A tibble: 490 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-03 Baden-Württemb…    16059       285         1397            44
    ##  2 2020-04-03 Bayern             20237       307         1741            39
    ##  3 2020-04-03 Berlin              3202        20          232             1
    ##  4 2020-04-03 Brandenburg         1075         9           80             2
    ##  5 2020-04-03 Bremen               341         6           14             0
    ##  6 2020-04-03 Hamburg             2596        16          190             2
    ##  7 2020-04-03 Hessen              3993        33          286             6
    ##  8 2020-04-03 Mecklenburg-Vo…      468         4           30             1
    ##  9 2020-04-03 Niedersachsen       5081        65          386            20
    ## 10 2020-04-03 Nordrhein-West…    16606       178         1179            17
    ## 11 2020-04-03 Rheinland-Pfalz     3362        26          230             0
    ## 12 2020-04-03 Saarland            1079        12           59             1
    ## 13 2020-04-03 Sachsen             2336        21          153             3
    ## 14 2020-04-03 Sachsen-Anhalt       836        11           32             3
    ## 15 2020-04-03 Schleswig-Hols…     1443        15          108             4
    ## 16 2020-04-03 Thüringen            982         9           57             2
    ## # … with 474 more rows

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

I’ll try to update the data daily and produce a plot from time to time.
Most plots will probably be in German. You’re welcome to use them.

-----

<img src="plots/covid19-deu-rki-entwicklung.png">
