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
