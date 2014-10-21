#run_analysis R script, 
#a ReadMe markdown document, 
#a Codebook markdown document, 
#and a tidy data text file (this last goes on Coursera). 

## libraries to ensure are loaded
library(plyr)
library(dplyr)
library(reshape2)
library(sqldf)
library(splitstackshape)

# 
# Error in library(splitstackshape) : 
#         there is no package called 'splitstackshape'
# 
# install.packages("splitstackshape")
# 


getwd()
#start with a clean load of the data
if(file.exists("./UCI HAR Dataset")){unlink("./UCI HAR Dataset", recursive = TRUE)}

dataset_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 

## the files are binary files so require the mode = 'wb' parameter 
## to successfully unzip
if(!file.exists("Dataset.zip")){
        download.file(dataset_url, destfile="Dataset.zip", mode = 'wb')
}
##  area set up for static tables
names1<-c("num","activity")

unzip("Dataset.zip", overwrite= TRUE)
train.dir<-"./UCI HAR Dataset/train"
test.dir<-"./UCI HAR Dataset/test/"

# Shows information about the variables used on the feature vector
# Does not need to be loaded.  Here for reference to an earlier conversion.
##features.info<-read.csv("./UCI HAR Dataset/features_info.txt", header = FALSE)
# List of all features
features.list<-read.csv("./UCI HAR Dataset/features.txt", sep=" ", header = FALSE)

# Links the class labels with their activity name
activity.labels<-read.csv("./UCI HAR Dataset/activity_labels.txt", sep=" ", header = FALSE)
# Test labels
y.test<-read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", header = FALSE)
# Training labels
y.train<-read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", header = FALSE)

activity.test<-merge(y.test, activity.labels, by = "V1", all.x = TRUE)
activity.train<-merge(y.train, activity.labels, by = "V1", all.x = TRUE)
#free up memory, remove original files
rm(y.test)
rm(y.train)
rm(activity.labels)
names(activity.test)<-names1
names(activity.train)<-names1


## create key field for future join to feature data 
## by using a row number as the key. t1 & t2 are tossable 
t1<-data.frame(c(1:nrow(activity.test)))
t2<-data.frame(activity.test$activity)
activity.test<-cbind(t1,t2)

t1<-data.frame(c(1:nrow(activity.train)))
t2<-data.frame(activity.train$activity)
activity.train<-cbind(t1,t2)

# clear the temp variables
rm(t1); rm(t2); 

#put the names back into the tables
names(activity.test)<-names1
names(activity.train)<-names1



## Now to work on the datasets
## Pull the data in
# Test set
x.test<-read.csv("./UCI HAR Dataset/test/X_test.txt", sep="", header = FALSE)
# add the names
names(x.test)<-features.list$V2
x.test<-cbind("dataset"="Test",x.test)

## create the key field to join with activity table
#  key field will be the unique row count
t1<-data.frame(c(1:nrow(x.test)))
names(t1)<-"num"
data.test<-cbind(t1,x.test)
rm(x.test)

# Training set
x.train<-read.csv("./UCI HAR Dataset/train/X_train.txt", sep="", header = FALSE)
names(x.train)<-features.list$V2
x.train<-cbind("dataset"="Train",x.train)
t1<-data.frame(c(1:nrow(x.train)))
names(t1)<-"num"
data.train<-cbind(t1,x.train)
rm(x.train)

## merge the activities with the data
test.data <-merge(activity.test, data.test, by.x = "num", by.y = "num", all.y)
train.data <-merge(activity.train, data.train, by.x = "num", by.y = "num", all.y)

## clear memory
rm(data.test)
rm(data.train)

## get the full list of names to use before combining datasets
names2<-names(test.data)

#create the one dataset containing both test and training data
all.data<-rbind(test.data, train.data)

#write the tidy dataset with the combined tables.
write.table(all.data, file = "./one_dataset.csv", col.names = TRUE, sep = ",", row.names = FALSE)











distinct(y.test)  
distinct(y.train)  


                                                                                                                                            
list.files()
#file.remove("UCI HAR Dataset"
rm(features.info)



