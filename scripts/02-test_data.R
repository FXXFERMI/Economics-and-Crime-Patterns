#### Preamble ####
# Purpose: Tests the integrity and correctness of data cleaning and merging operations 
#          performed on CPI and vehicle theft datasets. It ensures that all data transformation 
#          steps have been applied correctly and that the final dataset is in the expected format 
#          and structure for subsequent analysis.
# Author: Siqi Fei
# Date: 05 April 2024
# Contact: fermi.fei@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'testthat' package should be installed for running these tests. 
#                 The data cleaning script 'data_cleaning_script.R' should have been executed 
#                 successfully, resulting in the creation of 'raw_data_cpi', 'vehicle_theft_summary', 
#                 'vehicle_theft_wide', and 'merge_data' objects.
# Any other information needed? Ensure that the R environment has sufficient permissions to access 
#                               the directories where data files are stored. The tests are meant to be 
#                               run after the data cleaning process but before any analysis.


#### Workspace setup ####
# install.packages("testthat")
#install.packages("tidyverse")
library(testthat)
library(tidyverse)

#### Load Data ####
transposed_data <- read.csv(here::here("data/analysis_data/analysis_data.csv"))
raw_data_cpi <- read.csv(here::here("data/analysis_data/analysis_data_CPI.csv"))
vehicle_theft_wide <- read.csv(here::here("data/analysis_data/analysis_data_Vehicle.csv"))

#### Test data ####

#### Tests for CPI Data Cleaning ####

# Test that CPI data has the expected number of rows and columns after removing unnecessary rows
test_that("CPI data has correct dimensions", {
  expect_equal(nrow(raw_data_cpi), 15)  
  expect_equal(ncol(raw_data_cpi), 123)
})

# Test that there are no NA values in CPI data after replacement
test_that("CPI data has no NA values", {
  expect_true(all(complete.cases(raw_data_cpi)))
})

#### Tests for Auto Theft Data Aggregation ####

# Test that vehicle_theft_wide has the correct number of rows
test_that("Vehicle theft data has one row", {
  expect_equal(nrow(vehicle_theft_wide), 1)
})

# Test that vehicle_theft_wide has the correct number of columns
# Assuming it should have one column for each month-year
test_that("Vehicle theft data has correct number of columns", {
  expect_equal(ncol(vehicle_theft_wide), 123)
})

#### Tests for Data Merging ####

# Test that the merged dataset has the correct dimensions
test_that("Merged data has correct dimensions", {
  expect_equal(nrow(transposed_data), 122)
  expect_equal(ncol(transposed_data), 15)
})

# Test that the merged dataset has no NA values
test_that("Merged data has no NA values", {
  expect_true(all(complete.cases(transposed_data)))
})

# Test that all columns in CPI data are numeric after conversion
test_that("CPI data contains only numeric columns", {
  expect_true(all(sapply(transposed_data[-1], is.numeric)))
})



