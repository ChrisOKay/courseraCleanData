Most of the generated variables are temporary variables designed to create the final data set.

The data collection starts by reading the train and test data. Additionally, the feature list is extracted to label the data set accordingly.
Afterwards, both data sets are merged and filtered by selecting features with end on "mean()" or "std()".
To incorporate the according activity, the activities are read also and merged to the data sets.

The final dataset is called filterData.
It is a data frame which contains all 10299 observations from both test and train datasets. As requested, the variables consist of the activity, and 9 accelerometers readings, both mean and standard devition, i.e. 18 fields in total.

As a last step, and independent data set tidyData is created to summarize filterData by activity via mean. This data set is also written to "tidyData.txt"