Data from the Robert-Koch-Institut on COVID-19 in Germany
================
Last update: 2020-04-02

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

    ## # A tibble: 474 x 6
    ##    Datum      Bundesland      Fallzahl Todeszahl Fallzahl_neu Todeszahl_neu
    ##    <date>     <chr>              <dbl>     <dbl>        <dbl>         <dbl>
    ##  1 2020-04-02 Baden-Württemb…    14662       241         1252            44
    ##  2 2020-04-02 Bayern             18496       268         1999            43
    ##  3 2020-04-02 Berlin              2970        19          216             3
    ##  4 2020-04-02 Brandenburg          995         7          114             3
    ##  5 2020-04-02 Bremen               327         6           16             1
    ##  6 2020-04-02 Hamburg             2406        14           95             0
    ##  7 2020-04-02 Hessen              3707        27          262             6
    ##  8 2020-04-02 Mecklenburg-Vo…      438         3           32             0
    ##  9 2020-04-02 Niedersachsen       4695        45          313             3
    ## 10 2020-04-02 Nordrhein-West…    15427       161         1076            27
    ## 11 2020-04-02 Rheinland-Pfalz     3132        26          233             3
    ## 12 2020-04-02 Saarland            1020        11          191             3
    ## 13 2020-04-02 Sachsen             2183        18          149             1
    ## 14 2020-04-02 Sachsen-Anhalt       804         8           54             1
    ## 15 2020-04-02 Schleswig-Hols…     1335        11           89             1
    ## 16 2020-04-02 Thüringen            925         7           65             1
    ## # … with 458 more rows

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
