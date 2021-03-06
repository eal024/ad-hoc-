

library(data.table)


# Basic DT
DT = data.table(
  ID = c("b","b","b","a","a","c"),
  ID2 = c("bb", "bb", "ba", "aa", "a", "c"),
  a = 1:6,
  b = 7:12,
  c = 13:18
)

# Data-example
DT_economics <- data.table(economics)



# Importing data: 

# When printing data, head = 6, tail = 5
# getOption("datatable.print.nrows")
# choose nrow -> options( datatable.print.nrows = 50)


# Vignettes: 
vignette(package="data.table") 

# Several are avilible, start with the intro:
vignette("datatable-intro")



# Basic syntax

# oder by, select | update , group_by
DT[i              , j      , by]

# compacted
DT[i, j, by]


# order and filter
DT[ i = order(-ID) & ! ID %in% c("a","d"), ][]
DT_economics[, date := lubridate::ymd(date)][]
DT_economics[, year := lubridate::year(date)][]

# pull
DT[ i = order(-ID) & ! ID %in% c("a","d"), j =  a][] %>% str()

# example 2
DT_economics[, j = year]

# or-direct
DT[,c]

# or return it as a data.table
DT[, list(new_a =a,new_b = b)] 
# eqivalent to 
DT[ , .(new_a = a, new_b = b)]



# slice
DT[seq(1:3)]
DT[c(1,3,5,6)]




# Spesial symbol .N -------------------------------------------------------

# .N number of observation
DT[, .N]

# Usefull when combind with by
DT[, .N , by = ID]
DT[, .N ,by = .(ID, ID2)]

# With filter:
DT[ a > 2, .N ,by = .(ID, ID2)]



# Example 2
library(gapminder)

gap_DT <- gapminder::gapminder %>% as.data.table()

gap_DT[ , .N, by = .(country) ][]


# statiscal calculation ---------------------------------------------------
DT[a > 1, 
   .(mean_a  = mean(a), mean_b =  mean(b)),
   by = .(ID, ID2) ][]

# ?
gap_DT[ country %in% c("Norway", "Swedon"), ][, decade := (year - year%%10)] [,':=' (mean_gdp = mean(gdpPercap, na.rm  = T) )  , by = .(country,decade) ][]
# change the dataset
gap_DT[  , ][, decade := (year - year%%10)]


gap_DT[ , map(.SD, function(x) {mean(x,na.rm = T)} ),
        by = .(country,decade) ,
        .SDcols = c("lifeExp", "pop")][] 
# -> DT_graph


#DT_graph %>% ggplot( aes(x = decade, y = pop/10^6)) + geom_col() + facet_wrap(~country, scales = "free")


# Sorted: by:keyby --------------------------------------------------------

# Setting a key for a data.table will allow for various (and often astonishing) performance gains1

# Alternativ ways of setting keys
DT <- data.table( x = 1:10, LETTERS[1:10], key = "x")
setDT(DT, key = "x")


setkey(DT, x)

DT %>% str()

# Key describe a ordering of the data, you can set a key on muliple columns
DT <- data.table(DT[, y := sample(c(0,1), size = 10, replace = T) ], key =c("x", "y")) 
setkey(DT, x,y)


# Example 3 
flights <- fread("https://raw.githubusercontent.com/Rdatatable/data.table/master/vignettes/flights14.csv")

flights[ carrier == "AA",
         .(avg_arr_del = mean(arr_delay), avg_arr_dep_del = mean(dep_delay)),
         keyby = .(origin, dest, month)][]


flights %>% filter( carrier == "AA") %>% group_by(origin, dest, month) %>% summarise( avg_arr_del = mean(arr_delay), avg_dep_del = mean(dep_delay) )




# "datatable-keys-fast-subse"t --------------------------------------------













# -------------------------------------------------------------------------

keep(gap_DT, is.numeric) [, map_if(.SD, is.numeric, function(x) {mean(x, na.rm  = T)})]























