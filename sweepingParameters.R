# --------------------------------
# writing functions from equations and sqeeping over parameters
# 21 Apr 2020
# AEH
# --------------------------------
#
library(ggplot2)
# s=cA^z describes species-area relationship the number of species that can be found as a function of the area 

# --------------------------------
# FUNCTION species_area_curve 
# description: creates a power function for S and A
# inputs: A is a vector of island areas 
  # c is the intercept cpnstant 
  # z is the slope constant 
# outputs: s is a vector of species richness
###################################
species_area_curve  <- function(A=1:5000,
                                c=0.5,
                                z=0.26) {
S <- c*(A^z)

return(S)

} # end of species_area_curve 
# --------------------------------
head(species_area_curve())

# --------------------------------
# FUNCTION species_area_plot
# description: plot species area curves with parameter values
# inputs: A=vector of areas
#   C= single value for c parameter
#     z= single value for z parameter
# outputs: smooth curve with parameters printer in graph  
###################################
species_area_plot <- function(A= 1:5000,
                              c=0.5,
                              z=0.26) {
plot(x=A,y=species_area_curve(A,c,z),
     type="l",
     xlab="island area",
     ylab="S (number of species)",
     ylim=c(0,2500))
  mtex(paste("c=",c," z=",z),cex=0.7)
} # end of species_area_plot
# --------------------------------
species_area_plot()

# build a grid of plots!
# set up global variables
# global variables
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.30)
par(mfrow=c(4,3))
for (i in seq_along(c_pars)) {
  for (j in seq_along(z_pars)) {
    species_area_plot(c=c_pars[i],z=z_pars[j])
  }
} 

# expand.grid
expand.grid(c_pars,z_pars) #sets up as a dataframe 
# --------------------------------
# FUNCTION sa_output
# description: summary stats for species-area powerfunction 
# inputs: vector of predicted species richness values 
# outputs: list if max-min, coefficient of variation 
###################################
sa_output <- function(S=runif(10)) {
sum_stats <- list(s_gain=max(S)-min(S),
                  s_cv=sd(S)/mean(S))
return(sum_stats)
} # end of sa_output
# --------------------------------
sa_output() # list of two numbers both numeric calculations 

# build program body --------------------------------
#global variables
Area <- 1:5000
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.30)

#set up model data frame containing all the info we need

model_frame <- expand.grid(c=c_pars,z=z_pars)
str(model_frame) # fill with elements from the function 
model_frame$SGain <- NA
model_frame$SCV <- NA
head(model_frame)

# cycle through model calculations 
for (i in 1:nrow(model_frame)) {
  #generated S vector 
  temp1 <- species_area_curve(A=area,
                              c=model_frame[i,1],
                              z=model_frame[i,2])
  #calculate output stats
  temp2 <- sa_output(temp1)
  # pass results to coumn in data frame 
  model_frame[i,c(3,4)] <- temps2
}
print(model_frame)

#parameter sweep redux with ggplot graphics

#ggplothas a sweeping function of its own 
area <- 1:5
c_pars <- c(100,150,175)
z_pars - c(0.10,0.16,0.26,0.30)

#set up model frame
model_frame <- expand.grid(c=c_pars, 
                           z=z_pars,
                           A=area)
head(model_frame)
length(model_frame)
nrow(model_frame)

# add response variable
model_frame$S <- NA 

# loop through params and fill with sa function 
for (i in 1:length(c_pars)) { 
  for (j in 1:length(z_pars)) {
    model_frame[model_frame$c==c_pars[i] & model_frame$z==z_pars[j], "S"] <- species_area_curve(A=area, c=c_pars[i],z_pars[j])
  }
}

head(model_frame)

p1 <- ggplot(data=model_frame)
p1 + geom_line(mapping=aes(x=A,y=S)) + facet_grid(c~z)
