# From Touches to Goals: Modeling the Efficacy of Possession in Football

# Overview
This repository contains all materials related to the paper "From Touches to Goals: Modeling the Efficacy of Possession in Football", authored by Siqi Fei. The study examines the impact of ball possession on the scoring outcomes of football matches, specifically within the Bundesliga league over the season 2023 to 2024. By employing both Poisson and negative binomial regression models, this research seeks to unravel the nuanced relationship between the frequency of ball touches by the home team and their success in scoring goals.


## File Structure

- `data/`:
  - `raw_data/`:
    - `Bundesliga_2023-2024.csv`: Original Bundesliga 2021-2024: Complete Season Analysis data downloaded from Kaggle
  - `analysis_data/`:
    - `analysis_data.csv`: Data cleaned and prepared for analysis, including transformations and filtering based on Final scores and Number of ball touched of Home Team.

- `models/`: 
  - `neg_binomial_scores.rds`: This file stores the negative binomial regression model that was fitted to the Bundesliga data. The model examines the relationship between the number of times the home team players touched the ball and the final score of the home team, accounting for the potential overdispersion in the count data.
  - `poisson_scores.rds`: This file contains the Poisson regression model applied to the same dataset. The Poisson model attempts to relate the home team's ball possessions to their scoring outcomes under the assumption that the mean and variance of the goal count are equal.
  
- `paper/`: 
  - `references.bib`: Bibliography file containing all the citation information used within the paper.
  - `paper.qmd`: Quarto source file for the main paper document. This markdown file includes all text, code, and commands to compile the paper.
  - `From Touches to Goals: Modeling the Efficacy of Possession in Football.pdf`: The compiled and formatted version of the paper, ready for distribution or publication.

- `scripts/`: 
  - `01-data_cleaning.R`: Script for cleaning and preprocessing the raw data. This may include handling missing values, filtering data, and making transformations necessary for analysis.
  - `02-model.R`: Script for building and validating the statistical model(s) used in the analysis. This involves specifying the model, fitting it to the data, and possibly performing some model diagnostics.
  - `03-test_data.R`: Script containing tests to ensure the integrity and validity of the data after the cleaning process. This could involve checks for consistency, correctness, and completeness.

- `other/`: 
  - `llm/`: 
    - `usage.txt`: A detailed log file documenting the usage of language model tools throughout the research process.
  
## Data Source

The dataset utilized in this study was sourced from the publicly available Kaggle dataset titled "Bundesliga 2021-2024 Complete Season Analysis", contributed by user Memocan Orcun. It comprises detailed match statistics for the Bundesliga seasons from 2021 to 2024, including team performances, player statistics, and match outcomes.


## How to Use

1. Clone or download this repository to your local machine.
2. Ensure you have R and the necessary packages installed (tidyverse, rstanarm, here, and others as specified in the `scripts/` directory).
3. Run the scripts in the `scripts/` directory to reproduce the data cleaning process, analysis, and model fitting.
4. Explore the `paper/` directory to view or modify the Quarto document and compile it to produce the final paper.

## License

This project is licensed under the MIT License. See the LICENSE file in the repository root for more information.


## Contact

For any queries regarding this study, please contact Siqi Fei at fermi.fei@mail.utoronto.ca. Further materials and updates can be found at [GitHub repository](https://github.com/FXXFERMI/Modelling_association_football_scores.git).

# LLM usage
This project used Large Language Models at paper.qmd. Some aspects of the abstract and introduction were written with the help of Chat-GPT4 and the entire chat history is available in 'other/llm/usage.txt'
