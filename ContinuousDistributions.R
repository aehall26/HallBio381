# Exploring continuous distributions 
# 20 Feb
library(ggplot2)
library(MASS)

# Uniform  ---------------------------------------------------------------
qplot(x=runif(n=100,min=1,max=6),
              color=I("black"),
              fill=I("cornflowerblue"))
#boost sample size to make the plot smoother 
qplot(x=runif(n=1000,min=1,max=6),
      color=I("black"),
      fill=I("cornflowerblue"))
#gives just the 6 bins and the counts of the numbers in each bin 
qplot(x=sample(1:6, size=1000, replace=TRUE))


# Normal distribution  ----------------------------------------------------

my_norm <- rnorm(n=100,mean=100, sd=2)
qplot(x=my_norm, color= I("black"),fill=I("goldenrod"))

#problems with normal when mean is small 
my_norm <- rnorm(n=100, mean=2, sd=2)
qplot(x=my_norm, color=I("black"), fill=I("goldenrod"))
toss_zeros <- my_norm[my_norm>0]
qplot(x=toss_zeros,color=I("black"), fill=I("goldenrod"))
mean(toss_zeros)
sd(toss_zeros)

#gamma distribution 

#use fot gontinous data grater than 0
my_gamma <- rgamma(n=100,shape=1, scale=10)
qplot(x=my_gamma,color=I("black"), fill=I("goldenrod"))

#gamma with shape=1 is expnential with scale=mean
my_gamma <- rgamma(n=100,shape=1, scale=0.1)
qplot(x=my_gamma,color=I("black"), fill=I("goldenrod"))
#increasing the shape parameter will make the distribution look more normal 
my_gamma <- rgamma(n=100,shape=20, scale=1)
qplot(x=my_gamma,color=I("black"), fill=I("goldenrod"))
#scale parameter changes both mean and the variance: 
#mean = shape+scale
#variance=shape*scale^2


# beta distribution  ------------------------------------------------------

#useful for probability models 
#continuous but bounded between 0 and 1 (which is why its useful for probability)
#think of it as analgous to the binomial distribution but with a continous distribution of possible values 
# generally calculating the probablity of the data given the parameters -- p(data|parameters) 
#eg: how likely is it that we will get x given the parameters
#the other 9baysian) direction is to look at the maximum liklihood estimator of the parameters. we would like to know the most probable values of the parameters diven the data-- p(parameters|data)

# shape1=number of successes + 1
#shape2+number of failures + 1

my_beta<-rbeta(n=1000,shape1=5,shape2=5)
qplot(x=my_beta,color=I("black"), fill=I("goldenrod"))

#eg: ask what is the probability that the data comes up tails 
#when you run above, the most common value is around .5, meaning around half the time we get a tails 
my_beta<-rbeta(n=1000,shape1=49,shape2=49)
qplot(x=my_beta,color=I("black"), fill=I("goldenrod"))
#the above uses 49 tails and 49 heads 
#the graph gets narrower 
#beta with 3 heads and no tails 
my_beta<-rbeta(n=1000,shape1=4,shape2=1)
qplot(x=my_beta,color=I("black"), fill=I("goldenrod"))
# 3 heads and no tails, what is the underlying probability. we expect that it will be biased towards heads. 
my_beta<-rbeta(n=1000,shape1=1,shape2=1)
qplot(x=my_beta,color=I("black"), fill=I("goldenrod"))
#the above example is no data
my_beta<-rbeta(n=1000,shape1=2,shape2=1)
qplot(x=my_beta,color=I("black"), fill=I("goldenrod"))
#beta with 3 heads and no tails(above)
my_beta<-rbeta(n=1000,shape1=0.2,shape2=0.1)
qplot(x=my_beta,color=I("black"), fill=I("goldenrod"))
 # shape one is twice as big as shape two so it will be biased 


# Estimating parameters from the data -------------------------------------

x <- rnorm(1000,mean=92.5,sd=2.5)
qplot(x=x, color=I("black"),fill=I("pink"))
#fit data x to a normal distribution 
fitdistr(x, "normal")      
#this spit out the parameters associated with this distribution. for a formal, those are a standard and a mean 
fitdistr(x, "gamma")
#now simmulate a gamma using the maximum likelihood method. take values from the fitdistr dunction 
x_sim <- rgamma(n=1000,shape=1339,rate=15)
qplot(x=x_sim, color=I("black"),fill=I("pink"))
#as you can see x_sim looks pretty similar to the data we had. The parameters give it the shape that look like a gamma (because that's what we drew from)



# regression analysis  ----------------------------------------------------

n <- 50 # number of observations (rows)
var_a <- runif(n) # independent variable 50 random uniform numbers 
var_b <-runif(n) #dependent variable 
var_c <- 5.5 + var_a*10 #built a tiny regression equation take one random number and create a function out of it. var_a is a vector so youll get a vector output for c. this creates a noisy linear relationship
id <- seq_len(n) #creates a sequence from 1 to n if n > 0
reg_df <- data.frame(id,var_a,var_b,var_c)
str(reg_df)
head(reg_df)
#regression model
reg_model <- lm(var_b~var_a, data=reg_df) #by adding data=regdf you instruct r to grab the data from the reg_df data frame. refers toa value inside the data frame give. 
summary(reg_model)
summary(reg_model)$coefficients

z <- unlist(summary(reg_model))
z

reg_sum <- list(intercept=z$coefficients1, slope=z$coefficients2,intercept_p=z$coefficients7,slope_p=z$coefficients8,r2=z$r.squared)
reg_sum$intercept
#regression plot for data
reg_plot <- ggplot(data=reg_df, aes(x=var_a, y=var_b)) + geom_point() + stat_smooth(method=lm, se=.95) #setting the standard error to .95 gives a 95% confidence interval 
print(reg_plot)


# ANOVA -------------------------------------------------------------------

n_group <- 3 #number of treatment groups 
n_name <- c("Control", "Treat1", "Treat2")
n_size <- c(12,17,9) #number of  observations for each group 
n_mean <- c(40,41,60) #average response variables 
n_sd <- c(5,5,5)
t_group <- rep(n_name,n_size) #use the size labels to say how many labels you need 
table(t_group)
id <- 1:(sum(n_size))
res_var <- c(rnorm(n=n_size[1], mean=n_mean[1],sd=n_sd[1]),
             rnorm(n=n_size[2], mean=n_mean[2],sd=n_sd[2]),
             rnorm(n=n_size[3], mean=n_mean[3],sd=n_sd[3]))
#simulates a random normal dist for each treatment group. each group has different sample sizes, means, and they have the same sd