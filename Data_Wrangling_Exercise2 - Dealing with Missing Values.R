# Data Wrangling Exercise 2: Dealing with missing values - titanic data set

# loading of the dplyr and tidyr packages
library(tidyr)
library(dplyr)

# 0 - loading Titanic data set
myURL <- "https://docs.google.com/spreadsheets/d/1vfbbOonknt3ohWikCZRN1MTDvrfo3VGen8PpnUWyryk/pub?gid=717569233&single=true&output=csv"

titanic_original <- data.frame(read.csv(url(myURL)))
str(titanic_original)

titanic_draft <- titanic_original
str(titanic_draft)

# 1 - Port of embarkation:  filling in missing values with "S" for South Hampton
titanic_draft$embarked <- as.character(titanic_draft$embarked)
titanic_draft$embarked <- ifelse(!titanic_draft$embarked %in% c("C","S","Q"), "S", titanic_draft$embarked)


# 2 - Age:  Calculate the mean of the Age column and use that value to populate the missing values.
#NOTE:  The median can also be used to fill the missing age values since it is not affected by values on the farthest extremes of the age spectrum.
titanic_draft$age <- ifelse(is.na(titanic_draft$age),mean(titanic_draft$age, na.rm = TRUE), titanic_draft$age)

View(filter(titanic_draft, is.na(titanic_draft$age)))

View(titanic_draft)


# 3 - Lifeboat:  Fill these empty slots with a dummy value e.g. the string 'None' or 'NA'
titanic_draft$boat <- as.character(titanic_draft$boat)

titanic_draft$boat <- ifelse(titanic_draft$boat %in% c(""),"None",titanic_draft$boat)

View(filter(titanic_draft, is.na(titanic_draft$boat)))
View(titanic_draft)


# 4 - Cabin:  Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
titanic_draft$cabin <- as.character(titanic_draft$cabin)
titanic_clean <- mutate(titanic_draft, has_cabin_number = ifelse(titanic_draft$cabin %in% c(""), 0, 1))
View(titanic_clean)
