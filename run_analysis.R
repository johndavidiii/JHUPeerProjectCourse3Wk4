#install.packages("XML")
#install.packages("methods")
#install.packages("plyr")
#install.packages("dplyr")
#install.packages("jpeg")
library(data.table)
library(xlsx)
library(XML)
library(methods)
library(dplyr)
library(jpeg)
#library(plyr)

# This routine wants to see a data directory called /data in the working directory
# its probably best to set the working directory to a directory of your choice then place
# the jhu data set in a directory called /data
# assuming the data is in the correct place this routine will work and produce
# three files. A text file output, a csv file output and a csv of the output std and mean values

# this data did not require a great deal of cleaning.  I used na.omit to remove any
# na's from the data.  The std function ignores them and the mean can be made to ignore 
# them but I wanted to make sure that the data was tidy so I used na.omit()

# the only variables that I changed were the column names. I used the gsub function
# to make the changes to something more meaningful

# you may or may not have to set the working directory, your choice as long as the data
# is located in a directory called /data located directory underneath the current directory
#cPath <- setwd(Set this path so that the .R file is just above the /data directory)

cPath <- getwd()

print("current Directory")
print(cPath)

print("Complete Generic Input Data Path")
print(gsub(" ","", paste(cPath, "/data/UCI-HAR-Dataset/","")))

totalXTestFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/test/Inertial-Signals/total_acc_x_test.txt",""))
totalYTestFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/test/Inertial-Signals/total_acc_y_test.txt",""))
totalZTestFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/test/Inertial-Signals/total_acc_z_test.txt",""))

totalXTestGyroFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/test/Inertial-Signals/body_gyro_x_test.txt",""))
totalYTestGyroFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/test/Inertial-Signals/body_gyro_y_test.txt",""))
totalZTestGyroFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/test/Inertial-Signals/body_gyro_z_test.txt",""))

totalXTrainFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/train/Inertial-Signals/total_acc_x_train.txt",""))
totalYTrainFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/train/Inertial-Signals/total_acc_y_train.txt",""))
totalZTrainFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/train/Inertial-Signals/total_acc_z_train.txt",""))

totalXTrainGyroFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/train/Inertial-Signals/body_gyro_x_train.txt",""))
totalYTrainGyroFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/train/Inertial-Signals/body_gyro_y_train.txt",""))
totalZTrainGyroFilePath <- gsub(" ","",paste(cPath,"/data/UCI-HAR-Dataset/train/Inertial-Signals/body_gyro_z_train.txt",""))

print("Reading and Processing Data")

xTestTable2 <- read.table(totalXTestFilePath,header=F,sep = "")
xTestTable <- na.omit(xTestTable2)
xNameAry <- c(names(xTestTable))
xNameAry <- gsub("V","x-Test-Person-", xNameAry)
colnames(xTestTable) <- xNameAry

yTestTable2 <- read.table(totalYTestFilePath,header=F,sep = "")
yTestTable <- na.omit(yTestTable2)
yNameAry <- c(names(yTestTable))
yNameAry <- gsub("V", "y-Test-Person-", yNameAry)
colnames(yTestTable) <- yNameAry

zTestTable2 <- read.table(totalZTestFilePath,header=F,sep = "")
zTestTable <- na.omit(zTestTable2)
zNameAry <- c(names(zTestTable))
zNameAry <- gsub("V", "z-Test-Person-", zNameAry)
colnames(zTestTable) <- zNameAry

xGyroDF2 <- read.table(totalXTestGyroFilePath,header=F,sep = "")
xGyroDF <- na.omit(xGyroDF2)
xGyroNameAry <- c(names(xGyroDF))
xGyroNameAry <- gsub("V", "x-Gyro-Person-", xGyroNameAry)
colnames(xGyroDF) <- xGyroNameAry

yGyroDF2 <- read.table(totalYTestGyroFilePath,header=F,sep = "")
yGyroDF <- na.omit(yGyroDF2)
yGyroNameAry <- c(names(yGyroDF))
yGyroNameAry <- gsub("V", "y-Gyro-Person-", yGyroNameAry)
colnames(yGyroDF) <- yGyroNameAry

zGyroDF2 <- read.table(totalZTestGyroFilePath,header=F,sep = "")
zGyroDF <- na.omit(zGyroDF2)
zGyroNameAry <- c(names(zGyroDF))
zGyroNameAry <- gsub("V", "z-Gyro-Person-", zGyroNameAry)
colnames(zGyroDF) <- zGyroNameAry

xTrainTable3 <- read.table(totalXTrainFilePath,header=F,sep = "")
xTrainTable2 <- na.omit(xTrainTable3)
xTrainNameAry <- c(names(xTrainTable2))
xTrainTable <- data.frame(xTrainTable2[1:2947,xTrainNameAry])
xTrainNameAry <- gsub("V", "x-Train-Person-", xTrainNameAry)
colnames(xTrainTable) <- xTrainNameAry

yTrainTable3 <- read.table(totalYTrainFilePath,header=F,sep = "")
yTrainTable2 <- na.omit(yTrainTable3)
yTrainNameAry <- c(names(yTrainTable2))
yTrainTable <- data.frame(yTrainTable2[1:2947,yTrainNameAry])
yTrainNameAry <- gsub("V", "y-Train-Person-", yTrainNameAry)
colnames(yTrainTable) <- yTrainNameAry

zTrainTable3 <- read.table(totalZTrainFilePath,header=F,sep = "")
zTrainTable2 <- na.omit(zTrainTable3)
zTrainNameAry <- c(names(zTrainTable2))
zTrainTable <- data.frame(zTrainTable2[1:2947,zTrainNameAry])
zTrainNameAry <- gsub("V", "z-Train-Person-", zTrainNameAry)
colnames(zTrainTable) <- zTrainNameAry

xTrainGyroTable3 <- read.table(totalXTrainGyroFilePath,header=F,sep = "")
xTrainGyroTable2 <- na.omit(xTrainGyroTable3)
xTrainNameAry <- c(names(xTrainGyroTable2))
xTrainGyroTable <- data.frame(xTrainGyroTable2[1:2947,xTrainNameAry])
xTrainNameAry <- gsub("V", "x-Train-Gyro-Person-", xTrainNameAry)
colnames(xTrainGyroTable) <- xTrainNameAry

yTrainGyroTable3 <- read.table(totalYTrainGyroFilePath,header=F,sep = "")
yTrainGyroTable2 <- na.omit(yTrainGyroTable3)
yTrainNameAry <- c(names(yTrainGyroTable2))
yTrainGyroTable <- data.frame(yTrainGyroTable2[1:2947,yTrainNameAry])
yTrainNameAry <- gsub("V", "y-Train-Gyro-Person-", yTrainNameAry)
colnames(yTrainGyroTable) <- yTrainNameAry

zTrainGyroTable3 <- read.table(totalZTrainGyroFilePath,header=F,sep = "")
zTrainGyroTable2 <- na.omit(zTrainGyroTable3)
zTrainNameAry <- c(names(zTrainGyroTable2))
zTrainGyroTable <- data.frame(zTrainGyroTable2[1:2947,zTrainNameAry])
zTrainNameAry <- gsub("V", "z-Train-Gyro-Person-", zTrainNameAry)
colnames(zTrainGyroTable) <- zTrainNameAry

print(nrow(xTestTable))

print("building final DF")
meldedDF <- data.frame(xTestTable,yTestTable,zTestTable,xGyroDF,yGyroDF,zGyroDF,xTrainTable,yTrainTable,zTrainTable,xTrainGyroTable,yTrainGyroTable,zTrainGyroTable)

cPath <- getwd()
print("output data directory")
print(cPath)

outputDataPathTxt <- gsub(" ","", paste(cPath, "/course3_wk4_project_DF_output.txt"))
outputDataPathCSV <- gsub(" ","", paste(cPath, "/course3_wk4_project_DF_output.csv"))
outputStatsDataPathCSV <- gsub(" ","", paste(cPath, "/course3_wk4_project_stats_output.csv"))

write.table(meldedDF, file = outputDataPathTxt, sep = ",", row.names= F) # the text file

write.csv(meldedDF,outputDataPathCSV)

stdAry1 <- apply(meldedDF,2,sd)
meanAry1 <- apply(meldedDF,2,mean)

statsDF <- data.frame(stdAry1,meanAry1)
colnames(statsDF) <- c("std","mean")
rowNameAry1 <- c(row.names(statsDF))
rowNameAry1 <- gsub("x.Test.Person.", "Test-Person-",rowNameAry1)
rownames(statsDF) <- rowNameAry1
print(head(statsDF))

write.csv(statsDF,outputStatsDataPathCSV)
