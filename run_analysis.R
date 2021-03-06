# load required packages
library(readr)
library(dplyr)

# set directory and required file paths
setwd("~/GitHub/courseraCleanData")
fileFeatures <- file.path("UCI HAR Dataset", "features.txt")
fileActivity <- file.path("UCI HAR Dataset", "activity_labels.txt")
fileTrainX <- file.path("UCI HAR Dataset", "train",  "X_train.txt")
fileTestX <- file.path("UCI HAR Dataset", "test",  "X_test.txt")
fileTrainY <- file.path("UCI HAR Dataset", "train",  "y_train.txt")
fileTestY <- file.path("UCI HAR Dataset", "test",  "y_test.txt")
fileTidy <- file.path("tidyData.txt")

# get features and test/train data, label accordingly & merge

featureNames <- read.csv(fileFeatures, sep=";", header=F)$V1

trainData <- read_fwf(fileTrainX, fwf_widths(rep(16, length(featureNames)), col_names = as.character(featureNames)), cols(.default = col_double()))

testData <- read_fwf(fileTestX, fwf_widths(rep(16, length(featureNames)), col_names = as.character(featureNames)), cols(.default = col_double()))

fullData <- rbind(testData, trainData)

# filter data bei mean() and std() entries only

filterData <- as.data.frame(fullData[,grepl("(mean\\(\\)|std\\(\\))$", featureNames)])

# get activity labels 
activityLabels <- read.csv(fileActivity, sep=" ", header=F)$V2

trainLabels = read.csv(fileTrainY, sep=";", header=F)$V1
testLabels = read.csv(fileTestY, sep=";", header=F)$V1
fullLabels <- c(testLabels, trainLabels)
activity <- activityLabels[fullLabels]

# merge activities with remaining data

filterData <- cbind(activity,filterData)

# summarise filtered data by activity, write to file

tidyData <- summarise_all(group_by(filterData, activity), mean)
  
write.table(tidyData, file = fileTidy, row.name=FALSE)
