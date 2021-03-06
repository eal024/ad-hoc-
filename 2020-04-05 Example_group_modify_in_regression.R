

library(dplyr)
library(broom)


iris %>% 
  group_by(Species) %>% 
  group_modify( ~tidy(lm(Petal.Width ~Sepal.Width, data = .)))

# gtrends

library(gtrendsR)

google_trends_df <- gtrends(
  c("Harstad"),
  gprop = "web",
  #geo = c("all"),
  time = "today 12-m")[[1]]


list_harstad <- gtrends(
  c("Harstad"),
  gprop = "web",
  #geo = c("all"),
  time = "2010-01-01 2019-01-01")[[4]]

    

google_trends_df %>% ggplot2::ggplot( aes(x = date, y = hits)) + geom_point()

