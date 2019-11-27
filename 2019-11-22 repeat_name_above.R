



library(tidyverse);


df <-  tibble(
  x = c(
    "Eirik",
    NA_real_,
    NA_real_,
    "Trond",
    NA_real_ ,
    "Christoffer",
    NA_real_
  ),
  y = seq(1:length(x))
)


nrow(df)
x <- vector(mode = "character", 0)
var <- select(df, x) %>% pull()
j <- 1
for(i in 1:length(var) )  {
  
  if(!is.na(var[i]) ) {
   y <- var[i]
   print(var[i])
  }
  
  x[j] = y;
  j = j+1
  print(str_c(y, "og j er", j))
}

x

library(rlang)

repeat_char <- function(df, z) {
  
  # valgt variabel i df
  var <- pull(select(df,!!enquo(z)) )
  # tom variabel 
  x <- vector(mode = "character", 0)
  
  x <- var

  j <- 1
  for(i in 1:length(var) )  {

    if(!is.na(var[i]) ) {
      y <- var[i]
    }

    x[j] = y;
    j = j+1
  }
  return(x)
}
 
repeat_char(df, x)

df %>% 
  mutate( z = repeat_char(., x))







