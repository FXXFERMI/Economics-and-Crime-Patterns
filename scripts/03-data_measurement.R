#### Preamble ####
# Purpose: Prepares and cleans the dataset for analysis, including handling missing values, 
#          normalizing data, and creating derived variables for further analysis.
# Author: Siqi Fei
# Date: 05 April 2024
# Contact: fermi.fei@mail.utoronto.ca
# License: MIT
# Pre-requisites: This script requires 'tidyverse' for data manipulation and 'lubridate' for 
#                 date handling. Ensure that the raw data is in the specified directory.
# Additional Notes: This script generates a cleaned dataset saved in a standard CSV format for use in modeling.

#### Workspace Setup ###

# Load necessary libraries for data manipulation and visualization
#install.packages("tidyr")
#install.packages("corrplot")
#install.packages("lubridate")
#install.packages("reshape2")
library(tidyr)
library(reshape2)
library(corrplot)
library(lubridate)

#### Load Data ####

# Load datasets from specified paths
merge_data <- read.csv(here::here("data/analysis_data/analysis_data.csv"))
raw_data_cpi <- read.csv(here::here("data/analysis_data/analysis_data_CPI.csv"))
vehicle_theft_wide <- read.csv(here::here("data/analysis_data/analysis_data_Vehicle.csv"))

#### CPI Data Measurements ####

# Transform CPI data from wide to long format to facilitate plotting
data_long <- pivot_longer(merge_data, 
                          cols = c(Recreation_education_and_reading, Goods, Household_operations_furnishings_equipment,
                                   Health_and_personal_care, All_items, Transportation, Shelter, Services, Food,
                                   Alcoho_tobacco_cannabis, Energy, Gasoline, Clothing_footwear),
                          names_to = "Category", 
                          values_to = "Index")

# Create scatter plots with regression lines for CPI categories vs vehicle thefts
ggplot(merge_data, aes(x = All_items, y = Total_Vehicle_Thefts)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Relationship between All-items CPI and Vehicle Thefts",
       x = "All-items CPI",
       y = "Total Vehicle Thefts")

ggplot(merge_data, aes(x = Energy, y = Total_Vehicle_Thefts)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Relationship between Energy CPI and Vehicle Thefts",
       x = "Energy CPI",
       y = "Total Vehicle Thefts")

# Excluding specific CPI categories for focused analysis
merge_data_filtered <- merge_data[, !names(merge_data) %in% c("All_items", "Energy")]

# Plot linear regression for each CPI category
ggplot(merge_data_filtered, aes(x = Recreation_education_and_reading)) +
  geom_point(aes(y = Total_Vehicle_Thefts)) +
  geom_smooth(aes(y = Total_Vehicle_Thefts), method = "lm", se = FALSE) +
  facet_wrap(~., scales = "free", ncol = 2) +
  labs(title = "Relationship between CPI Categories (excluding All-items and Energy) and Vehicle Thefts",
       x = "CPI Category",
       y = "Total Vehicle Thefts")

# Box Plots for Distribution - all CPI categories
ggplot(data_long, aes(x = Category, y = Index, fill = Category)) +
  geom_boxplot() +
  labs(title = "Box Plot of All CPI Categories",
       x = "Category",
       y = "Index Value") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 65, hjust = 1))  # Rotate x-axis labels for better readability


#### Vehicle Theft Data Measurements ####

# Distribution Plot
# Set up the plotting area
par(mar = c(5, 5, 4, 2) + 0.1)

# Create the histogram with a density curve
hist(merge_data$Total_Vehicle_Thefts, 
     breaks = 20, 
     freq = FALSE, 
     main = "Distribution of Vehicle Thefts", 
     xlab = "Total Vehicle Thefts",
     ylab = "Density",
     col = "lightblue",
     xlim = c(0, max(merge_data$Total_Vehicle_Thefts) * 1.1))

# Add a density curve
lines(density(merge_data$Total_Vehicle_Thefts), col = "darkred", lwd = 2)

# Add a legend
legend("topright", 
       legend = c("Density Curve"), 
       col = c("darkred"), 
       lwd = c(2), 
       bty = "n")

# Add a rug plot to show individual data points
rug(merge_data$Total_Vehicle_Thefts, col = "darkblue", lwd = 0.5) # Show data points


# Convert the Month_Year to Date format for easier plotting
merge_data$Month_Year <- dmy(paste("01", merge_data$Month_Year))



# Time Series Plot for 'All_items'
ggplot(merge_data, aes(x = Month_Year, y = All_items)) +
  geom_line() +
  labs(title = "Time Series of All Items",
       x = "Month Year",
       y = "All Items Index") +
  theme_minimal()

# Pivot the data to long format for plotting multiple series
data_long <- pivot_longer(merge_data, 
                          cols = c(Recreation_education_and_reading, Goods, Household_operations_furnishings_equipment,
                                   Health_and_personal_care, All_items, Transportation, Shelter, Services, Food,
                                   Alcoho_tobacco_cannabis, Energy, Gasoline, Clothing_footwear, Total_Vehicle_Thefts),
                          names_to = "Category", 
                          values_to = "Index")

# Time Series Plot for all CPI categories
ggplot(data_long, aes(x = Month_Year, y = Index, color = Category)) +
  geom_line() +
  labs(title = "Time Series of All CPI Categories and Vehicle Thefts",
       x = "Month Year",
       y = "Index Value") +
  theme_minimal() +
  theme(legend.position = "right")  # Adjust legend position

