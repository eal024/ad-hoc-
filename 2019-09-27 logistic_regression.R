
library(tidyverse);

# load data ---------------------------------------------------------------

train_raw <- read_csv("train.csv");

# Look for na
sapply(train_raw, function(x) {sum(is.na(x)) } )

# Look for unique 
sapply(train_raw, function(x) {length(unique(x)) } )

# Looking for missing values:

Amelia::missmap(train_raw, main = "Mssing vs. observ")

train_raw

typeof(train_raw$Sex);

lm( Age ~Sex , data = train_raw) %>% summary

train_raw %>% filter(Sex == "male") %>% summary()

train_raw %>% select(-Cabin, -Name, -Ticket  )%>% 
  filter(!is.na(Sex) )-> train_clean


train_clean$Age[is.na(train_clean$Age)] <- mean(train_clean$Age, na.rm = T)

train_clean <- filter(train_clean, !is.na(Embarked) )

sapply(train_clean, function(x) {sum(is.na(x)) } )

model <- glm( Survived ~ ., family = binomial(link = "logit"),   data = train_clean)

model %>% summary()

