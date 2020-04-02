# --------------------------------
# Sourcing file to contain 
# 31 Mar 2020
# AEH
# --------------------------------
# load libraries --------------------------------
library(ggplot2)
# source files --------------------------------
source("MyFunctions.R")

# global variabes collect small values here--------------------------------
ant_file <- "antcountydata.csv" #each row is a county
x_col <- 7 # column 7 in dataframe, this contains the latitude center of each county. can change this 
y_col <- 5 #column 5, number of ant species in that county recorded from museum records
########################################
# read in data
temp1 <- get_data(file_name = ant_file) #name of the input varible, in this case ant file 

x <- temp1[,x_col] #take all the rows and just col 7 and assign to x. extracts predictor variable
y <- temp1[,y_col] #extract response variable 

#fit regression model 
temp2 <- calculate_stuff(x_var=x, y_var=y)

# extract residuals
temp3 <- summarize_output(z=temp2)

#create graph
graph_results(x_var=x,y_var=y)

print(temp3) #show residuals
print(temp2) #shows linear model summary

