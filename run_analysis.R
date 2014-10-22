
##############  PHASE 1 ######################################
##  
##  Set up libraries
##  Set up temporary variables
##  Delete possible old data.  Download data
##  Unzip freshly downloaded data
##  Begin transforming data sets until the Test and Training data sets
##      can be combined to include descriptive activity names
##      and descriptive feature names for the variable labels
##
##################################################

## libraries to ensure are loaded
        library(plyr)
        library(dplyr)



#start with a clean load of the data.  Delete old directories and files
        if(file.exists("./UCI HAR Dataset")){unlink("./UCI HAR Dataset", 
                                                        recursive = TRUE)}
        dataset_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 

########## Loading ##########
###
##  Begin unzipping, loading and tidying the various datasets
###

## the files are binary files so require the mode = 'wb' parameter 
## to successfully unzip
        if(!file.exists("Dataset.zip")){
        download.file(dataset_url, destfile="Dataset.zip", mode = 'wb')}

#unzip the dataset
        unzip("Dataset.zip", overwrite= TRUE)


#List of all features
        features.list<-read.csv("./UCI HAR Dataset/features.txt", sep=" ", header = FALSE)
# Links the numeric labels of the activity with their activity name
        activity.labels<-read.csv("./UCI HAR Dataset/activity_labels.txt", sep=" ", header = FALSE)

# Load the files of Test labels, subjects, and data
        y.test<-read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", header = FALSE)
        subject.test<-read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="", header = FALSE)
        x.test<-read.csv("./UCI HAR Dataset/test/X_test.txt", sep="", header = FALSE)
# Load the files of Training labels, subjects and data
        y.train<-read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", header = FALSE)
        subject.train<-read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="", header = FALSE)
        x.train<-read.csv("./UCI HAR Dataset/train/X_train.txt", sep="", header = FALSE)

####  Begin processing the files #############
#
#    Combining tables of information to add descriptors
#    to the dataset, including readable headers
#    the association to a subject and the activity label
#
#########

# Merge the Activity Number with an Activity Label
        activity.test<-merge(y.test, activity.labels, by = "V1", all.x = TRUE)
        activity.train<-merge(y.train, activity.labels, by = "V1", all.x = TRUE)


## assign names to the table
        names(activity.test)<-c("num","activity")
        names(activity.train)<-c("num","activity")

###### Combining Test data to make full Test dataset ###########

## create key field for future join to feature data 
## by using a row number as the key. t1 & t2 are temporary variables
   
        t1<-data.frame(c(1:nrow(activity.test)))
        t2<-data.frame(activity.test$activity)
        activity.test<-cbind(t1,t2)
        names(activity.test)<-c("num","activity")


        t1<-data.frame(c(1:nrow(subject.test)))
        t2<-data.frame(subject.test$V1)
        subject.test<-cbind(t1,t2)
        names(subject.test)<-c("num","subject")


# add the names to the raw data dataset
        names(x.test)<-features.list$V2


##  create the cleaned test data set by combining
#  the subject information with the activity to the dataset

        test.data<-cbind("subject" = subject.test$subject,"activity" = activity.test$activity,x.test)
      


################  TRAINING datasets ########

        t1<-data.frame(c(1:nrow(activity.train)))
        t2<-data.frame(activity.train$activity)
        activity.train<-cbind(t1,t2)
        names(activity.train)<-c("num","activity")


        t1<-data.frame(c(1:nrow(subject.train)))
        t2<-data.frame(subject.train$V1)
        subject.train<-cbind(t1,t2)
        names(subject.train)<-c("num","subject")



# Begin cleaning and prettyfying the Training set

        names(x.train)<-features.list$V2
## merge the activities with the data for each of the datasets
        train.data<-cbind("subject" = subject.train$subject,"activity" = activity.train$activity,x.train)
      


####  create the unified dataset############


#create the one dataset containing both test and training data
        all.data<-rbind(test.data, train.data)

#write the tidy dataset with the combined tables.
        write.table(all.data, file = "./one_dataset.csv", col.names = TRUE, sep = ",", row.names = FALSE)

## clear memory for next phase of work 
        
        rm(activity.test)
        rm(activity.train)
        rm(test.data)
        rm(train.data)
        rm(features.list)
        rm(activity.labels)
        rm(subject.test)
        rm(subject.train)
        rm(t1);rm(t2)
        rm(x.test); rm(y.test)
        rm(x.train); rm(y.train)
        
        
        
######################PHASE 2###################### 
##        
##  PHASE 2
##
##  Extracting only the measurements on the mean and standard deviation 
##  for each measurement.
##
##
##  This will create a second tidy dataset.  A subset of which will contain
##  only those variables out of the 564 variables in the all.data dataset
##  which have "mean" or "std" found in the header name.
##
#############################################

# Get all the names of all the headers for the entire dataset
        names1<-names(all.data)

##  preserve the first 3 columns of information
        first2.col<-subset(all.data, select = c(subject:activity))

##  get the columns with the phrase "mean", then "std" in them
        all.mean<-subset(all.data, select = names1 %in% grep("mean", names1, value=TRUE))
        all.std<-subset(all.data, select = names1 %in% grep("std", names1, value=TRUE))

## merge the three datasets back into one with all the names and key fields
## and keep the two datasets for mean and standard deviation separated for 
## more simple processing
        all.to.process <-cbind(first2.col, all.mean, all.std)
        all.mean<-cbind(first2.col, all.mean)      
        all.std<-cbind(first2.col, all.std) 

##  clear memory
        rm(first2.col)

######### Phase 3 ##########
##
##   Calculate the Averages for the combined datasets
##
##


