# --------------------------------
# Sourcing file to contain all our functions
# 20 Mar 2020
# AEH
# --------------------------------
library(ggplot2)
# --------------------------------
# FUNCTION get_data
# description: description
# inputs: .csv
# outputs: data frame
###################################
get_data <- function(file_name=NULL) {
if(is.null(file_name)) {
  df <- data.frame(ID=101:110,
                   var_a=runif(10),
                   var_b=runif(10))
} else {
  df <- read.table(file=file_name,
                   header=TRUE,
                   sep=",",
                   stringsAsFactors=FALSE)
}
  
  return(df)
  
} # end of get_data
# --------------------------------
get_data()
# --------------------------------
# FUNCTION calculate_stuff
# description: fits an orginary least squared regression model 
# inputs: x and y vectors of numeric; must be the same length
# outputs: entire model summary from linear model 
###################################
calculate_stuff <- function(x_var=runif(10),
                            y_var=runif(10)) {
  
df <- data.frame(x_var,y_var)
reg_model <- lm(y_var~x_var, data=df) 
  
  #function body
  
  return(summary(reg_model))
 
}# end of calculate_stuff
# --------------------------------
#calculate_stuff() #had this in initially to show that your function works, but then commented out
# --------------------------------
# FUNCTION summarize_output
# description: Pull elements from model summary list
# inputs: List from summary call of lm
# outputs: vector of regression residuals 
###################################
summarize_output <- function(z=NULL) {
if(is.null(z)) {
  z <- summary(lm(runif(10)~runif(10)))
}
  
return(z$residuals)
  
} # end of summarize_output
# --------------------------------
#summarize_output()
# --------------------------------
# FUNCTION graph_results
# description: graph data nd a fitted OLS line
# inputs: input_description
# outputs: creates graph
###################################
graph_results <- function(x_var=runif(10),
                          y_var=runif(10)) {
df <- data.frame(x_var,y_var)
p1 <- qplot(data=df,
            x=x_var,
            y=y_var,
            geom=c("smooth","point"))
print(p1)
message("Message: Regression graph created")
  #function body
  
} # end of graph_results
# --------------------------------
#graph_results()

# Now all the functions are neatly laid out above and we can call them
# at this point we have the structure we need, but nothing is actually written yet