# Finishing data frames and lists
#formatting data
# 13 Feb 2020


# -------------------------------------------------------------------------

#matrix and data frame similarities and differences 

z_mat <- matrix(data=1:30,ncol=3, byrow=TRUE)
z_dataframe <- as.data.frame(z_mat) #10 observations of three unnamed variables 
#structure 
str(z_mat)
str(z_dataframe)

#appearance
head(z_mat)
head(z_dataframe)

#element referencing 
z_mat[2,3]
z_dataframe[2,3]

# column referencing 
z_mat[,2]
z_dataframe[,2]
z_dataframe$V2 #specify the column that you want 

#rows referencing 
z_mat[2,]
z_dataframe[2,] #all the columns in row two. 

#specifying single elements is different!
z_mat[2] #instructs to grab the second element of our vector 
#z_mat[1,2] #better 
z_dataframe[2] #but this pulls ou the whole column
#z_dataframe$V2'
zD <- c(runif(3),NA,NA,runif(2))
zD
complete.cases(zD)
zD[complete.cases(zD)] #subsetting of only what does not include missing cases. #include a ! before the complete to include only false items
m <-matrix(1:20, nrow=5)
m[1,1]<-NA #write in missing cases
m[5,4]<- NA #write in more missing cases 
#apply complete cases function more selectively. don't apply indiscriminately 
m
#sweep out all rows with missing values
m[complete.cases(m),] #for all rows with missing cases 
#sweep out all columns with certain columns (1 and 2)
m[complete.cases(m[,c(1,2)]),]# drop row #1
m[complete.cases(m[,c(2,3)]),] #only those that have complete cases in 2 and 3. Checks 2 and three, dont check the rest. So this wont drop anything. 
m[complete.cases(m[,c(3,4)]),] #drop row 4
m[complete.cases(m[,c(1,4)]),] #drop rows 1 and 4 because in those two rows there are missing values
#techniques for assigmnets and sibetting matrices and data frames
m<- matrix (data=1:12,nrow=3)
dimnames(m) <- 
  list(paste("Species", LETTERS[1:nrow(m)],sep=""), 
    paste ("Site",1:ncol(m),sep=""))
m
m[1:2,3:4]
m[c("SpeciesA","SpeciesB"),c("Site3","Site4")]

#use blanks to pull all rows orcolumns:
m[c(1,2),]
m[,c(1,2)]
#use logicals for more complex subsetting 
# e.g. select al columns which have totals > 15
colSums(m) >15
m[rowSums(m)==22,] #get rid of one = and add ! before it to see all  that DONT sum to 22
m[, "Site1"]<3 #rows where the vale a site one is less than three 
m["SpeciesA",]< 5
m[m[,"Site1"]<3,m["SpeciesA",]<5]
# caution! simple subscripting can change the data type 
z <- m[1,]
print(z)
str(z)

#use drop=FALSE to retain dimensions when you make the call
z2 <- m[1, ,drop=FALSE]
str(z2)

#basic format is a csv file 


# -------------------------------------------------------------------------

my_data <- read.table(file="FirstData.csv",
                      header=TRUE,
                      sep=",",
                      stringsAsFactors = FALSE) #dont convert character strings into factors 
str(my_data)
#use saveRDS() to save r object as a binary 
my_rds <- saveRDS(my_data)
#better to do this than a save command 
z <-readRDS(my_rds)

