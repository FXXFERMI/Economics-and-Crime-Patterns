#### Preamble ####
# Purpose: This script simulates auto theft incidents and CPI inflation data for Ottawa from 2018 to 2023.
#          It generates data on vehicle style, make, and year, and assigns these to different city divisions.
#          The simulation aims to facilitate analysis of trends and patterns in auto theft across various
#          vehicle types and economic conditions.
# Author:Siqi Fei
# Date: 05 April 2024
# Contact: fermi.fei@mail.utoronto.ca
# License: MIT
# Pre-requisites: The script requires the installation of the 'tidyverse' package for data manipulation
#                 and visualization. Ensure that 'tidyverse' is installed and up-to-date before running this script.
# Any other information needed? For more information on how this data can be used or for specific customization,
#                               please contact the author via the email provided.


#### Workspace setup ####
#install.packages("tidyverse")
library(tidyverse)

#### Simulate data ####
# Set seed for reproducibility
set.seed(42)

# Create a sequence of months and years from January 2014 to March 2024
months <- rep(1:12, times = 10)  # 12 months for each year (2014 to 2023)
months <- c(months, 1:3)  # Add first three months of 2024
print(months)
years <- rep(2014:2023, each = 12)  # 10 years (2014 to 2023)
print(years)

# Simulate data for Auto Theft Dataset
auto_theft <- data.frame(
  month = months,
  year = years,
  Total_number = sample(100:500, size = length(months), replace = TRUE)
)

# Simulate data for CPI Dataset
cpi <- data.frame(
  month = months,
  year = years,
  Food = runif(length(months), 100, 200),
  Shelter = runif(length(months), 120, 220),
  Clothing_and_footwear = runif(length(months), 80, 180),
  Gasoline = runif(length(months), 90, 190),
  Health_and_personal_care = runif(length(months), 100, 200),
  Goods = runif(length(months), 110, 210),
  Household_operations_furnishings_and_equipment = runif(length(months), 130, 230),
  Alcoholic_beverages_tobacco_products_and_recreational_cannabis = runif(length(months), 140, 240),
  Transportation = runif(length(months), 70, 170),
  Recreation_education_and_reading = runif(length(months), 90, 190),
  Energy = runif(length(months), 80, 180),
  Services = runif(length(months), 110, 210)
)

simulate_data <- merge(auto_theft, cpi, by = c("month", "year"))
#### Save data ####

# Writing to a CSV file
write.csv(simulate_data, "data/simulate_data/Auto_Theft_and_CPI_Inflation_Toronto_2014_2024.csv", row.names = FALSE)


#### Plotting ####

# Plot auto theft trend over time
auto_theft_plot <- ggplot(simulate_data, aes(x = as.Date(paste(year, month, "01", sep = "-")), y = Total_number)) +
  geom_line(color = "blue") +
  labs(x = "Date", y = "Auto Theft Incidents", title = "Auto Theft Incidents Over Time") +
  theme_minimal()

# Add CPI categories to the plot
for (col in names(simulate_data)[4:ncol(simulate_data)]) {
  auto_theft_plot <- auto_theft_plot +
    geom_line(aes(y = !!sym(col)), color = "red", data = simulate_data) +
    scale_y_continuous(sec.axis = sec_axis(~., name = "CPI"), name = "Auto Theft Incidents")
}

# Show the plot
print(auto_theft_plot)

#### Save plot ####
# Saving the plot
ggsave("data/simulate_data/auto_theft_plot.png", plot = auto_theft_plot, width = 10, height = 6, dpi = 300)
