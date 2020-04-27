# --------------------------------
# Randomization Tests
# 26 Apr 2020
# AEH
# --------------------------------
#

#statistical p is the probability of obtaining the observed results (or something more extreme), if the null hypotehsis were true p(data|H0)
# null hypothesis is usually a hypothesis of "no effect" 
# variation is caused by measured error or other unspecifiec (and less important) sources of variation 

# two advantages of randomization tests
#realxes the  assumptions of standard parametric tests (normality, balanced sample sizes, common variance)

#give a move intuitive understanding of statistical probaboility 

# Steps in reandomization test --------------------------------

# 1. Define a metric X as a single number to represent a pattern
# 2. Calculate x(obs) which is th metric for the empirical (=observed) data that we start with. 
# 3. Randomize or reshuffle the data. Randomize in a way that would uncouple the association between observed data and their assigment to treatment groups. Ideally, the randomization only affects the pattern of treatment effects in the data. Other aspects of the data such as sample sizes are preserved in the randomization The purpose is to simulate the null hypothesis
# 4. For this single randomization, calculate x(sim) 

# note: in the if the null hypothesis is false x(obs) is very different from x(sim). Looks like x obs could not be found very often with xsim being true 
#5. repeat steps 3 and 4 many times (typically n=1000)

# This will let us visualize as a hustogram the distribution of X(sim); distribution of x values when the null hypothesis is true. 

#6. Estimate the tail probabiliy of the observed metric ( or something more extreme) given the null distibution (p(X(obs)|H0))

# Preliminaries  --------------------------------
library(ggplot2)
library(TeachingDemos)
set.seed(100) #when you run the script multiple times you'll get the same values
char2seed("pie overload")
char2seed("pie overload", set=FALSE)
Sys.time()
as.numeric(Sys.time())
my_seed <- as.numeric(Sys.time())
set.seed(my_seed) #setting seed and tracking the value to recreate output
char2seed("pie overload") #but this is ultimately what my seed is for the day

#create treatment groups 
trt_group <- c(rep("Control",4),rep("Treatment",5))
print(trt_group)

#create response variable for imaginary data set
z <- c(runif(4) +1, runif(5) + 10) #becomes a vectorized operation 
print(z)

# combine vectors into a data frame
df <- data.frame(trt=trt_group, res=z) #makes a dataframe with treatment and response. 
print(df) #very small values for the control and large for the treatment suggesting that our results are very significant 

# look at means in the two groups 
obs <- tapply(df$res, df$trt,mean) #variable that we are operating on , grouping variable, and name of function to be applied to the data that are subsetted by each group 
print(obs)

# create a simulated data set
#set up a new dataframe based on the old one
df_sim <- df 
df_sim$res <- sample(df_sim$res) #sample function reorders the values not changing anything but their position in the ordering 
print(df_sim)
# now the results dont look signicant 
# so lets look at the means between the two groups of randomized data to check 
sim <- tapply(df_sim$res, df_sim$trt, mean)
print(sim)
#non randomized data have a stronger treatment effect 

# build functions  --------------------------------
# --------------------------------
# FUNCTION read_data
# description: read in (or generate) data
# inputs: file name(or nothing, as in this demo)
# outputs: 3 column data frame of observed data (ID, x, y)
###################################
read_data <- function(z=NULL) {
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 10*rnorm(20)
    df <- data.frame(ID=seq_along(x_obs),
                     x_obs,
                     y_obs)}
  # df <- read.table(file=z, 
  #                header=TRUE,
  #               stringsAsFactors = FALSE)

return(df)

} # end of read_data
# --------------------------------
#read_data()

# --------------------------------
# FUNCTION get_metric
# description: calculate metric for randomization test    
# inputs: two column data frame for regression  
# outputs: regression slope 
###################################
get_metric <- function(z=NULL) {
  if(is.null(z)){
      x_obs <- 1:20
      y_obs <- x_obs + 10*rnorm(20)
      z <- data.frame(ID=seq_along(x_obs),
                      x_obs, 
                      y_obs)}
  . <- lm(z[,3]~z[,2])
  . <- summary(.)
  . <- .$coefficients[2,1]
  slope <- .
return(slope)

} # end of get_metric
# --------------------------------
#get_metric()

# --------------------------------
# FUNCTION shuffle_data
# description: randomize data for a regression analysis 
# inputs: 3 column data frame (ID, xvar, yvar)
# outputs: 3 column data frame (ID, xvar, yvar)
###################################
shuffle_data <- function(z=NULL) {
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 10*rnorm(20)
    z <- data.frame(ID=seq_along(x_obs),x_obs,y_obs)} # set up data frame                 
  z[,3] <- sample(z[,3]) # use sample function with defaults to reshuffle column
  
  return(z)
} # end of shuffle_data
# --------------------------------
shuffle_data()

# --------------------------------
# FUNCTION get_pval
# description: calculate o value from simulation 
# inputs: list of observed metrix and vactor of simulated metrics
# outputs: lower and upper tail probability value
###################################
get_pval <- function(z=NULL) {
  if(is.null(z)){
    z <- list(rnorm(1), rnorm(1000)) }
    p_lower <- mean(z[[2]] <= z[[1]]) #second list item in z use double brackets to pull value out of a list, single bracket gives a list item that you can't opperate on 
    p_upper <- mean(z[[2]]>=z[[1]])
  

return(c(pL=p_lower,pU=p_upper))

} # end of get_pval
# --------------------------------
get_pval()

# --------------------------------
## function: plot_ran_test  
# create ggplot of histogram of simulated values
# input: list of observed metric and vector of simulated metrics
# output: saved ggplot graph
#------------------------------------------------- 
plot_ran_test <- function(z=NULL) {
  if(is.null(z)){
    z <- list(rnorm(1),rnorm(1000)) }
  dF <- data.frame(ID=seq_along(z[[2]]),simX=z[[2]])
  p1 <- ggplot(data=dF,mapping=aes(x=simX))
  p1 + geom_histogram(mapping=aes(fill=I("goldenrod"),color=I("black"))) +
    geom_vline(aes(xintercept=z[[1]],col="blue")) 
  
}
#plot_ran_test()


n_sim <- 1000 # number of simulated data sets to construct
x_sim <- rep(NA,n_sim) #set up umpty vector for simulated slope values  
df <- read_data() # get (fake) data
x_obs <- get_metric(df) # get slope of observed data

for (i in seq_len(n_sim)) {
  x_sim[i] <- get_metric(shuffle_data(df)) #pull out metric alue from shuffled data set and store it in the empty vector 
}

slopes <- list(x_obs,x_sim) 
get_pval(slopes)
plot_ran_test(slopes) # list containing observed and simulated distribution 
# on the x axis we have the 1000 values of slopes from individual runs. The blue line is the observed slope which splits into the upper tail (which is quite small) and the simulated distribution in the lower tail 
# each run will yield different simulation results 
