# should be removed to qmd later
#### Set Up ###
#install.packages("corrplot")
#install.packages("reshape2")
library(reshape2)
library(corrplot)
#### Load Data ####
merge_data <- read.csv(here::here("data/analysis_data/analysis_data.csv"))
raw_data_cpi <- read.csv(here::here("data/analysis_data/analysis_data_CPI.csv"))
vehicle_theft_wide <- read.csv(here::here("data/analysis_data/analysis_data_Vehicle.csv"))

#### CPI Data Measurements ####

# Scatter Plot with Regression Line
ggplot(merge_data, aes(x = All_items, y = Total_Vehicle_Thefts)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Relationship between All-items CPI and Vehicle Thefts",
       x = "All-items CPI",
       y = "Total Vehicle Thefts")

# Box Plots for Distribution
# Using melt from the data.table package to reshape data for plotting
long_format <- melt(merge_data, id.vars = "Month_Year", variable.name = "CPI_Category", value.name = "CPI_Value")

ggplot(long_format, aes(x = CPI_Category, y = CPI_Value)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Distribution of CPI by Category",
       x = "CPI Category",
       y = "CPI")


#### Vehicle Theft Data Measurements ####

# Distribution Plot
hist(merge_data$Total_Vehicle_Thefts, breaks = 30, main = "Histogram of Vehicle Thefts", xlab = "Total Vehicle Thefts")

# Trend Analysis
trend_model <- lm(Total_Vehicle_Thefts ~ Time, data = merge_data)
summary(trend_model)

