#### Preamble ####
# Purpose: Models the relationship between different economic indicators and vehicle thefts 
#          using regression analysis to identify significant predictors.
# Author: Siqi Fei
# Date: 05 April 2024
# Contact: fermi.fei@mail.utoronto.ca
# License: MIT
# Pre-requisites: The script requires the 'tidyverse', 'lubridate', and 'caret' packages for data 
#                 manipulation, date handling, and machine learning modeling.
# Additional Notes: This script assumes the data has been preprocessed and is ready for modeling.


#### Workspace setup ####
#install.packages("rstanarm")
#install.packages("tidyverse")
#install.packages("rstan")
#install.packages("modelsummary")
library(tidyverse)
library(rstanarm)
library(rstan)
library(modelsummary)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
# Bayesian multiple linear regression model including all CPI categories
bayesian_linear_model <- stan_glm(Total_Vehicle_Thefts ~ All_items + 
                                    Recreation_education_and_reading + 
                                    Goods + Household_operations_furnishings_equipment + 
                                    Health_and_personal_care +
                                    Transportation + 
                                    Shelter + Services + Food + Alcoho_tobacco_cannabis +
                                    Energy + Gasoline + Clothing_footwear,
                                  data = analysis_data,
                                  family = gaussian(),  # Assuming the dependent variable is continuous
                                  prior = normal(0, 2.5, autoscale = TRUE),  # Normal priors for coefficients
                                  prior_intercept = normal(0, 2.5, autoscale = TRUE),  # Normal prior for the intercept
                                  chains = 4, iter = 2000)

# Summarize the model to view coefficients and diagnostics
print(summary(bayesian_linear_model))

# Diagnostic plots for the Bayesian regression model
plot(bayesian_linear_model)

# If you need to create a more detailed summary with 'modelsummary'
modelsummary(bayesian_linear_model)

#### Save model ####
saveRDS(
  bayesian_linear_model,
  file = "models/bayesian_linear_model.rds"
)

