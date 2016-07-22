#http://r-survey.r-forge.r-project.org/survey/example-svrepdesign1.html

setwd("/users/montesdeocar/rm/RM100096/DATA/ACS/")
getwd()
acs <- read.csv("acs_fake1.csv", as.is=TRUE)

###create replicate-weight survey object 
library(survey)
options( "survey.replicates.mse" = TRUE ) 

acs.rep <- svrepdesign(repweights = acs[200:279], weights = ~PWGTP, combined.weights = TRUE, 
                          type = "JK1", scale = 4/80, rscales = rep(1, 80), data = acs) 
acs.rep
summary(acs.rep)

results<-svymean(~RAC1P_sud+agep65_sud, acs.rep)
coef(results)

##################################################################################################

mytable<-table(acs$RAC1P_sud, acs1$agep65_sud)
mytable


####################################################################################################


####OUTPUT goes to the file acs2013 results.txt
sink("/users/montesdeocar/rm/RM100096/LST AND LOG/acs1 results.txt", append=FALSE, split=FALSE)

results<-svymean(~RAC1P_sud+agep65_sud, acs.rep)
coef(results)

results<-svymean(~RAC1P_sud+AGEP, acs.rep)
coef(results)


####Close OUTPUT goes to the file acs2013 results.txt
sink()
file.show("/users/montesdeocar/rm/RM100096/LST AND LOG/acs1 results.txt")

