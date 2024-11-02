# Statistics for Data Analytics - Project

This project demonstrates core concepts in descriptive analytics, probability models, and hypothesis testing using the Evolution dataset. The project, completed as part of the *Statistics for Data Analytics* module, employs R and RStudio for data analysis and visualization.

## Table of Contents
- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Analysis](#analysis)
  - [Question 1 - Descriptive Analytics](#question-1---descriptive-analytics)
  - [Question 2 - Probability Models](#question-2---probability-models)
  - [Question 3 - Hypothesis Testing](#question-3---hypothesis-testing)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
- [Results](#results)

## Project Overview
The goal of this project is to analyze the Evolution dataset, which contains both categorical and continuous variables. We explore the dataset through descriptive statistics, probability modeling, and hypothesis testing to draw meaningful insights.

## Dataset
The **Evolution dataset** includes:
- **Categorical variables** - Represent different classifications or categories.
- **Continuous variables** - Represent measurable quantities.

The analysis covers data distribution, central tendencies, variation measures, and uncertainty quantification.

## Analysis

### Question 1 - Descriptive Analytics
1. **Dataset Description**  
   Visualizations are created to describe the data distribution using suitable plots (e.g., histograms, box plots, and bar charts).
   
2. **Central and Variation Measures**  
   Calculated measures (mean, median, standard deviation, etc.) for one continuous variable.
   
3. **Outlier Detection**  
   - Used Chebyshev's rule to determine a one-sigma interval and identify outliers.
   - Applied the box plot method for a selected attribute to detect outliers.

### Question 2 - Probability Models
1. **Model Proposal**  
   Proposed probability models for four dataset variables.
   
2. **Parameter Estimation**  
   Estimated parameters for each probability model.
   
3. **Predictive Analytics**  
   Explored how each model can be applied for predictive analysis and generated predictions for selected attributes.

### Question 3 - Hypothesis Testing
1. **Independence Test for Categorical Variables**  
   Developed a binary decision-making strategy to test independence between two categorical variables at a significance level of α = 0.01.
   
2. **Goodness of Fit Test**  
   Applied the goodness of fit test for one categorical variable to evaluate class frequency probabilities at α = 0.05.
   
3. **Mean Test for Continuous Variable**  
   Tested a proposed mean for a continuous variable at a significance level of α = 0.05.

## Technologies Used
- R
- RStudio
- Libraries: `ggplot2`, `dplyr`, `tidyr`

## Getting Started
1. Clone the repository.
   ```bash
   https://github.com/athulrj02/Statistical-Analytics-R-Lang.git
   ```
2. Open the project in RStudio.
3. Install required packages if necessary:
   ```R
   install.packages(c("ggplot2", "dplyr", "tidyr"))
   ```
4. Run the analysis scripts to generate insights and visualizations.

## Results


---
