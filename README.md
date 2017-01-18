# ```rlaqn```: Data retrieval from the London Air API
Justin Lingard : [prejjnl@gmail.com](prejjnl@gmail.com)  
  



# Overview
```rlaqn``` allows retrieval of data from the [London Air API](http://www.londonair.org.uk/LondonAir/API/), the data feed of the [London Air Quality Network](http://www.londonair.org.uk/LondonAir/Default.aspx), operated by King's College London (KCL). The API provides a structured and convenient way to interact with the data from the LAQN.  Data is supplied in JSON format and does not rely on scraping data from HTML pages.

# Similar packages
+ [```openair```](http://www.openair-project.org/) which provides open-source tools for the analysis of air pollution data
+ [```ropenaq```](https://ropensci.org/tutorials/ropenaq_tutorial.html) which provides UK-AIR latest measured levels (see https://uk-air.defra.gov.uk/latest/currentlevels) as well as data from other countries
+ [```rdefra```](https://github.com/ropenscilabs/rdefra) which allows retrieval of air pollution data from the Defra's Air Information Resource ([UK-AIR](https://uk-air.defra.gov.uk/)).

# Dependencies
The ```rlaqn``` package depends some additional CRAN packages. Check for missing dependencies and install them using the commands below:

```r
> packs <- c('dplyr', 'htmlwidgets', 'jsonlite', 'lattice', 'leaflet', 'mapview')
> new.packages <- packs[!(packs %in% installed.packages()[, 'Package'])]
> if(length(new.packages)) install.packages(new.packages)
```

# Installation
Install the development version from github using devtools:

```r
> devtools::install_github('JustinLingard/rlaqn')
```

Load the ```rlaqn``` package:

```r
> library('rlaqn')
```

# Functions
## ```get_laqn_aq_objectives```
```get_laqn_aq_objectives``` imports pre-calculated air quality statistics from the London Air API for air pollutants for which national [air quality objectives](https://uk-air.defra.gov.uk/assets/documents/National_air_quality_objectives.pdf) exist, this includes:

+ Carbon monoxide, CO
+ Nitrogen dioxide, NO<sub>2</sub>
+ Ozone, O<sub>3</sub>
+ Sulphur dioxide, SO<sub>2</sub>, and
+ Particulate matter, PM<sub>10</sub>.

Statistics are calculated for each air quality monitoring station in the LAQN, on a year-by-year basis. They are available from the inception of the network in 1993, when it was composed of a few stations, to the much larger, current day network. The use of pre-calculated statistics removes the need to caluclate these metrics from raw, hourly data, and ensures good consistency.

NOx (nitrogen oxides) and PM<sub>2.5</sub> statistics are not currently available, but if generated in future, should be picked-up.

Note: *Ratification of the underlying air quality monitoring data, from which the statistics are calculated, is undertaken three to six months in arrears.  Subsequently, statistics for the current year can vary over time and should be viewed as provisional statistics (awaiting final ratification).*

The pre-calculated air quality statistics from the London Air API are comparable to those shown under the air quality objective values and capture rates on the Annual Air Quality Report for each air quality monitoring station in the LAQN, c.f., [Annual Air Quality Report for Westminster - Marylebone Road (01/01/2015 to 01/01/2016)](http://www.erg.kcl.ac.uk/weeklysitereport/asrstats.asp?site=MY1&startdate=1-Jan-2015).

Site meta data, for closed and current air quality monitoring stations in the LAQN, can be obtained using the ```get_laqn_sites``` function, as decsribed below.

```r
> get_laqn_aq_objectives <- function (theGroup = "London", metric = "Annual",
                                      data_type = "MonitoringObjective",
                                      dates = 1980, datee = as.numeric(format(Sys.Date(), "%Y")),
                                      api_type = "Json")
```
By running:

```r
> aq_objectives <- get_laqn_aq_objectives()
```
returns all the air quality objectives since the inception of the network, even when the start year (```dates```) is set to 1980 (prior to commencement of the network) as data isn't retured for years where no data available.

```r
> head(aq_objectives)
  SiteCode                          SiteName         SiteType  Latitude Longitude LatitudeWGS84
1      BG1 Barking and Dagenham - Rush Green         Suburban 51.563752  0.177891 6721627.34498
2      BG1 Barking and Dagenham - Rush Green         Suburban 51.563752  0.177891 6721627.34498
3      BL0               Camden - Bloomsbury Urban Background 51.522287 -0.125848 6714205.47041
4      BL0               Camden - Bloomsbury Urban Background 51.522287 -0.125848 6714205.47041
5      BL0               Camden - Bloomsbury Urban Background 51.522287 -0.125848 6714205.47041
6      BL0               Camden - Bloomsbury Urban Background 51.522287 -0.125848 6714205.47041
  LongitudeWGS84                                                        SiteLink
1  19802.7355367 http://www.londonair.org.uk/london/asp/publicstats.asp?site=BG1
2  19802.7355367 http://www.londonair.org.uk/london/asp/publicstats.asp?site=BG1
3 -14009.3352774 http://www.londonair.org.uk/london/asp/publicstats.asp?site=BL0
4 -14009.3352774 http://www.londonair.org.uk/london/asp/publicstats.asp?site=BL0
5 -14009.3352774 http://www.londonair.org.uk/london/asp/publicstats.asp?site=BL0
6 -14009.3352774 http://www.londonair.org.uk/london/asp/publicstats.asp?site=BL0
                                          DataOwner           DataManager SpeciesCode SpeciesDescription
1                              Barking and Dagenham King's College London         NO2   Nitrogen Dioxide
2                              Barking and Dagenham King's College London         SO2    Sulphur Dioxide
3 Department for Environment Food and Rural Affairs King's College London          CO    Carbon Monoxide
4 Department for Environment Food and Rural Affairs King's College London         NO2   Nitrogen Dioxide
5 Department for Environment Food and Rural Affairs King's College London         NO2   Nitrogen Dioxide
6 Department for Environment Food and Rural Affairs King's College London         NO2   Nitrogen Dioxide
  Year                                                            ObjectiveName Value Achieved
1 1993                                                         Capture Rate (%)    31      YES
2 1993                                                         Capture Rate (%)    30      YES
3 1993                                                         Capture Rate (%)    82      YES
4 1993 200 ug/m3 as a 1 hour mean, not to be exceeded more than 18 times a year     5      YES
5 1993                                               40 ug/m3 as an annual mean    65       NO
6 1993                                                         Capture Rate (%)    93      YES
```
## ```get_laqn_sites```
Site meta data, for closed and current air quality monitoring station in the LAQN, can be obtained using the ```get_laqn_sites``` function, e.g.,

```r
> laqn_sites <- get_laqn_sites()
```

```r
> head(laqn_sites)
  LocalAuthorityCode   LocalAuthorityName SiteCode                              SiteName
1                  1 Barking and Dagenham      BG3   Barking and Dagenham - North Street
2                  1 Barking and Dagenham      BG1     Barking and Dagenham - Rush Green
3                  1 Barking and Dagenham      BG2 Barking and Dagenham - Scrattons Farm
4                  2               Barnet      BN2                     Barnet - Finchley
5                  2               Barnet      BN3             Barnet - Strawberry Vale 
6                  2               Barnet      BN1              Barnet - Tally Ho Corner
          SiteType          DateClosed          DateOpened         Latitude          Longitude
1         Kerbside 2011-05-25 00:00:00 2007-03-16 00:00:00        51.540444           0.074418
2         Suburban                     1999-11-02 00:00:00        51.563752           0.177891
3         Suburban                     1999-10-17 00:00:00        51.529389           0.132857
4 Urban Background 2012-04-20 00:00:00 2000-08-09 13:00:00        51.591901          -0.205992
5 Urban Background 2002-05-15 00:00:00 2000-08-14 14:00:00 51.6008848453589 -0.172297542087178
6         Kerbside 2012-04-20 00:00:00 1998-12-20 12:00:00        51.614675          -0.176607
  LatitudeWGS84 LongitudeWGS84            DataOwner           DataManager
1  6717454.5833  8284.17386585 Barking and Dagenham King's College London
2 6721627.34498  19802.7355367 Barking and Dagenham King's College London
3 6715476.18683  14789.5735883 Barking and Dagenham King's College London
4 6726669.62886 -22930.9245475               Barnet King's College London
5 6728279.54795 -19180.0746501               Barnet King's College London
6 6730751.38494 -19659.8013105               Barnet King's College London
                                                           SiteLink
1 http://www.londonair.org.uk/london/asp/publicdetails.asp?site=BG3
2 http://www.londonair.org.uk/london/asp/publicdetails.asp?site=BG1
3 http://www.londonair.org.uk/london/asp/publicdetails.asp?site=BG2
4 http://www.londonair.org.uk/london/asp/publicdetails.asp?site=BN2
5 http://www.londonair.org.uk/london/asp/publicdetails.asp?site=BN3
6 http://www.londonair.org.uk/london/asp/publicdetails.asp?site=BN1
```
Comparison of the output from ```get_laqn_sites``` with ```importMeta(source = "kcl", all = TRUE)``` from the ```openair``` package reveals some differences. ```importMeta``` returns the meta data for *all* air quality monitoring sites operated by KCL, including those outside London, e.g., those in the [UK Black Carbon network](https://uk-air.defra.gov.uk/networks/network-info?view=ukbsn), and other local authority networks.

```r
> kcl_sites <- openair::importMeta(source = "kcl", all = FALSE)
> head(kcl_sites)
  code                            site                                           Address la_id
1  ST1      Sutton - Robin Hood School Robin Hood Junior School, Thorncroft Road, Sutton    29
2  RY1            Rother - Rye Harbour                                       Rye Harbour   211
3  SB1          South Beds - Dunstable                             Dunstable, South Beds   150
4  EL1   Elmbridge - Bell Farm Hersham                                Bell Farm, Hersham    44
5  EL2   Elmbridge - Esher High Street                                 Esher High Street    44
6  CT6 City of London - Walbrook Wharf              Upper Thames Street / Walbrook Wharf     7
       Authority        site.type os_grid_x os_grid_y latitude  longitude         OpeningDate
1         Sutton         Roadside    525680    164420 51.36574 -0.1955630 1995-04-26 08:00:00
2         Rother            Rural    594283    119082 50.93845  0.7639150 2002-01-11 13:30:00
3   Herts & Beds Urban Background    501906    221822 51.88567 -0.5207337 2000-10-02 07:00:00
4      Elmbridge Urban Background    511403    164915 51.37235 -0.4009194 2001-01-01 00:00:00
5      Elmbridge         Roadside    514024    164792 51.37072 -0.3633206 2005-09-20 01:00:00
6 City of London         Roadside    532527    180789 51.51050 -0.0916340 2007-04-01 01:00:00
          ClosingDate
1 2002-04-26 01:00:00
2                <NA>
3 2010-04-28 01:00:00
4 2009-04-06 01:00:00
5 2008-07-18 09:30:00
6                <NA>
```
# Applications
## ```get_laqn_aq_objectives```
The national air quality objective for hourly NO<sub>2</sub> permits 18 exceedances per year (also termed the *99.8<sup>th</sup>
percentile*). [Defra's Local Air Quality Management Technical Guidance (TG16) document](http://laqm.defra.gov.uk/documents/LAQM-TG16-April-16-v1.pdf) defines the locations at which hourly air quality objectives apply as "... outdoor locations (as defined in Box 1.1 on p.1-8) where they might might reasonably expected to spend one hour or longer." For "Kerbside sites" this includes pavements of busy shopping streets.

Due to high vehicle numbers and congestion on London's roads, road transport NOx emissions are high, especially in the vicinity of heavily trafficked roads, leading to elevated roadside NO<sub>2</sub> concentrations. Consequently, this objective is exceeded at a number of roadside throughout the UK and in London. Some examples are given below.

The air quality monitoring station at Marylebone Road (Westminster - Marylebone Road Kerbside, MY1) is located next to the six lane A501. Frequent elevated hourly NO~2~ concentrations occur due to the high vehicle flows along the road which is an important thoroughfare in central London, running east-west from the Euston Road at Regent's Park, to the A40 Westway at Paddington.

Some words about Oxford Street

```r
> # Load the plyr package
> library(dplyr)
> westminster_sites <- aq_objectives %>% filter(SiteCode == "MY1" | SiteCode == "WM6" & ObjectiveName == "200 ug/m3 as a 1 hour mean, not to be exceeded more than 18 times a year")
```
Frequent elevated hourly NO~2~ concentrations occur on Putney High Street, the A209, as well.  Two air quality monitroing stations are located here: The first is Wandsworth - Putney High Street (WA7), the second Wandsworth - Putney High Street Facade (WA8). Putney High Street links traffic passing over Putney Bridge from central London to the South Circular Road (A205) and Upper Richmond Road, two major arterial roads in south London. Putney High Street has been described by some, as the most polluted street in south London.

```r
> putney_sites <- aq_objectives %>% filter(SiteCode == "WA7" | SiteCode == "WA8"& ObjectiveName == "200 ug/m3 as a 1 hour mean, not to be exceeded more than 18 times a year")
```
Combining the two sets of data provides an intercomparison of the number of exceedances of the hourly NO~2~ national air quality objective at the two air quality monitoring stations located on these roads by year over the past twenty years. Data for 2017 has been removed and data for 2016 should be taken as provisional.

```r
> theData <- plyr::rbind.fill(marylebone_road, putney_sites)
> lattice::barchart(factor(Year) ~ Value | SiteName, data = theData,
                  xlab = "Number of exceedances", origin = 0))
```

![](README_files/figure-html/unnamed-chunk-14-1.png)<!-- -->
Hourly NO<sub>2</sub> concentrations at all sites exceed the national air quality objective as the number of exceedances is more than the 18 permitted per year.  Whilst the number of exceedances at both sites has fallen in recent years the number of exceedances on Putney High Street was 1443 in 2015 year, whilst the number at Marylebone Road was 56.

## ```get_laqn_sites```
To view the location of the air quality monitoring stations in the LAQN at Marylebone Road, Oxford Street and Putney High Street use the ouput from ```get_laqn_sites```.

Note: *The two sites in Putney appear coincident when plotted at *```zoom = 12``` as given in the code below.

```r
> #  Select theSites
> theSites <- laqn_sites %>% filter(DateClosed == "" & SiteCode == "MY1" | SiteCode == "WM6" | SiteCode == "WA7" | SiteCode == "WA8")
> # Load the leaflet package
> library(leaflet)
> m <- leaflet() %>%
> setView(lng = -0.17, lat = 51.5, zoom = 12) %>%
  addTiles() %>%
  addMarkers(lng = theSites$Longitude,
             lat = theSites$Latitude,
             popup = paste(theSites$SiteName, theSites$SiteLink, sep = ", "))
> m  # Print the map
```



