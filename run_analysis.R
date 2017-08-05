
library(readr)

featureNames <- read.csv("features.txt", sep=";", header=F)$V1

fileName = "X_train.txt"

con = file(fileName, "r")
line = readLines(con, n = 1)
close(con)

trainData <- read_fwf(fileName, fwf_widths(rep(16, nchar(line)/16), col_names = as.character(featureNames)))

fileName = "X_test.txt"

con = file(fileName, "r")
line = readLines(con, n = 1)
close(con)

testData <- read_fwf(fileName, fwf_widths(rep(16, nchar(line)/16), col_names = as.character(featureNames)))



