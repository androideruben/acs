####coursera
###R Programming by Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD

##Set working directory
#setwd("~/rm/RMr/specdata")
#setwd("C:/Users/ruben/Documents/coursera/specdata")

##Part 1##

#Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) 
#across a specified list of monitors. 
#The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
#Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from 
#the directory specified in the 'directory' argument and returns the mean of the pollutant across 
#all of the monitors, ignoring any missing values coded as NA.

##1a) set working directory as a function:
mydir <- function(directory) { setwd( directory) }
mydir("~/rm/RMr/specdata")

##1b) Send all data names to a list:
#filelist0 <- list.files(pattern="*.csv")
filelist0 <- list.files(pattern="*.csv")
filelist<- as.numeric(substring(filelist0, 1, 3) )
filelist

##1c) Concatenate all data:
mydata <- do.call("rbind", lapply(filelist0, function(x) read.csv(paste( x, sep=''), stringsAsFactors = FALSE)))

##testing data:
nrow(mydata)
head(mydata,2)
tail(mydata, 2)
str(mydata)
mydata[47,]

##1d) function 'polutmean':
pollutantmean=function(x, y, z) { {  
  mydir("/home/montesdeocar/rm/RMr/specdata")
  max(subset(mydata, ID==y, select=z), na.rm=TRUE)}}

##compare my results to the examples in:
##https://d396qusza40orc.cloudfront.net/rprog%2Fdoc%2Fpollutantmean-demo.html
#pollutantmean("specdata", "nitrate", 70:72)

pollutantmean(x, 23, "nitrate")


##End of part 1##



##Part 2
##Write a function that reads a directory full of files and reports the number of completely 
##observed cases in each data file. The function should return a data frame where the first 
##column is the name of the file and the second column is the number of complete cases.
complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases






