Getting-and-Cleaning-Data-Course-Project
========================================

Course project for Getting and Cleaning Data Coursera Course

This repo contains

1. An analysis script in R (run_analysis.R), which takes an accelerometer dataset [1] and puts it into a tidy data format 
2. A code book (CodeBook.md) that describes the variables, the data, and any transformations performed to clean up the data.
3. A dataset (merged_data.csv), which contains the data on variables with mean or stdev for both testing and training sets
4. A dataset (tidy_data.csv), which contains the average of each variable for each activity for each subject. 


This tidy data follows the following principles outlined in the course project assignment:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 






The data used to generate the files in this repository was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on 2014 04 15. For detailed information about the data see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

