# Basic examples of data types and their uses 
# Feb 4 2020
# AEH

#   -----------------------------------------------------------------------

x <- 5
y = 4 #legal but not used except in function defaults 
y = y+1
y <- y+1
y
print (y)

#   -----------------------------------------------------------------------

#combine or concatenate function 
z <- c(3.2,5,5,6)
print(z)
typeof(z)
is.numeric(z)
z <- c("perch", "striped bass" , 'trout')
print(z)
print(z)

#   -----------------------------------------------------------------------

#properties of atomic vectors 
#each has a unique type
typeof(z)
is.logical(z)
length(z)

#optinal names
z <- runif(5)
print(z)
names(z)
names(z) <- c("chow", 
              "pug", 
              "beagle",
              "greyhound",
              "akita")
print(z)
z[3]
z[c(3,4)]
z[c("beagle","greyhound")]
z2 <- c(gold=3.3,silver=10, lead=2)
print(z2)
#resset names
names(z2) <- NULL
#name some, not others
names(z2) <- c("copper" , "zinc")
print(z2)

#   -----------------------------------------------------------------------

#NA for missing data
z <- c(3.2, 3.3, NA)
typeof(z)
length(z)
typeof(z[3]) #only the third element of z
z1 <- NA
typeof(z1)
is.na(z) #first two values are numbers, so false, the third IS na so True
!is.na(z) #boolian to find NOT Na
mean(z) #you'l get na because one of the values isnt numeric
mean(z[!is.na(z)])

z <- 0/0
print(z)
typeof(z)
z <- 1/10
print (z)
z <- -1/10
print(z)
z <- NULL
typeof(z)
length(z)
is.null(z)

#   -----------------------------------------------------------------------

# Three features of atomic vectors

# 1. coersion 
#All atomics are of the same type
# if elements are different, R coerces them 
# logical -> integers -> double -> character

z <- c(0.1, 5, "0.2")
typeof(z) #it will say character because character is the lowest on the pecking order

#use coercion for useful calculations
a <- runif(10)
print(a)
a > 0.5 #get back a true or falce
sum(a > 0.5) #how many numbers in the list are greater than 0.5
mean(a > 0.7) # proportion of values greater than 0.7

#qualifying exam question:
#in a normal distribution approximately what percent of observations from a normal (0,1) are larger than 2.0
mean(rnorm(100000) > 2)

#2 Vectorization 
z <- c(10,20,30)
z+1 #if you give formulas to a vector containing multiple elements it will perform it on all elements of the vector
z2 <- c(1,2,3)
z+z2 #go through element by element through 10 + 1, 20 +2, 30+3
#if the vector doesnt line up it will recycle through the shorter vector 
