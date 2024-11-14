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

This analysis provides insights into the biological characteristics of ancient human species through statistical and visual examination. Key findings include:

1. **Species and Habitat Distribution:** Species are distributed across various locations and habitats, with significant variation by country and region.

2. **Cranial Capacity Insights:** Cranial capacity shows a positive correlation with height, suggesting a relationship between body size and cranial development. However, significant outliers exist, indicating variability in cranial size that could be linked to evolutionary factors.

3. Migration Patterns: A noticeable proportion of species exhibit migration traits, potentially shedding light on historical migration patterns.

4. **Probability Distributions for Attributes:**

* Continuous variables like cranial capacity and time fit well with gamma and normal distributions, respectively, allowing predictive modeling.
* Categorical variables such as habitat and diet follow multinomial distributions, highlighting their variability across the dataset.
5. **Hypothesis Tests:**

* Independence: Genus & Species and Diet are statistically dependent, suggesting that dietary preferences are associated with specific species.
* Goodness-of-Fit: The expected uniform distribution of Diet categories was rejected, indicating dietary specialization among species.
* Mean Testing: The mean cranial capacity does not match the hypothesized value, suggesting unique evolutionary traits within this population.

Overall, these results provide a statistical basis for understanding physical and behavioral adaptations in ancient human species, reflecting evolutionary diversity. The analysis framework also offers a reproducible approach for similar datasets in evolutionary biology.
---
