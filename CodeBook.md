# Code Book for Getting and Cleaning Data Project
### AndreaBee for the Coursera project

The purpose of this codebook is to explain the sources and the subsequent
transformations of the dataset(s) used in the project for the course "Getting
and Cleaning Data."

The objectives were the following:

The creation of one R script called run_analysis.R which does the following:

1.Merges the training and the test sets to create one data set.  
2.Extracts only the measurements on the mean and standard deviation for each measurement.  
3.Uses descriptive activity names to name the activities in the data set.  
4.Appropriately labels the data set with descriptive variable names.  
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


1)  The dataset will be downloaded and unzipped to a directory added to your working
directory structure:
        ./UCI HAR Dataset
2)  the download file name will be Dataset


"Descriptive Activity" is found in the activity.label table
"Measurements" are defined in the feature.list table