
##run_analysis.R does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## step 1
# read all the input data
test.labels <- read.table("test/y_test.txt", col.names="label")
test.subjects <- read.table("test/subject_test.txt", col.names="subject")
test.data <- read.table("test/X_test.txt")
train.labels <- read.table("train/y_train.txt", col.names="label")
train.subjects <- read.table("train/subject_train.txt", col.names="subject")
train.data <- read.table("train/X_train.txt")

# Merge all columns into single dataset
data <- rbind(cbind(test.subjects, test.labels, test.data), cbind(train.subjects, train.labels, train.data))

## step 2
# read the features
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
# pull features with mean and standard deviation
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# select only the means and standard deviations from data
# increment by 2 because data has subjects and labels in the beginning
data.mean.std <- data[, c(1, 2, features.mean.std$V1+2)]

## step 3
# read the activity labels
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
# replace activity in data with label names
data.mean.std$label <- labels[data.mean.std$label, 2]

## step 4
# create a list of the current column and feature names
good.colnames <- c("subject", "label", features.mean.std$V2)
# clean the list of column names by removing all non-alphanumeric characters and convert the name to a lowercase string
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))
# use the updated list as column names for the data
colnames(data.mean.std) <- good.colnames

## step 5
# find the mean for each pair of subject and activity
aggr.data <- aggregate(data.mean.std[, 3:ncol(data.mean.std)],
by=list(subject = data.mean.std$subject,
label = data.mean.std$label)
,mean)

# write the data to a table
write.table(format(aggr.data, scientific=T), "tidy.txt",row.names=F, col.names=F, quote=2)
