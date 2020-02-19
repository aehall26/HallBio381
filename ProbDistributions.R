# Probability Distribuions 
# 18 Feb 2020
# d probability density function 
# p cimulsative probability distribution 
# quantile function (inverse of p)
# r random number generator 

library(ggplot2)
library(MASS)

# Poisson Distribution  ---------------------------------------------------

#discrete distribution 
#range of integers 0 to infinity- no negative values can be generated
# parameter lambda > 0 (continuous)
# constant rate parameter (observations per unit time or unit area)

#4 kinds of elements we can create in R

# d function for probability density 
hits <- 0:10
my_vec <- dpois(x=hits, lambda=4.4)
qplot(x=hits, 
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("violet")) #single variable use I before this 
# as lambda gets larger the distribution looks more and more normal #density looks at which values are probable, which are less probable. when lambda=4.4, the most likely value is 4 but the  average value is 4.4 because that's what we specified 


#for a poisson with lambda=2, 
#what is the probability that a single draw will yield x=0
dpois(x=0, lambda=2)
hits <- 0:10
my_vec <-ppois(q=hits,lambda=2)
qplot(x=hits, 
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("darkorchid"))

#for a poisson with lambda=2 what is the probability that a single random draw will yield x <= 1

ppois (q=1,lambda = 2)

p1<-dpois(x=1,lambda = 2)
print(p1)
p2 <- dpois(x=0,lambda=2)
print(p2)
p1+p2 #same as ppois because it's cumulative...?

#the 1 function is the inverse of p

qpois(p=0.5,lambda = 2.5)

#simulate a poisson to get actual values
ran_pois <- rpois(n=1000, lambda=2.5)
qplot(x=ran_pois,
      color=I("black"),
      fill=I("cornflowerblue"))
quantile(x=ran_pois,probs=c(0.025,0.975)) #leaves 5 percent in the tail, has a 95% confidence interval


# Biomial  ----------------------------------------------------------------

# yes no black white succeed fail
#p=probability of the dichotomous outcome (usually number of successes in a trial)
#size = number of trials 
#x=number of possible outcomes
#outcome x is bounded between 0 and size. cant have more outcomes than the number of trials you did 

#density function for bionomial
hits <- 0:10
my_vec <- dbinom(x=hits, size=10, prob=0.5)
qplot(x=hits, 
      y=my_vec,
      geom="col",
      color=I("darkorchid"),
      fill=I("palegreen"))
#what is the probabiity of getting 5 heads out of 10 tosses
dbinom(x=5, size=10,prob=0.5)

#biased coin
biased <- dbinom(x=hits,size=10,prob= 0.1)
qplot(x=hits, 
      y=biased,
      geom="col",
      color=I("black"),
      fill=I("violet"))

#p function for tail probability 
#probability of 5 or fewer heads
# out of 10 tosses
pbinom(q=5,size=10,prob=0.5)
#get a 95% confidence interval using the q function 
#what is the 95% confidence interval for 100 trials of a coin wiht p=0.7
qbinom(p=c(0.025,0.975),
       size=100,
       prob=0.7)
# how does this compare to a sample interval for real data
#rbinom gives a random set of values 

my_coins <- rbinom(n=50,
                   size=100,
                   prob=0.50)
qplot (x=my_coins,
      color=I("black"),
      fill=I("violet"))
quantile(x=my_coins,probs=c(0.025,0.975))
#give me a vector of numbers of cintuous value sand ill give you the relative probability


# Negative binomical ------------------------------------------------------

#number of failures 
#in a series of (Bernouli) with p=probabillity of success (=size)
#before a targeted number of successes (=size)
# generattes a distribution that is more heterogenous ("overdispersed") than poisson

hits <- 0:40
my_vec <-dnbinom(x=hits, 
                 size=5,
                 prob=0.5)
qplot(x=hits, 
      y=my_vec,
      geom="col",
      col=I("black"),
      fill=I("goldenrod"))

#geometric series is a special case where the number of successes is equal to 1
#each bar is a constant fraction of the one that came before it with probability 1-p
my_vec <- dnbinom(x=hits,
                  size=1,
                  prob=0.1)
qplot(x=hits, 
      y=my_vec,
      geom="col",
      col=I("black"),
      fill=I("goldenrod"))
# each successive bar is 90% the size of the one before it 
# alternatively specify mean = mu of distribution and  size
# this gives us a poisson with a lambda value that varies 
# dispersion parameter is the shape parameter from a gamma disribution 
#as the distribution increases, the variance gets smaller

nbi_ran <- rnbinom(n=1000,size=0.1,mu=5)
qplot(nbi_ran,
      color=I("black"),
      fill=I("goldenrod"))
#mean is still 5 but the distribution is more heterogenous, more small values. making the size small makes the variance greated 