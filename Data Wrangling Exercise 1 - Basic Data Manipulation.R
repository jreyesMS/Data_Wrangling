# Data Wrangling Exercise 1: Basic Data Manipulation

# loading of the dplyr and tidyr packages
library(tidyr)
library(dplyr)

# 0 - loading Titanic data set
myURL <- "https://docs.google.com/spreadsheets/d/1Rb9midSPoj1G8glBld2B7NyLPOnmgrNpGYcABF2kpsc/pub?gid=2057932407&single=true&output=csv"

refine_original <- read.csv(url(myURL))
View(refine_original)
str(refine_original)
refine_draft <- refine_original


# 1 - Clean Up Brand Names: Clean up the 'company' column so all of the misspellings of the brand names are standardized.
refine_draft$company <- as.character(refine_draft$company)

refine_draft$company <- ifelse(refine_draft$company %in% c("phillips", "philips", "phllips", "phillps", "fillips", "phlips"), "philips", 
                               ifelse(refine_draft$company %in% c("unilever", "unilver"), "unilever",
                                      ifelse(refine_draft$company %in% c("ak zo", "akz0", "akzo"), "akzo", "van houten")))


#2 - Separate product code and number
refine_draft$Product.code...number <- as.character(refine_draft$Product.code...number)

refine_draft2 <- separate(refine_draft, "Product.code...number", c("product_code", "product_number"), sep = "-", remove = TRUE)


#3 - Add product Categories
refine_draft3 <- mutate(refine_draft2, product_category = ifelse(product_code == "p", "Smartphone", ifelse(product_code == "v", "TV", ifelse(product_code == "x", "Laptop", "Tablet"))))


#4 - Add full address for geocoding
refine_draft4 <- unite(refine_draft3, "full_address", address:country, sep = ", ", remove = TRUE)


#5 - Create dummy variables for company and product category

refine_draft5 <- mutate(refine_draft4,product_smartphone = ifelse(refine_draft4$product_category == "Smartphone",1,0)
                        ,product_tv = ifelse(refine_draft4$product_category == "TV", 1, 0)
                        ,product_laptop = ifelse(refine_draft4$product_category == "Laptop", 1, 0)
                        ,product_table = ifelse(refine_draft4$product_category == "Tablet", 1, 0))

#6 - Clean data

refine_clean <- refine_draft5
View(refine_clean)

