#### Preamble ####
# Purpose: Cleans and merges CPI data with vehicle theft data for analysis. The script
#          standardizes column names, replaces missing values with a placeholder, 
#          aggregates vehicle theft counts, and combines both datasets by date for 
#          a comprehensive monthly overview.
# Author:Siqi Fei
# Date: 05 April 2024
# Contact: fermi.fei@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'tidyverse' package should be installed and loaded. The raw data
#                 for CPI and auto thefts should be available in the specified directories.
# Any other information needed? The script assumes the datasets are formatted with 
#                               specific headers and structure as detailed in the data 
#                               cleaning section.

#### Workspace setup ####
#install.packages("tidyr")
#install.packages("tidyverse")
library(tidyverse)
library(tidyr)

#### Clean data ####
raw_data_cpi <- read.csv("data/raw_data/1810000401-eng.csv", skip = 9, header = TRUE)
raw_data_auto <- read.csv("data/raw_data/Auto_Theft_Open_Data.csv")


# Clean CPI Dataset
# Remove the no need rows of CPI data
raw_data_cpi <- raw_data_cpi[-1, ]
raw_data_cpi <- raw_data_cpi[1:15,]

# Replace dots with spaces
names(raw_data_cpi) <- gsub("\\.", " ", names(raw_data_cpi))

# Replace missing value with 100
raw_data_cpi <- raw_data_cpi %>%
  mutate(across(everything(), ~replace_na(., 100)))

# Clean AUTO THETF Dataset
raw_data_auto <- read.csv("data/raw_data/Auto_Theft_Open_Data.csv")
raw_data_auto$Theft_Counts <- 1
raw_data_auto$REPORT_MONTH <- match(raw_data_auto$REPORT_MONTH, month.name)
# Convert REPORT_MONTH to a date format that can be sorted chronologically
# Assuming REPORT_MONTH is a numeric value that represents the month
raw_data_auto <- raw_data_auto %>%
  mutate(
    Date = as.Date(paste(REPORT_YEAR, REPORT_MONTH, "01", sep = "-")),
    Year_Month = format(Date, "%Y %m")  # Sorting by year and then month
  )

# Aggregate the data to get the total thefts per month and year
vehicle_theft_summary <- raw_data_auto %>%
  group_by(Date, Year_Month) %>%
  summarize(Total_Thefts = sum(Theft_Counts), .groups = 'drop')

# Pivot the summary to have months as columns, ensure it's ordered chronologically
vehicle_theft_wide <- vehicle_theft_summary %>%
  # Remove the 'Date' column if it is no longer needed
  select(-Date) %>%
  # Spread the 'Year_Month' values into columns, filling with 'Total_Thefts'
  spread(key = Year_Month, value = Total_Thefts)


#### Merge the datasets ####

#### Helper Function ####
convert_to_month_year <- function(name) {
  # Split the name into year and month
  parts <- strsplit(name, " ")[[1]]
  year <- parts[1]
  month_num <- parts[2]
  
  # Convert month number to month name
  month_name <- month.name[as.integer(month_num)]
  
  # Return the formatted string
  paste(month_name, year)
}

# Rename the columns of vehicle_theft_wide to match cpi dataset format
names(vehicle_theft_wide) <- sapply(names(vehicle_theft_wide), convert_to_month_year)




# Merge Dataset
merge_data <- merge(raw_data_cpi, vehicle_theft_wide, by.x = c("January 2014",
                    "February 2014","March 2014","April 2014","May 2014",
                    "June 2014","July 2014","August 2014","September 2014",
                    "October 2014","November 2014","December 2014",
                    "January 2015","February 2015","March 2015","April 2015",
                    "May 2015","June 2015","July 2015","August 2015",
                    "September 2015","October 2015","November 2015",
                    "December 2015","January 2016","February 2016","March 2016",
                    "April 2016","May 2016","June 2016","July 2016",
                    "August 2016","September 2016","October 2016",
                    "November 2016","December 2016","January 2017",
                    "February 2017","March 2017","April 2017","May 2017",
                    "June 2017","July 2017","August 2017","September 2017",
                    "October 2017","November 2017","December 2017",
                    "January 2018","February 2018","March 2018","April 2018",
                    "May 2018","June 2018","July 2018","August 2018",
                    "September 2018","October 2018","November 2018",
                    "December 2018","January 2019","February 2019","March 2019",
                    "April 2019","May 2019","June 2019","July 2019",
                    "August 2019","September 2019","October 2019",
                    "November 2019","December 2019","January 2020",
                    "February 2020","March 2020","April 2020","May 2020",
                    "June 2020","July 2020","August 2020","September 2020",
                    "October 2020","November 2020","December 2020",
                    "January 2021","February 2021","March 2021","April 2021",
                    "May 2021","June 2021","July 2021","August 2021",
                    "September 2021","October 2021","November 2021",
                    "December 2021","January 2022","February 2022","March 2022",
                    "April 2022","May 2022","June 2022","July 2022",
                    "August 2022","September 2022","October 2022",
                    "November 2022","December 2022","January 2023",
                    "February 2023","March 2023","April 2023","May 2023",
                    "June 2023","July 2023","August 2023","September 2023",
                    "October 2023","November 2023","December 2023",
                    "January 2024","February 2024"), by.y = c("January 2014",
                    "February 2014","March 2014","April 2014","May 2014",
                    "June 2014","July 2014","August 2014","September 2014",
                    "October 2014","November 2014","December 2014",
                    "January 2015","February 2015","March 2015","April 2015",
                    "May 2015","June 2015","July 2015","August 2015",
                    "September 2015","October 2015","November 2015",
                    "December 2015","January 2016","February 2016",
                    "March 2016","April 2016","May 2016","June 2016",
                    "July 2016","August 2016","September 2016","October 2016",
                    "November 2016","December 2016","January 2017",
                    "February 2017","March 2017","April 2017","May 2017",
                    "June 2017","July 2017","August 2017","September 2017",
                    "October 2017","November 2017","December 2017",
                    "January 2018","February 2018","March 2018","April 2018",
                    "May 2018","June 2018","July 2018","August 2018",
                    "September 2018","October 2018","November 2018",
                    "December 2018","January 2019","February 2019",
                    "March 2019","April 2019","May 2019","June 2019",
                    "July 2019","August 2019","September 2019","October 2019",
                    "November 2019","December 2019","January 2020",
                    "February 2020","March 2020","April 2020","May 2020",
                    "June 2020","July 2020","August 2020","September 2020",
                    "October 2020","November 2020","December 2020",
                    "January 2021","February 2021","March 2021","April 2021",
                    "May 2021","June 2021","July 2021","August 2021",
                    "September 2021","October 2021","November 2021",
                    "December 2021","January 2022","February 2022","March 2022",
                    "April 2022","May 2022","June 2022","July 2022",
                    "August 2022","September 2022","October 2022",
                    "November 2022","December 2022","January 2023",
                    "February 2023","March 2023","April 2023","May 2023",
                    "June 2023","July 2023","August 2023","September 2023",
                    "October 2023","November 2023","December 2023",
                    "January 2024","February 2024"), 
                    all.x = TRUE, all.y =  TRUE)


merge_data <- merge_data[1:122]


merge_data <- cbind(categories = c("Recreation_education_and_reading", 
"Goods", "Household_operations_furnishings_equipment", 
"All_items_excluding_food_and_energy", "Health_and_personal_care",
                           "All_items_excluding_energy", "All_items", 
                           "Transportation", "Shelter", "Services", "Food",
                           "Alcoho_tobacco_cannabis",
                           "Energy", "Gasoline","Total_Vehicle_Thefts", 
                           "Clothing_footwear"), merge_data)

merge_data <- merge_data %>%
  mutate_at(vars(-one_of(names(merge_data)[1])), as.numeric)

#### Save data ####
write_csv(merge_data, "data/analysis_data/analysis_data.csv")
write_csv(raw_data_cpi, "data/analysis_data/analysis_data_CPI.csv")
write_csv(vehicle_theft_wide, "data/analysis_data/analysis_data_Vehicle.csv")
write_csv(vehicle_theft_summary, "data/analysis_data/draft_analysis_data_Vehicle.csv")


#### Additional Clean ####
# Load data with headers
data <- read.csv("data/analysis_data/analysis_data.csv", header = TRUE)

# Transpose the data
transposed_data <- t(data)

# Convert the transposed matrix back to a data frame
transposed_data <- as.data.frame(transposed_data)

# Set the first row as the header
names(transposed_data) <- transposed_data[1, ]

# Remove the first row from the data
transposed_data <- transposed_data[-1, ]

# Convert row names to the first column if needed
transposed_data <- tibble::rownames_to_column(transposed_data, var = "Month_Year")
transposed_data[,-1] <- lapply(transposed_data[,-1], as.numeric)


# Remove columns under headers All_items_excluding_food_and_energy and All_items_excluding_energy
transposed_data <- subset(transposed_data, select = -c(All_items_excluding_food_and_energy, All_items_excluding_energy))

# Get the index of the column with header Total_Vehicle_Thefts
col_index <- which(names(transposed_data) == "Total_Vehicle_Thefts")

# Move the column to the third position
transposed_data <- transposed_data[, c(setdiff(seq_along(transposed_data), col_index), col_index)]

# Check the structure
#str(transposed_data)

#### Save data ####
write_csv(transposed_data, "data/analysis_data/analysis_data.csv")

