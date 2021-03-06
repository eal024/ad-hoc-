

library(tidyverse)
library(data.table)
library(microbenchmark)
library(tidyfast)
library(dtplyr)
# -------------------------------------------------------------------------

data("starwars")

starwars %>% filter(species == "Human") %>%
  group_by(homeworld) %>% 
  summarise(mean_height = mean(height, na.rm = T))


# Data table
starwars_dt <- as.data.table(starwars)

starwars_dt %>% names()

starwars_dt[, species == "Human",  mean(height, na.rm  = T), by = homeworld]


storms %>% group_by(name,year,month,day) %>% 
  summarise( wind = mean(wind, na.rm = T), pressure = mean(pressure, na.rm = T))

as.data.table(storms)[,.(wind = mean(wind), mean_pressure = mean(pressure) ),
                           by = .(name,year,month,day)]



# data.table syntax -------------------------------------------------------

#DT[i, j, by ] :row, what to do; groyp_by
              #:filter/arrange; select/mutate; group_by


starwars_dt[
  # row
  species == "Human",
  # mutate
  mean(height, na.rm = T),
  by = gender
]

# rows:
starwars_dt[species == "Human"]

as.data.table(mtcars)[1:10, ] 
as.data.table(mtcars)[am == 1, ] 
as.data.table(mtcars)[mpg < 20 &  am == 1, ] 

# arrange
as.data.table(mtcars)[ order(mpg)  ][seq(1:10),1:3] 
as.data.table(mtcars)[ order(mpg) ] [seq(1:10), 1:4]

# Setorder
setorder(as.data.table(mtcars), cyl, na.last = T)

head(mtcars)[, 1:4]


# manipulation ------------------------------------------------------------

#select, mutate, summarise and count
# add,d elete or change columns in data.table :=

mtcars <- as.data.table(mtcars)

mtcars[, `:=` (famcyl = factor(cyl), data = c("mtcars") ), ]


# summaries
mtcars[, `:=` (mean = mean(cyl), sum = sum(drat) ), by = am ]

mtcars[,.(mpg, cyl, mean ,am)] %>% head()

# see the changes in print add ->  []
setorder( mtcars[, `:=`(mean_disp = mean(disp), sum_disp = sum(disp)), by = cyl], cyl, sum_disp) []


DF <- data.table( name = LETTERS[seq(1:10)], value = rnorm(10, mean = 10, sd = 2 ) , big_sum = seq(from =  10, to =  100, length.out = 10))

setorder( DF[, x_sq := big_sum^2], big_sum)[]

DF[ , index := seq(1:nrow(DF))][]

DF[ index%%2 == 0  , ][]



# modify mulitple columns := (count) --------------------------------------







