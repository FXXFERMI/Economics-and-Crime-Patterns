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

# Create a sequence of months and years from January 2014 to Feb. 2024
months <- rep(1:12, times = 10)  # 12 months for each year (2014 to 2023)
months <- c(months, 1:2)  # Add first two months of 2024
years <- rep(2014:2023, each = 12)  # 10 years (2014 to 2023)
years <- c(years, rep(2024, 2)) # two year rows for 2024

#print(years)
#print(months)

# Simulate data for Auto Theft Dataset

# Initialize an empty vector to store increasing values
increasing_values <- numeric(length(months))

# Set the initial value
initial_value <- 250

# Generate increasing values with random increments
for (i in 1:length(months)) {
  random_increment <- sample(5:15, 1)  # Random increment between 5 and 15
  increasing_values[i] <- initial_value + random_increment * i
}


# Simulate data for Auto Theft Dataset
auto_theft <- data.frame(
  month = months,
  year = years,
  Total_Vehicle_Thefts = increasing_values
)

# Simulate data for CPI Dataset
initial_cpi <- 100  # Initial CPI value in 2002

cpi <- data.frame(
  month = months,
  year = years,
  All_items = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),  # Simulate increasing values with random increments
  Food = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Shelter = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Clothing_and_footwear = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Gasoline = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Health_and_personal_care = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Goods = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Household_operations_furnishings_and_equipment = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Alcoholic_beverages_tobacco_products_and_recreational_cannabis = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Transportation = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Recreation_education_and_reading = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Energy = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05))),
  Services = cumprod(c(initial_cpi, runif(length(months) - 1, 0.95, 1.05)))
)
# Merge two data sets
simulate_data <- merge(auto_theft, cpi, by = c("month", "year"))

#### Save data ####

# Writing to a CSV file
write.csv(simulate_data, "data/simulate_data/Auto_Theft_and_CPI_Inflation_Toronto_2014_2024.csv", row.names = FALSE)


#### Plotting ####

# Plot auto theft trend over time
auto_theft_plot <- ggplot(simulate_data, aes(x = as.Date(paste(year, month, "01", sep = "-")), y = Total_Vehicle_Thefts)) +
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

