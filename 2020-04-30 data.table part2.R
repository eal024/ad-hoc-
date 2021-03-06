

library(data.table)
library(tidyverse)


mtcars <- as.data.table(mtcars)

mtcars %>% head()

# Basic syntax ------------------------------------------------------------

#DT[i, j, by ] :row, what to do; groyp_by
#:filter/arrange; select/mutate; group_by


mtcars[ cyl == 8 ][]

mtcars[ , famam := factor(am)][]

# Like this;
mtcars[, c("famcyl", "famam") := .(factor(cyl), factor(am))][]
# or
mtcars[, ':=' (
  famcyl = factor(cyl),
  famam = factor(am),
  index = seq(1:nrow(mtcars)),
  index2 = row.names(mtcars)
)][]

# Dynamic assignment does`t work; cant use index in index2 (see example above)

# Chaining multiple data.table opeations together:
DT <- data.table(a = seq(1,2))
DT[, z := 5:6][,z_2 := z^2] []

# OR:
DT %>% .[ ,xy := 10*z] %>% .[]


# Remove columns =>
DT[, xy :=NULL][]


# Subsetting columns (filter) ---------------------------------------------
#DT[i, j, by ] ->  row;    what to do;   groyp_by
 
DT <-  DT %>% bind_rows(DT) %>% bind_rows(DT) %>% as.data.table()


DT[seq(1:10), c(1,3)][]
DT[ (a == 2 |z ==5 ), c(1:3)][]



# . -> stands for ---------------------------------------------------------

# .(var1, var2, ...)
# list(var1, var2, ...)
# c("var1", "var2", ...)

# I like the .() syntax best — less typing! — but each to their own.



# group_by and count ------------------------------------------------------

starwars <- as.data.table(starwars) 
starwars %>% class()

starwars %>% head()

# Count
starwars[, .N]

# group_by
starwars[  , by = skin_color, .N][] %>% arrange(desc(N) )
starwars[  , by = skin_color, .N] [  ] %>% head()


starwars[  ,species_n := .N, by =species][] 

# group_by (aggregation) by multiple variables

starwars[, .(mean_heigth = mean(height, na.rm = T)), by =.(species, homeworld) ] %>% head()
  
# sum multiple variables, by group

starwars[, .( avg_height = mean(height, na.rm = T), avg_mass = mean(mass, na.rm =T)), by =.(species, homeworld) ] %>%
  arrange(homeworld) %>% 
  head(n = 10)



# The .SD ->  -------------------------------------------------------------














