Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-12

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

    ## # A tibble: 634 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-12 Baden-Württemb…    24078       649          461            27
    ##  2 2020-04-12 Bayern             32282       786          829            39
    ##  3 2020-04-12 Berlin              4567        50          109             4
    ##  4 2020-04-12 Brandenburg         1857        38           93             1
    ##  5 2020-04-12 Bremen               480        15           11             0
    ##  6 2020-04-12 Hamburg             3742        56           79             0
    ##  7 2020-04-12 Hessen              5859       123           51             3
    ##  8 2020-04-12 Mecklenburg-Vo…      605        11            4             0
    ##  9 2020-04-12 Niedersachsen       7602       189          259            18
    ## 10 2020-04-12 Nordrhein-West…    24267       495          623            23
    ## 11 2020-04-12 Rheinland-Pfalz     4734        64          112             5
    ## 12 2020-04-12 Saarland            2058        43           42             2
    ## 13 2020-04-12 Sachsen             3600        67           35             2
    ## 14 2020-04-12 Sachsen-Anhalt      1166        21           31             3
    ## 15 2020-04-12 Schleswig-Hols…     2118        41           53             2
    ## 16 2020-04-12 Thüringen           1464        25           29             0
    ## # … with 618 more rows

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
