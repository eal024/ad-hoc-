

library(tidyverse);library(broom)

vignette("broom") # messy output of lm/nls/t.test and turn tehm into tidy df

lmfit <- lm( mpg ~wt,  data  = mtcars)

# this is enough when just reading the result. But cant use the output 
summary(lmfit)

library(broom);

#
tidy(lmfit)

# 
augment(lmfit)

# 
glance(lmfit)



# Other example -----------------------------------------------------------

glmfit <- glm( am ~ wt, mtcars, family = "binomial")

summary(glmfit)

tidy(glmfit)

augment(glmfit)

# non-linear models:
nlsfit <- nls(mpg ~ k / wt + b, mtcars, start=list(k=1, b=0))

tidy(nlsfit)

augment(nlsfit)

glance(nlsfit)






