# --------------------------------
#  Basic anatomy of for loops
# 13 Apr 2020
# AEH
# --------------------------------
#

#Anatomy of a for loop
# for (var in seq){# start of the loop}

# body of the for loop 

# } end of the loop 

# var is a counter variable that holds the current value of the counter in the loop 
# number that incriments by one as we proceed through the loop
# seq is an integer vector, or a vector of character strings that defines the starting and ending values of the loop 
# suggest using variables i,j,k for var (counter) helps keep track of the sequence 

my_dogs <- c("chow","akita", "malamute", "husky", "samoyed")

for (i in my_dogs) {
  print(i) 
}

# set it up this way instead using an integer sequence

for (i in 1:length(my_dogs)) {
  cat("i =", i,"my_dogs[i]=", my_dogs[i], "\n")
}

# potential hazard: suppose our vector is empty! second look the counter will=0 because length of my_bad_dogs is null 
my_bad_dogs <- NULL 
for (i in 1:length(my_bad_dogs)){
  cat("i =", i,"my__bad_dogs[i]=", my_dogs[i], "\n")
}

#safer way to do this is to use seq_along 
for (i in seq_along(my_dogs)) {
  cat("i =", i,"my_dogs[i]=", my_dogs[i], "\n")
}

# handels the empty vector correctly- which is nothing c/c the length is nothing. no weird loop from 1-0 like the last one 
my_bad_dogs <- NULL 
for (i in seq_along(my_bad_dogs)){
  cat("i =", i,"my__bad_dogs[i]=", my_dogs[i], "\n")
}

zz <- 5
for (i in seq_len(zz)) {
  cat("i =", i,"my__bad_dogs[i]=", my_dogs[i], "\n")
}

#tip 1: do NOT change object dimensions inside a loop 
# avoid these functions (cbind,rbind, c, list)

my_dat <- runif(1)
for (i in 2:10) {
  temp <- runif(1)
  my_dat <- c(my_dat,temp)
  cat("loop number=", i, "vector element=", my_dat[i], "\n")
}
print(my_dat)

# tip 2: dont o things in a loop if you don't need to
for (i in 1:length(my_dogs)) {
  my_dogs[i] <- toupper(my_dogs[i])
  cat("i =", i, "my_dogs[i]=",my_dogs[i], "\n")
}

z <- c("dog","cat","pig")
toupper(z) # do this out of the loop as a vectorized operation 

#Tip 3: do not use a loop at all if you can vectorize!

my_dat <- seq(1:10)
for (i in seq_along(my_dat)) {
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number=", i, "vector element=",my_dat[i],"\n")
}

# no loop needed for that 
z <- 1:10
z <- z+z^2
print(z)

# tip 4: understand distinction between the counter variable i, and the vector element z(i)

z <- c(10,2,4)
for (i in seq_along(z)){
  cat("i=",i,"z[i]=",z[i],"\n") 
}

# what is the value of i at the end of the loop 
print(i)

#what is the value of z at the end of the loop?
print(z) #get vector of values out 

# tip 5: 

z <- 1:20
# suppose we want to work only with odd numbered elements

for (i in seq_along(z)) {
  if (i%% 2==0) next
  print (i)
}#take element i divide by 2 and look and see if the remainder is 0. if yes-- next go to the end of for loop 

z <- 1:20
z_sub <- z[z%% 2!=0] #contrast with logical expression in loop 
length(z)
length(z_sub)
for (i in seq_along(z_sub)) {
  cat("i =", i, "z_sub[i] = ",z_sub[i], "\n")
}

#learn to use break functoin to leave loop before you've gon e through all the elements
# tip 6: use break to set up a conditional to break out of a loop early
# create a simle random walk population model function

# --------------------------------
# FUNCTION ran_walk
# description: stochastic random walk 
# inputs: times = number of time steps we'll let the simmulation run n1= initial population size (=n[1]) 
#       lambda = finite rate of increase 
#       noise_sd = standard deviation of a normal distribution with mean 0
# outputs: vector n with population sizes > 0 
#     continue until etinction, then NA values will fill in 
###################################
library(tcltk)
library(ggplot2)
n1=50
ran_walk <- function(times=100,
                     nl=50,
                     lambda=1.0,
                     noise_sd=10) { #start of function 
  n <- rep(NA,times) #create output vector 
  n[1] <- n1 #initialize starting population size
  noise <- rnorm(n=times,mean=0,sd=noise_sd) #create random noise vector
  
  for (i in 1:(times - 1)){ #start of the for loop 
    n[i + 1] <- n[i]*lambda + noise[i] #carry out activities until we generate a 0 or neg value using value of the counter
    if(n[i +1] <= 0) { # start of if statment 
      n[i + 1] <- NA 
      cat("Population extinctionat time", i, "\n")
      tkbell() # ring a bell 
      break 
    } #end of the if statment
  } # end of the for loop
  return (n) #the vector we created 
return("Checking...ran_walk")

} # end of ran_walk
# --------------------------------

# explore model parameters interactively with simple graphics
#see what it kicks out under different condition s

pop <- ran_walk()
qplot(x=1:100, y=pop,geom="line")

pop <- ran_walk(noise_sd = 5,lambda = 0.98)
qplot(x=1:100,y=pop,geom="line")

#long term average is declining, but we can observe fluctuations 

#double for loops- one loop embedded in another
m <- matrix(round(runif(20),digits=2),nrow=5)
# loop over rows
for (i in 1:nrow(m)) { # could use for (i in seq_len(nrow(m)))
  m[i,] <- m[i,] + i
} 
print(m)

m <- matrix(round(runif(20), digits=2),nrow=5)
# loop over columns
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# loop over rows and columns with double for loop 
m <- matrix(round(runif(20),digits=2),nrow=5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j 
    
  } # end of inner (column) group 
} # end of the outer(row) group
print(m)
