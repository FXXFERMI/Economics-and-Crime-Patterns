#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Siqi Fei
# Date: 05 April 2024
# Contact: fermi.fei@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
#install.packages("rstanarm")
#install.packages("tidyverse")
#install.packages("rstan")
library(tidyverse)
library(rstanarm)
library(rstan)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
# Linear regression model including all CPI categories
linear_model <- lm(Total_Vehicle_Thefts ~ Recreation_education_and_reading + 
                     Goods + Household_operations_furnishings_equipment + 
                     All_items_excluding_food_and_energy + Health_and_personal_care +
                     All_items_excluding_energy + All_items + Transportation + 
                     Shelter + Services + Food + Alcoho_tobacco_cannabis +
                     Energy + Gasoline + Clothing_footwear,
                   data = analysis_data)


# Summarize the model to view coefficients and statistics
summary(linear_model)

# Diagnostic plots for the regression model
par(mfrow = c(2, 2))
plot(linear_model)

# If not already installed
# install.packages("stargazer")
library(stargazer)

# Create a nice HTML or text table of your model's results
stargazer(linear_model, type = "text")




#### Save model ####
#saveRDS(
# first_model,
#file = "models/first_model.rds"
#)
