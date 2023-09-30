### Load dataframe
df <- read_excel("Stradbroke Data.xlsx") 

### Load packages
install.packages("DHARMa")
library(DHARMa)

install.packages("lme4")
library(lme4)

### Poisson Regression (GLM):
# Use a Poisson regression when your abundance data follows a Poisson distribution, which is appropriate for count data.
# Suitable when the variance is roughly equal to the mean.
# Assumes a log-linear relationship between the predictors and the mean of the response variable

## Model 1
# Example: glm_abundance <- glm(abundance ~ categorical_var + numerical_var, family = poisson, data = your_data)

model1 <- glm(num ~ pH*time, data = df, family = "poisson") # glm model with pH and time
summary(model1)

res <- simulateResiduals(model1) # check the dispersion of the data
plot(res) # data looks terrible because our abundance is messy and includes different species and "total"

### Mixed Model Regression (GLMM):
# Again, use Poisson regression because we have abundance data 
# include both fixed and random variables
# time is fixed because it was a vairable we chose and manipulated
# variables such as pH, salinity and temp are random because we cannot control for them

## Model 2
abundance_num <- subset(df, organism == "total") # only use total abundance 

model2 <- glmer(num ~ time + (1|pH), family = "poisson", data = abundance_num)
summary(model2)

res3 <- simulateResiduals(model3) 
plot(res3)

## Model 3 
prawns <- subset(df, organism == 'prawn') # only use prawn abundance 
model3 <- glmer(num ~ time + (1|pH), family = "poisson", data = abundance_num)
summary(model3)

res3 <- simulateResiduals(model3) 
plot(res3) # looks good

## Model 4
goby <- subset(df, organism == 'goby') # only use goby abundance 
model4 <- glmer(num ~ time + (1|pH), family = "poisson", data = abundance_num)
summary(model4)

res4 <- simulateResiduals(model4) 
plot(res4)  # looks good



