### Manipulating Data using DPlyr

## What is dplyr 
# new-ish package provides a set of tools for manipulating data
# part of the tidyverse: collection of packages share philosophy, grammar and data structure 
# Specifically written to be fast

library(dplyr)
### Core verbs
# filter() allows you to select certain variables from rows within a data set 
# select() allows you to select certain variables from columns within a data set 
# summarize () and group_by() 
# mutate() makes a new column based on data you already have 
data(starwars)
class(starwars)
# what is a tibble? keep the great aspects of dataframes and dropped some frustrating ones like changing variable names, changing input types, lists the class of each 
## clean up data
# complete.cases not part of dplyr
starwarsClean <- starwars[complete.cases(starwars[,1:10]),] # grab all rows and the first 10 columns 
is.na(starwarsClean) 
anyNA(starwarsClean)# are there any NAs in the dataset?
# what does our data look like?
glimpse(starwarsClean)
head(starwarsClean)
## filter(): pick/subset observations by their values 
# uses >, >=, <, <=, !+, == for comparisons 
# filter automatically excludes NAs
filter(starwarsClean, gender=="male", height < 180, height >100) # use commaes- we want males under 180 and over 100 
filter(starwarsClean, eye_color %in% c("blue", "brown"))
# us a concatonated list to collect the eye colors that you want 
## arrange(): reorders rows
arrange(starwarsClean, by=height) #default is ascending order 
arrange(starwarsClean, by=desc(height)) #this is how you do it by descending order 
arrange(starwarsClean, height, desc(mass))
# add additional argument to break ties in the preceeding column 
starwars1 <- arrange(starwars, height)
tail(starwars1)
# collect(): choose variables by their names 
starwarsClean[1:10,2] # base r- selecting second variable 
select(starwarsClean, 1:5) # use numbers
select(starwarsClean, name:height) #can use variable names too rather than numbers
select(starwarsClean, -(films:starships))
#rearrange columns 
select(starwarsClean,name,gender,species,everything()) #everything() is a helper function useful if you want to move a couple of variables to the begining 
select(starwarsClean, contains("color")) #collect variables that relate to each other
#other helpers: ends_with, starts_with, matches(reg ex), num_range

select(starwarsClean, height, skin_color, films) #not in 'clumps'
## rename columns 
select(starwarsClean, haircolor=hair_color)
rename(starwarsClean, haircolor=hair_color)

####mutate():creates new variables with functions of existing varables 
