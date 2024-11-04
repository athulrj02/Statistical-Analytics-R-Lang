setwd("D:\\CA1")
list.files()
EvData <- read.csv("EvolutionDataSets.csv")
head(EvData)

# libraries
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("stats")
install.packages("MASS")

library(tidyverse)
library(ggplot2)
library(stats)
library(MASS)  # For fitdistr function

#PRE-PROCESSING
# Check for missing values
missing_values <- colSums(is.na(EvData))
print("Missing Values per Column:")
missing_values

#PRE-PROCESSING
# Check for missing values
missing_values <- colSums(is.na(EvData))
print("Missing Values per Column:")
missing_values
# Removes the rows with missing values
EvData <- na.omit(EvData)

# Convert categorical variables to factors
categorical_vars <- c("Location","Zone", "Current_Country", "Habitat", 
                      "Jaw_Shape", "Canines_Shape", "Sexual_Dimorphism")
EvData[categorical_vars] <- lapply(EvData[categorical_vars], as.factor)

# Convert numerical variables to numeric
numerical_vars <- c("Cranial_Capacity", "Height")
EvData[numerical_vars] <- lapply(EvData[numerical_vars], as.numeric)

# Basic summary of the dataset
summary(EvData)


############################
### Question 1 Solutions ###
############################

# (a) Descriptive plots
# 1. Distribution of species by location
p1 <- ggplot(EvData, aes(x = Location)) +
  geom_bar(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Distribution of Species by Location",
       x = "Location",
       y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


