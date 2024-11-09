setwd("D:\\R-Stati")
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

# Distribution for Cranial Capacity by Species
p4 <- ggplot(EvData, aes(x='Genus_&_Specie', y=Cranial_Capacity)) + geom_boxplot() + theme_minimal() + labs(title="Cranial Capacity by Species", x="Species", y="Cranial Capacity")


# Distribution for species count by country
p5 <- ggplot(EvData, aes(x = reorder(Current_Country, -table(Current_Country)[Current_Country]))) +
  geom_bar(fill = "lightcoral") +
  labs(title = "Number of Species Found per Country", 
       x = "Country", 
       y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

migrated <- EvData %>%
  group_by(Migrated) %>%
  summarise(count = n())

p6<- ggplot(migrated, aes(x = "", y = count, fill = Migrated)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y") +
  labs(title = "Proportion of Migrated Species") +
  theme_void()


# Print all plots
print(p1)
print(p2)
print(p3)
print(p4)
print(p5)
print(p6)

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

# (a) Propose probability models for four variables
# Normal distribution for 'Time' and 'Cranial_Capacity'
# Multinomial distribution for 'Genus_&_Specie' and 'Diet'


# b) Parameter estimates
# Estimating mean and standard deviation for Time
mean_time=mean(EvData$Time)
sd_time = sd(EvData$Time)
p_density=dnorm(EvData$Time,mean_time,sd_time)
hist(EvData$Time,freq=FALSE)
curve(dnorm(x,mean_time,sd_time),add=TRUE,col='red')

# For Cranial Capacity
#mean_cranial=mean(EvData$Cranial_Capacity)
#sd_cranial=sd(EvData$Cranial_Capacity)
lam=1/cranial_mean
alpha=cranial_mean*lam
a=min(EvData$Cranial_Capacity)
a
b=max(EvData$Cranial_Capacity)
b
j=seq(0,1449,0.9)
pdf=dgamma(j,alpha,lam)
hist(EvData$Cranial_Capacity,freq=TRUE)
plot(j,pdf,type="l",col='red')
#c_density=dnorm(EvData$Cranial_Capacity,mean_time,sd_time)
#hist(EvData$Cranial_Capacity,freq=FALSE)
#curve(dnorm(x,mean_cranial,sd_cranial),add=TRUE,col='red')

mean_time  # Mean for Time
sd_time  # Standard deviation for Time
cranial_mean  # Mean for Cranial Capacity
cranial_sd  # Standard deviation for Cranial Capacity

# For categorical variables 'Genus_&_Specie' and 'Diet'
habitat_probs=prop.table(table(EvData$Habitat))
barplot(habitat_probs,col="lightblue",ylim=c(0,0.3))
lines(x=0:9,y=rep(1/10,10),type="o",col="darkblue")

diet_probs=prop.table(table(EvData$Diet))
diet_probs
barplot(diet_probs)
abline(h=diet_probs[2])


habitat_counts <- table(EvData$Habitat)
barplot(habitat_counts, main = "Distribution of Habitats", xlab = "Habitat", ylab = "Frequency", col = "lightblue")


#barplot(EvData$Habitat)

habitat_probs  # Probability distribution for Genus_&_Specie
diet_probs  # Probability distribution for Diet

# (c) Predict values using the models
# Prediction using Normal distribution for Cranial Capacity
r_time=rnorm(EvData$Time,mean_time,sd_time)
pred_mean=mean(r_time)
pred_mean

cranial_pdf=dgamma(EvData$Cranial_Capacity,lam,alpha)  # Probability of Cranial Capacity < 500
pred_cranial=max(cranial_pdf)
pred_cranial# Print the prediction

tab_habitat=table(EvData$Habitat)
p=tab_habitat/sum(tab_habitat)
j=c(10,20,25,15,10,5,5,10)
pred_pdf_habitat=dmultinom(j,100,p)
pred_pdf_habitat

t=table(EvData$Diet)
mode=names(t)[which(t==max(t))]
pred=mode
pred


############################
### Question 3 Solutions ###
############################

# a) Chi-square test: 'Genus_&_Specie' and 'Diet'
X1 = EvData$Genus_and_Specie
X2 = EvData$Diet
#H0: X1 and X2 are independent   H1: X1 and X2 are dependent
alpha=0.01
F = table(X1,X2)
F
n=nrow(EvData)
E=matrix(NA,24,5)
for(i in 1:24){
  for(j in 1:5){
    Fi0=sum(F[i,]);F0j=sum(F[,j])
    E[i,j]=(Fi0*F0j)/n
  }
}
test.value=sum((F-E)^2/E)
test.value   
c.value=qchisq(1-alpha,92)
c.value
#since test.value>c.value reject H0
#X1 and X2 are dependent

# (b) Apply goodness-of-fit test for 'Diet'
# Assume an expected probability distribution for 'Diet' categories
#step 1  H0: p1=p2=p3=p4=p5=1/5   H1: Not H0
#step 2:
alpha=0.05
k=5
#step 3:
F=table(EvData$Diet)
p=rep(1/5,5)
n=length(EvData$Diet)
E=n*p
test.value=sum((F-E)^2/E)
#step 4
c.value=qchisq(1-alpha, (k-1))
print(test.value)
print(c.value)
#since test.value>c.value H0 rejected

# Print the result of the goodness-of-fit test

# (c) Test the mean of a continuous variable
#H0: mu=600 H1: mu !=600    # two-sided HT
mu0=600
alpha=0.05
xbar=mean(EvData$Cranial_Capacity) 
sigma=sd(EvData$Cranial_Capacity)
n=nrow(EvData)
test.value=(xbar-mu0)/(sigma/sqrt(n))
c.value=qnorm(1-(alpha/2))
c(test.value,c.value)
#since |test.value|>c.value therefore H0 is accepted

