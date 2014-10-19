#run_analysis R script, 
#a ReadMe markdown document, 
#a Codebook markdown document, 
#and a tidy data text file (this last goes on Coursera). 

## libraries to ensure are loaded
library(dplyr)

getwd()
#start with a clean load of the data
if(file.exists("./UCI HAR Dataset")){unlink("./UCI HAR Dataset", recursive = TRUE)}

dataset_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 

## the files are binary files so require the mode = 'wb' parameter 
## to successfully unzip
if(!file.exists("Dataset.zip")){
        download.file(dataset_url, destfile="Dataset.zip", mode = 'wb')
}

unzip("Dataset.zip", overwrite= TRUE)
train.dir<-"./UCI HAR Dataset/train"
test.dir<-"./UCI HAR Dataset/test/"

# Shows information about the variables used on the feature vector
features.info<-read.csv("./UCI HAR Dataset/features_info.txt", sep=",", header = FALSE)
# List of all features
features.list<-read.csv("./UCI HAR Dataset/features.txt", sep=",", header = FALSE)
# Links the class labels with their activity name
activity.labels<-read.csv("./UCI HAR Dataset/activity_labels.txt", sep=",", header = FALSE)

# Training set
x.train<-read.csv("./UCI HAR Dataset/train/X_train.txt", sep=",", header = FALSE)
# Training labels
y.train<-read.csv("./UCI HAR Dataset/train/y_train.txt", sep=",", header = FALSE)

# Test set
x.test<-read.csv("./UCI HAR Dataset/test/X_test.txt", sep=",", header = FALSE)
# Test labels
y.test<-read.csv("./UCI HAR Dataset/test/y_test.txt", sep=",", header = FALSE)


distinct(y.test)  
distinct(y.train)  


                                                                                                                                            
list.files()
#file.remove("UCI HAR Dataset")




