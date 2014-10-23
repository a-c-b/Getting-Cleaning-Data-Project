
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
        ##library(plyr)
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
                names(activity.labels)<-c("ActivityNum","Activity")

# Load the files of Test labels, subjects, and data.  Name the columns.
        y.test<-read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", header = FALSE)
                names(y.test)<-"ActivityNum"
        subject.test<-read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="", header = FALSE)
                names(subject.test)<-c("Subject")
        x.test<-read.csv("./UCI HAR Dataset/test/X_test.txt", sep="", header = FALSE)
                names(x.test)<-features.list$V2


####  Begin processing the files #############
#
#    Combining tables of information to add descriptors
#    to the dataset, including readable headers
#    the association to a subject and the activity label
#
#########

## create a unique row number to merge files together
        y.test$rownum<-c(1:nrow(y.test))
        subject.test$rownum<-c(1:nrow(subject.test))
        x.test$rownum<-c(1:nrow(x.test))

# Merge the Activity Number with an Activity Label
        activity.test<-merge(y.test, activity.labels, by = "ActivityNum", all.x = TRUE)

##  create the cleaned test data set by combining
#  the subject information with the activity to the dataset

        test.data<-merge(activity.test, x.test, by = "rownum", all.x = TRUE, all.y=TRUE)
        test.data<-merge(subject.test, test.data, by="rownum", all.x = TRUE, all.y = TRUE)

##########  Training data
##
##    duplicated from test
##
##########
# Load the files of train labels, subjects, and data.  Name the columns.
        y.train<-read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", header = FALSE)
                names(y.train)<-"ActivityNum"
        subject.train<-read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="", header = FALSE)
                names(subject.train)<-c("Subject")
        x.train<-read.csv("./UCI HAR Dataset/train/X_train.txt", sep="", header = FALSE)
                names(x.train)<-features.list$V2


####  Begin processing the files #############
#
#    Combining tables of information to add descriptors
#    to the dataset, including readable headers
#    the association to a subject and the activity label
#
#########

## create a unique row number to merge files together
        y.train$rownum<-c(1:nrow(y.train))
        subject.train$rownum<-c(1:nrow(subject.train))
        x.train$rownum<-c(1:nrow(x.train))

# Merge the Activity Number with an Activity Label
        activity.train<-merge(y.train, activity.labels, by = "ActivityNum", all.x = TRUE)

##  create the cleaned train data set by combining
#  the subject information with the activity to the dataset

        train.data<-merge(activity.train, x.train, by = "rownum", all.x = TRUE, all.y=TRUE)
        train.data<-merge(subject.train, train.data, by="rownum", all.x = TRUE, all.y = TRUE)

###################################################
###
####  Create the Unified Dataset     ############
###
################################################

#create the one dataset containing both test and training data
        all.data<-rbind(test.data, train.data)
        all.data$rownum<-c(1:nrow(all.data))

#write the tidy dataset with the combined tables.
        write.table(all.data, file = "./one_dataset.txt", col.names = TRUE, sep = ",", row.names = FALSE)

## clear memory for next phase of work 
        
        rm(activity.test)
        rm(activity.train)
        rm(test.data)
        rm(train.data)
        rm(features.list)
        rm(activity.labels)
        rm(subject.test)
        rm(subject.train)
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
        simple.id<-subset(all.data, select = c(rownum,Subject, Activity))
        simple.id$SubjectActivity<-paste(simple.id$Subject,simple.id$Activity)
        simple<-subset(simple.id, select=c(rownum, SubjectActivity))

##  get the columns with the phrase "mean", then "std" in them
        all.mean<-subset(all.data, select = names1 %in% grep("mean", names1, value=TRUE))
        all.mean$rownum<-c(1:nrow(all.mean))

        all.std<-subset(all.data, select = names1 %in% grep("std", names1, value=TRUE))
        all.std$rownum<-c(1:nrow(all.std))


## merge the three datasets back into one with all the names and key fields
## and keep the two datasets for mean and standard deviation separated for 
## more simple processing
        to.process <-merge(all.mean, all.std, by="rownum", all.x = TRUE, all.y=TRUE)
        to.process<-merge(simple,to.process,by="rownum", all.x = TRUE, all.y=TRUE )
        to.process<-subset(to.process, select = -rownum)
        names1<-names(to.process)
        

######### Phase 3 ##########
##
##   Calculate the Averages for the combined datasets
##
##
#####################################

##   create a list to use with the aggregate function
        SA<-list(to.process$SubjectActivity)
      
##  create the dataset which stores the result of the mean value
##  for all features which contained either the phrase "mean" or "std"
##  for all the subjects in each of their activities


        result<-aggregate(to.process, by = SA, FUN = mean, na.rm=TRUE)

##  get rid of the column which could not be calculated
        result<-subset(result, select = -SubjectActivity)
        names(result)<-names1

##  create a table to develop a sort order by reusing
##  the Subject and Activity tables which were unique by row number

       
       # library(dplyr)
        sorted<-distinct(subset(simple.id,select = c(Subject, Activity, SubjectActivity)))
        attach(sorted)
        sorted<-sorted[order(Subject,Activity),]
        sorted$rownum<-c(1:nrow(sorted))
        sorted<-subset(sorted, select=c(SubjectActivity, rownum))
        
 
# merge the sort order with the result table
        finished.result<-merge(result,sorted,by="SubjectActivity", all.x = TRUE, all.y=TRUE )
         attach(finished.result)
        finished.result<-finished.result[order(rownum),]
        finished.result<-subset(finished.result, select = -rownum)
        write.table(finished.result, file = "./finished_result.txt", col.names = TRUE, sep = ",", row.names = FALSE)       
                
####  End ####


        
        



