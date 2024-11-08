setwd("D:\\CA1")
list.files()
EvData <- read.csv("EvolutionDataSets.csv")
head(EvData)

# libraries
#install.packages("tidyverse")
#install.packages("ggplot2")
#install.packages("stats")
#install.packages("MASS")

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

# 2. Habitat distribution
p2 <- ggplot(EvData, aes(x = Habitat)) +
  geom_bar(fill = "lightgreen") +
  theme_minimal() +
  labs(title = "Distribution of Habitats",
       x = "Habitat Type",
       y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
# 3. Cranial Capacity vs Height
p3 <- ggplot(EvData, aes(x = Cranial_Capacity, y = Height)) +
  geom_point(alpha = 0.6) +
  theme_minimal() +
  labs(title = "Relationship between Cranial Capacity and Height",
       x = "Cranial Capacity",
       y = "Height")

# Print all plots
print(p1)
print(p2)
print(p3)

# (b) Central and variational measures for Cranial Capacity
cranial_stats <- data.frame(
  Mean = mean(EvData$Cranial_Capacity),
  Median = median(EvData$Cranial_Capacity),
  SD = sd(EvData$Cranial_Capacity),
  IQR = IQR(EvData$Cranial_Capacity),
  Min = min(EvData$Cranial_Capacity),
  Max = max(EvData$Cranial_Capacity),
  Variance = var(EvData$Cranial_Capacity),
  CV = sd(EvData$Cranial_Capacity) / mean(EvData$Cranial_Capacity) * 100
)
print("Cranial Capacity Statistics:")
print(cranial_stats)

# (c) Chebyshev's rule for Cranial Capacity
cranial_mean <- mean(EvData$Cranial_Capacity)
cranial_sd <- sd(EvData$Cranial_Capacity)
chebyshev_interval <- c(cranial_mean - cranial_sd, cranial_mean + cranial_sd)

# Find outliers using Chebyshev's rule
chebyshev_outliers <- EvData$Cranial_Capacity[
  EvData$Cranial_Capacity < chebyshev_interval[1] |
    EvData$Cranial_Capacity > chebyshev_interval[2]
]

# (d) Box plot outlier detection
# Create boxplot with outlier labels
boxplot_cranial <- ggplot(EvData, aes(y = Cranial_Capacity)) +
  geom_boxplot(fill = "lightblue") +
  theme_minimal() +
  labs(title = "Boxplot of Cranial Capacity with Outliers",
       y = "Cranial Capacity")

print(boxplot_cranial)

# Calculate boxplot statistics manually
Q1 <- quantile(EvData$Cranial_Capacity, 0.25)
Q3 <- quantile(EvData$Cranial_Capacity, 0.75)
IQR_val <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR_val
upper_bound <- Q3 + 1.5 * IQR_val

boxplot_outliers <- EvData$Cranial_Capacity[
  EvData$Cranial_Capacity < lower_bound |
    EvData$Cranial_Capacity > upper_bound
]

print("Boxplot Statistics:")
print(paste("Q1:", Q1))
print(paste("Q3:", Q3))
print(paste("IQR:", IQR_val))
print(paste("Lower bound:", lower_bound))
print(paste("Upper bound:", upper_bound))
print("Boxplot outliers:")
print(boxplot_outliers)


############################
### Question 2 Solutions ###
############################


# a) Probability models for selected variables
# 1. Cranial Capacity (Continuous) - Normal distribution
cranial_fit <- fitdistr(EvData$Cranial_Capacity, "normal")

# 2. Location (Categorical) - Multinomial
location_prob <- prop.table(table(EvData$Location))

# 3. Height (Continuous) - Normal distribution
height_fit <- fitdistr(EvData$Height, "normal")

# 4. Habitat (Categorical) - Multinomial
habitat_prob <- prop.table(table(EvData$Habitat))

# b) Parameter estimates
print("Normal distribution parameters for Cranial Capacity:")
print(cranial_fit$estimate)

print("Multinomial probabilities for Location:")
print(location_prob)

print("Normal distribution parameters for Height:")
print(height_fit$estimate)

print("Multinomial probabilities for Habitat:")
print(habitat_prob)

# c) Predictions
# For normal distributions, we can use mean ± 2*sd for 95% prediction intervals
cranial_pred_interval <- c(
  cranial_fit$estimate["mean"] - 2*cranial_fit$estimate["sd"],
  cranial_fit$estimate["mean"] + 2*cranial_fit$estimate["sd"]
)

height_pred_interval <- c(
  height_fit$estimate["mean"] - 2*height_fit$estimate["sd"],
  height_fit$estimate["mean"] + 2*height_fit$estimate["sd"]
)

print("95% Prediction interval for Cranial Capacity:")
print(cranial_pred_interval)

print("95% Prediction interval for Height:")
print(height_pred_interval)

