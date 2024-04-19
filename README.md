# Economics and Crime Patterns: The Interplay Between CPI Changes and Vehicle Theft Frequencies

## Overview

This repository contains the research paper, datasets, and supplementary materials for the study on the impact of Consumer Price Index (CPI) changes on vehicle theft rates in Toronto from January 2014 to February 2024. The study employs multiple regression models to identify correlations between various CPI categories and the frequency of vehicle thefts, offering insights that could influence economic and crime prevention policies.

## File Structure

-   `data/`:
    -   `raw_data/`:
        -   `1810000401-eng.csv`: Raw CPI data from Statistics Canada, detailing changes in consumer price indexes over the study period.
        -   `Auto_Theft_Open_Data.csv`: Original dataset from Toronto Police Service detailing reported vehicle thefts in Toronto from 2014 to 2024.
    -   `analysis_data/`:
        -   `analysis_data.csv`: Merged and cleaned dataset used for final analysis, combining CPI and vehicle theft data.
        -   `analysis_data_Vehicle.csv`: Processed dataset focusing on vehicle theft data with added temporal and categorical transformations for analysis.
        -   `analysis_data_CPI.csv`: Cleaned CPI data segmented by relevant categories for direct correlation analysis.
        -   `draft_analysis_data_Vehicle.csv`: Draft of vehicle theft data used for initial exploratory analysis.
    -   `simulate_data/`:
        -   `Auto_Theft_and_CPI_Inflation_Toronto_2014_2024.csv`: Simulated dataset used for method validation and testing analytical assumptions.
-   `models/`:
    -   `bayesian_linear_model.rds`: Saved RDS file of the Bayesian linear regression model output used to estimate the impact of CPI changes on vehicle theft rates.
-   `paper/`:
    -   `references.bib`: Bibliography file containing all the citation information used within the paper.

    -   `paper.qmd`: Quarto source file for the main paper document. This markdown file includes all text, code, and commands to compile the paper.

    -   `Economics and Crime Patterns: The Interplay Between CPI Changes and Vehicle Theft Frequencies.pdf`: The compiled and formatted version of the paper, ready for distribution or publication.

    -   `images/`:

        -   `box_all_cpi.png`: Box plot image showing the distribution of all CPI categories analyzed in the study.
        -   `Time.png`: Time series plot illustrating trends and patterns in both CPI and vehicle thefts over the study period.
-   `scripts/`:
    -   `00-simulate_data.R`: Script for generating simulated data to test model robustness under various scenarios.
    -   `01-data_cleaning.R`: Script for cleaning and preprocessing the raw data from both CPI and vehicle theft datasets.
    -   `02-test_data.R`: Script for conducting initial tests and exploratory data analysis on the cleaned datasets.
    -   `03-data_measurement.R`: Script for detailed data measurement and validation checks to ensure data integrity and accuracy.
    -   `04-model.R`: Script for building, running, and validating the regression models used in the study.
-   `other/`:
    -   `llm/`:
        -   `usage.txt`: A detailed log file documenting the usage of language model tools throughout the research process.
    -   `sketches/`:
        -   `dataset.png`: Visual sketch outlining the dataset structure and key variables.
        -   `graph.png`: Conceptual sketch of proposed analytical models and expected relationships between variables.
-   `Vehicle_Theft_Shiny_App`:
    -   `analysis_data_copy.csv`: Contains the analysis-ready dataset that combines vehicle theft data with CPI indices, formatted specifically for interactive visualization in the Shiny app.
    -   `app.R`: The main script for the Shiny application that enables interactive exploration of the relationship between CPI changes and vehicle theft rates. It includes user interface definition, server logic for data processing, and reactive outputs for data visualization.
    -   `rsconnect`: Directory containing configuration files for deploying the Shiny app to an RStudio Connect server, facilitating sharing and accessibility of the application online.

## Data Source

This research utilizes two primary datasets:

-   CPI Data from Statistics Canada: This dataset includes monthly consumer price indexes from 2014 to 2024, providing a comprehensive view of economic fluctuations in Canada.

-   Vehicle Theft Data from Toronto Police Service: This dataset records detailed instances of vehicle thefts in Toronto, offering granular insights into crime trends over the same period.

## Shiny Application

To interact with the Shiny app:

-   Navigate to the Vehicle_Theft_Shiny_App/ directory.
-   Open the R script app.R.
-   Run the script in RStudio to launch the application locally.

Alternatively, the app can be used on browsers via link: <https://siqi-fei.shinyapps.io/VehicleTheft_Inflation/>

## How to Use

1.  Clone or download this repository to your local machine.
2.  Ensure you have R and the necessary packages installed (tidyverse, rstanarm, here, and others as specified in the `scripts/` directory).
3.  Run the scripts in the `scripts/` directory to reproduce the data cleaning process, analysis, and model fitting.
4.  Explore the `paper/` directory to view or modify the Quarto document and compile it to produce the final paper.

## License

This project is licensed under the MIT License. See the LICENSE file in the repository root for more information.

## Contact

For any queries regarding this study, please contact Siqi Fei at [fermi.fei\@mail.utoronto.ca](mailto:fermi.fei@mail.utoronto.ca){.email}. Further materials and updates can be found at [GitHub repository](https://github.com/FXXFERMI/Modelling_association_football_scores.git).

## LLM usage

This project used Large Language Models at paper.qmd and 01-data_cleaning.R. Some aspects of the Data and Discussion sections were written with the help of Chat-GPT4 and the entire chat history is available in 'other/llm/usage.txt'
