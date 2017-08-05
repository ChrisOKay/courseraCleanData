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

# get features and test/train data, labeled accordingly



featureNames <- read.csv(fileFeatures, sep=";", header=F)$V1

trainData <- read_fwf(fileTrainX, fwf_widths(rep(16, length(featureNames)), col_names = as.character(featureNames)))

testData <- read_fwf(fileTestX, fwf_widths(rep(16, length(featureNames)), col_names = as.character(featureNames)))

fullData <- rbind(testData, trainData)


filterData <- as.data.frame(fullData[,grepl("(mean\\(\\)|std\\(\\))$", featureNames)])

activityLabels <- read.csv(fileActivity, sep=" ", header=F)$V2

trainLabels = read.csv(fileTrainY, sep=";", header=F)$V1
testLabels = read.csv(fileTestY, sep=";", header=F)$V1
fullLabels <- c(testLabels, trainLabels)
activity <- activityLabels[fullLabels]

filterData <- cbind(activity,filterData)

filterData %>%
  group_by(activity) %>%
  summarise_all(mean) %>%
  write.table(file = fileTidy, row.name=FALSE)

