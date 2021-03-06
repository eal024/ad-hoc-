

# A data.table example

library(data.table);library(tidyverse)


DT_economics <- data.table(economics)

# filter; only want to see observation after 1980;

DT_economics[ date > lubridate::ymd("1970-12-31"), ][]

# Create a new variabel:
DT_economics[ , year := lubridate::year(date) ][]

# Create several variables
DT_economics[ , ':=' (year = lubridate::year(date), month = lubridate::month(date) ) ][]

# See -> the DT is modifyed, without assignment <-
DT_economics[]



# statistic ---------------------------------------------------------------


