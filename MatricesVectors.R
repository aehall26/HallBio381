#Working with matrices, lists, and data frames
#Feb 11 2020
#AEH


# -------------------------------------------------------------------------


library(ggplot2)


# Matrices ----------------------------------------------------------------

#a matrix is just an atomic vector reorganzed into two dimensions
#create a matrix with a matrix function 

m <- matrix(data=1:12, nrow=4, ncol=3)
print(m)
m <- matrix(data=1:12, nrow=4)

#use by row=TRUE to change filling direction 
m <- matrix(data=1:12, nrow=4, byrow=TRUE)
print(m)

#use the dimensions function 
dim(m)

#change the dimensions of a matrix
dim(m) <- c(6,2)
print(m)
dim(m)<- c(4,3)
print(m)

#individual row and column dimensions
nrow(m)
ncol(m)

#this is to avoid hard coding 
length(m)
#ad names 

rownames(m) <- c("a","b","c","d")
print(m)
colnames(m) <- LETTERS[1:ncol(m)]
print(m)
rownames(m) <- letters[nrow(m):1]
print(m)

#grabbing an entire atomic vector
z <- runif(3)
z[]
#specify rows and columns, seperated by a comma 
m[2,3]
m
#choose row two and all colimns 
m[2,]
#returns the second row and all comuns present 
#all rows only the third column
m[,3]
#print everything 
print(m)
print(m[])
print(m[,])

#dimnames requires a list  #fusing character strings together to make a list
dimnames(m) <- list(paste("Site",1:nrow(m),sep=""),
                    paste("Species",LETTERS[1:ncol(m)],sep="_"))
print(m)
#transpose a matrix
m2 <- t(m)
print(m2)
#add a row to a matrix qwith rbind()
m2 <- rbind(m2,c(10,20,30,40))
print(m2)
rownames(m2)
# call the function to get the atomic 
rownames(m2)[4] #rownaes (m2) creates the atomic vector the [4] means you specify the 4th element

rownames(m2)[4] <-"myfix"
rownames(m2)
print(m2)
# access rows and columns with names as well as index numbers
m2["myfix","Site3"]
m2[4,3] #equivalent 
m2[c("myfix","Species_1"),c("Site2","Site2")]

my_vec <- as.vector(m)
print(my_vec)


# Lists -------------------------------------------------------------------

#lists are like atomic vectors (1 dimensional) but each element can hold different things of different types and sizes


my_list <- list(1:10,matrix(1:8,nrow=4,byrow=TRUE),
                letters[1:3],
                pi)
str(my_list)
#try grabbing one of our list components
my_list[4]
my_list[4]-3 #this doesnt work
typeof(my_list[4])
#double bracket always extracts a single element of the correct type (only a single element)
my_list[[4]]-3
#if a lisst has 10 elements, it is like a train with 10 cars 
#[[5]] gives me the contents of car 4
#[c(4,5,6)] #gives the train with cars 4,5,6
#[5] a train with 1 car #5
my_list[[2]][2,2]
#name list items as we create them
my_list2 <- list(Tester=FALSE, 
                 little_m=matrix(runif(9),nrow=3))
print(my_list2)
my_list2$little_m[2,3]
#found the element in the second row third column
my_list2$little_m
t(my_list2$little_m)
my_list2$little_m[2,]
my_list2$little_m[2]
#using a list to access output from a linear model
y_var <- runif(10)
x_var <- runif(10)
my_model <- lm(y_var~x_var)
qplot(x=x_var,y=y_var)
#plotted a random set of data
print(my_model)
summary(my_model)
str(summary(my_model))
#use the unlist() function to flatten the output
z <- unlist(summary(my_model),recursive = TRUE)
print(z)
my_slope <- z$coefficients2
my_pval<- z$coefficients8
print(c(my_slope,my_pval))

# Data Frame --------------------------------------------------------------

#a list of equal-lengthed vectors, each of which is a column in a data frame. 
#a data frame differs from a matrix only in that different columns may be of different data types

var_a <- 1:12
var_b <- rep(c("Con","LowN","HighN"),each=4)
var_c <- runif(12)
d_frame <- data.frame(var_a,var_b,var_c,stringsAsFactors=FALSE)             
# choose false 

print(d_frame)
head(d_frame)
str(d_frame)
new_data <- data.frame(var_a=13, var_b="HighN",var_c=0.668)
str(new_data)
d_frame <- rbind(d_frame,new_data)
print(d_frame)
# adding a column as an atomic vector 
new_var <- runif(nrow(d_frame))
d_frame <- cbind(d_frame, new_var)
#column bind
head(d_frame)
