# Getting-and-Cleaning-Data-Course-Project
Assignment: Getting and Cleaning Data Course Project
For creating a tidy data set of wearable computing data originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Files in this repo

README.md 

CodeBook.md -- codebook describing variables, the data and transformations

run_analysis.R -- actual R code

###run_analysis.R goals

You should create one R script called run_analysis.R that does the following: 1. Merges the training and the test sets to create one data set. 2. Extracts only the measurements on the mean and standard deviation for each measurement. 3. Uses descriptive activity names to name the activities in the data set 4. Appropriately labels the data set with descriptive activity names. 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script assumes it has in it's working directory the following files and folders:

activity_labels.txt
features.txt
test/
train/
The output is created in working directory with the name of tidy.txt

###run_analysis.R walkthrough

####Step 1:
Read all the input test and training files: y_test.txt, subject_test.txt and X_test.txt.
Merge the files to a data frame in the form of subjects, labels, the rest of the data.

####Step 2:
Read the features from features.txt and only collect either means ("mean()") or standard deviations ("std()"). A new data frame is then created that includes subjects, labels and the described features.

####Step 3:
Read the activity labels from activity_labels.txt and replace the numbers with the text.

####Step 4:
Make a column list 
Clean the list by removing all non-alphanumeric characters and converting the result to lowercase
Use the cleaned up column names in the dataframe

####Step 5:
Create a new dataframe by finding the mean for each combination of subject and label using the aggregate() function

####Step 6:
Write the cleaned data into a text file called tidy.txt, formatted similarly to the original files.
