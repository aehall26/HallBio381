# --------------------------------
# Booleans and if/else control structures
# 05 Apr 2020
# AEH
# --------------------------------
#

# Review of boolean operators. --------------------------------

# Simple inequality 
#uses logical operators 
5 > 3
5 < 3
5 >= 5
5 <= 5
5 ==3 # be sure to use double ==
5 != 3 # doesn't equal 3

# compound statments use & or logical 

# use & for AND which looks at two elements, compares them, and 
FALSE & FALSE
FALSE & TRUE
TRUE & TRUE
5 > 3 & 1!=2
1==2 & 1!=2

#Use | for OR
FALSE | FALSE 
FALSE | TRUE
TRUE | TRUE
1==2 | 1!=2 #returns a TRUE because one element is true

#Boolean operators work with vectors
1:5 > 3
a <- 1:10
b <- 10:1

a > 4 & b > 4
sum(a >4 & b> 4) #coerces booleans to numeric values so the result of this is 2

#evaluate all elements and give a vector of T/F
a < 4 & b > 4

# long form evaluates only the first element so it doesnt return a vector
a < 4 && b > 4 

#also a long form or or ||
#vector result 
a <4 | b >4

#single boolean result 
a < 4 || b > 4

# xor for exclusive "or" testing of vectors
# works for (TRUE FALSE) but not for (FALSE FALSE)
# or (TRUE TRUE)

a <- c(0,0,1)
b <- c(0,1,1)
xor(a,b) #generates a false true false because the forst two are comparisons between zeros two falses yields a false, 0 and 1 is a false and a true which yields a true, the 11 are two trues which kicks back a false. Standard or would generate a true with two trues 

#compare with ordinary | 
a|b

# Set Operations --------------------------------

#boolean algebra on sets of atomic vectors (numeric, logical, character strings)

a<- 1:7
b <- 5:10

#look at set operations to use with these
# union function gets all the elements 
union(a,b) #whats the complete set that has all the elements of the two individuals 

#intersection to get the shared elements between sets (like an and for an entire set)
intersect (a,b)


#setdiff to get the distinc elements in the element we look at 
setdiff(a,b) #find elements distinct in a and not in b

#setdiff to get distinct elements in b
setdiff(b,a)

#setequal to get identical elements
setequal(a,b) #gives a false because a and b are not the same thing

#more generally, to compare any two objects 
z <- matrix(1:12,nrow=4,byrow=TRUE)
z1 <- matrix(1:12,nrow=4,byrow=FALSE) #the two contain the same elements in total but in different places

#this just compares element by element
z==z1 #compares each element to see if we have each element in the same place

#this comapres the two matrices to see if theyre identical 
identical(z,z1) #first we get a false 
z1 <- z #assign z to z1
identical (z,z1) #now we get a true

#most useful in if statements is %in% or is.element
# these are equivalent, but Nick prefers %in% for readability 
d <- 12
d %in% union(a,b) #of all the unique elements in the sets, is d (12) in that
is.element(d,union(a,b)) #same thing

a <- 2
a == 1 | a==2 | a==3 #this works, but its cumberson. will give a true b/c s is one of these options
a %in% c(1,2,3)

#check for partial matching 
a <-1:7

d<-c(10,12)
d %in% union(a,b) #because each element is compared one at a time to the union of a and b
d %in% a #gives a false because a is on;y 1-7

# if statement --------------------------------

# anatomy of if statements

# if (condition) boolean that generates a single true false answer
# if the condition is met, then the expression will be evaluated 

# if (condtion) expression1 else expression2

# if (condition1) expression1, else 
# if (condition2) expression2, else 
# expression3

# - final unspecified else captures rest of the unspecified conditions 
# instead of a single expression, use curly brackes to execture a set of lines to be executed when the condition is met  {}

z <- signif(runif(1),digits=2)
print(z)

#simple if statement with no else
if (z>0.5) cat (z, "is a bigger than average number","\n")

#compound if statement with 3 outcomes (2 if statments)
 
if (z>0.8) cat(z,"is a large number","\n") else
if (z<0.2) cat(z,"is a small number","\n")else
{cat(z,"is a number of typical size ","\n")
  cat("z^2=",z^2,"\n")}
# the second two lines will be executed if the first arent

# if statement wants a single boolean value 
# it will operate only on the very first element in that vector

z <-1:10
# this does not do anything 
if (z>7) print(z)

# probably not what you want
if (z <7) print(z)

#instead use subsetting 
print(z[z<7])

# if else function --------------------------------

#ifelse (test, yes, no)
# "test" is an object that can be coerced into a logical TRUE FALSE
# yes returns values for true elements in the test
# no returns values for false elements in the test

# suppose we have an insect population in which each female lays on average 10.2 eggs, following a poisson distribution. Lambda=10.2, however there is a 35% chance of parisitism in which case, no eggs are laid. 
#Here is a random sample of eggs laid for a group of 1000 individual

tester <- runif(1000) # start with random uniform elements
eggs <- ifelse(tester > 0.35, rpois(n=1000, lambda=10.2),0) #correspond to those cases in which parisitism did nt occur 
hist(eggs)
# suppose we have a vector of probability values (perhaps from a simulation). We want to highlight significant values in the vector for plotting 

p_vals <- runif(1000)
z <- ifelse(p_vals<0.025, "lower_tail","non_sig")
z[p_vals>=0.975] <- "upper_tail"
table(z) #counts out number of elements in each group

# Here is a way using just subsetting 

z1 <- rep("non_sig",1000)
z1[p_vals <= 0.025] <- "lower_tail"
z1[p_vals >=0.975] <- "upper_tail"
table(z1)
