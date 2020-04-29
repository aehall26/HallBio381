# Batch Processing  --------------------------------
#works with a number of files and carry out the same processes on each of them and save to a singular file with a clean output with everything that you need. 

# getwd() tells you where the current path lies. 
#absolute paths begin with the root and go to where you are
#relative satart where you are and go forward from that 
#list.files() shows you the files within your directory
# dir.create("name of firectory") creates a directory from within the working directory that you're in 
#dir.create("NameOfDirectory/someFiles",recurssive=TRUE) creates subdirectory within a directory

#build from scratch 100 random data files. Usually you wouldnt have to build this because you would use your own data

# --------------------------------
# FUNCTION file_builder
# description: creates a set of random files for regression 
# inputs: n= number of files to create
#         file_folder = name of folder for random files
#         file_size = c(min,max) number of rows in the file
#         file_NA = average number of NA values per column  
# outputs: creates a set of random files 
###################################
file_builder <- function(file_n=10,
                         file_folder="RandomFiles/",
                         file_size=c(15,100),
                         file_NA=3) {
  for (i in seq_len(file_n)) {
    file_length <- sample(file_size[1]:file_size[2],size=1) #determines size for that particular file
    var_x <- runif(file_length) #create random x
    var_y <- runif(file_length) #create random y
    df <- data.frame(var_x,var_y) # bind into a data frame
    bad_vals <- rpois(n=1, lambda = file_NA) #poisson is integer values including 0  is mean is low enough lambda is file_NA because on average we will have 3 NAs or bad values
    df[sample(nrow(df),size=bad_vals),1] <- NA 
    df[sample(nrow(df),size=bad_vals),2] <- NA 
    
# create label for file name with padded zeros 
    file_label <- paste(file_folder,"ranFile",
                        formatC(i,
                                width=3, 
                                format="d",
                                flag="0"),
                                  ".csv",
                                sep="")
    #set up data file and incorporate a time stamp and minimal metadata 
    write.table(cat("# Simulated random data file for batch processing","\n",
                    "# timestamp: ", as.character(Sys.time()),
                    "\n",
                    "# AEH", "\n",
                    "#  --------------------------------", "\n",
                    "\n",
                    file=file_label,
                    row.names="",
                    col.names="",
                    sep=""))
    #now add the data frame
    write.table(x=df, 
                file=file_label,
                sep=",",
                row.names=FALSE,
                append=TRUE)
  } #end of for loop

} # end of file_builder
# --------------------------------

# --------------------------------
# FUNCTION reg_stats
# description: fits linear models, etract model states
# inputs: i2 column data frame (x and y)
# outputs: slope, pvalue, and r2
###################################
reg_stats <- function(d=NULL) {
              if(is.null(d)) {
                x_var<-runif(10)
                y_var<- runif(10)
                d <- data.frame(x_var,y_var)
              }
  .<-lm(data=d,d[,2]~d[,1])
  . <- summary(.)
  stats_list <- list(Slope=.$coefficients[2,1],
                     pVal=.$coefficients[2,4],
                     r2=.$r.squared)
  
return(stats_list)
} # end of reg_stats
# --------------------------------
# body of program using functions written above --------------------------------

library(TeachingDemos)
char2seed("play cello")

########################################
# Global variables 
file_folder <- "RandomFiles/" #/ indicates directory
n_files <- 100
file_out <- "StatsSummary1.csv"
########################################

#create random data sets
dir.create(file_folder)
file_builder(file_n=n_files)
file_names <- list.files(path=file_folder)

# Create a data frame to hold summary file statistics 
ID <- seq_along(file_names)
file_name <- file_names
slope <- rep(NA, length(file_names))
p_val <- rep(NA, length(file_names))
r2 <- rep(NA, length(file_names))

stats_out <- data.frame(ID,file_name,slope,p_val,r2)

# batch process by looping through individual files and operatuing on them

for (i in seq_along(file_names)) {
  data <- read.table(file=paste(file_folder,file_names[i],
                                sep=""), # in the paste function
                                sep=",", # in the read table which is a csv so we need a ,
                                header=TRUE)
  d_clean <- data[complete.cases(data),] #subset for clean cases 
  
  
  . <- reg_stats(d_clean) # pull out regression stats from cleaned file 
  stats_out[i,3:5] <- unlist(.) # gives 3 elements that will plug into last 3 columns 
}

# set up output file and incorporate time stamp and minimal metadata

write.table(cat("#summary stats for",
                  "batch processing of regression models",
                "\n",
                  "# timestamp: ", as.character(Sys.time()),
                "\n",
                file=file_out, 
                row.names="",
                col.names="",
                sep=""))

#now add the data frame 
write.table(x=stats_out, 
            file=file_out, 
            row.names=FALSE, 
            col.names=TRUE, 
            sep=",",
            append=TRUE)
