# Code Book for Getting and Cleaning Data Project


### by andrea345


## Purpose
        The purpose of this codebook is to explain the sources and the subsequent
        transformations of the dataset(s) used in the project for the course "Getting
        and Cleaning Data."

## Objectives
        The objectives were the following:
        
        The creation of one R script called run_analysis.R which does the following:
        
        1.Merges the training and the test sets to create one data set.  
        
        2.Extracts only the measurements on the mean and standard deviation for each
                measurement.  
        3.Uses descriptive activity names to name the activities in the data set.  
        
        4.Appropriately labels the data set with descriptive variable names.  
        
        5.From the data set in step 4, creates a second, independent tidy data set with
                the average of each variable for each activity and each subject.
        
        A full description is available at the site where the data was obtained: 
        
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
        
        Here is the data for the project: 
        
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##  Description of Work

        There are 3 phases to the code:
        
### Phase 1 ###
          Set up libraries
          Set up temporary variables
          Delete possible old data.  Download data
          Unzip freshly downloaded data
          Begin transforming data sets until the Test and Training data sets
              can be combined to include descriptive activity names
              and descriptive feature names for the variable labels

### Phase 2  ###

          Extracting only the measurements on the mean and standard deviation 
                for each measurement.
          
          This will create a second tidy dataset.  A subset of which will contain
                  only those variables out of the 564 variables in the all.data dataset
                  which have "mean" or "std" found in the header name for each of the
                  subjects at each of their Activities.
  

###  Phase 3 ###

           Calculates the means for those features which had "mean" or "std"
                in their descriptive name.
           
           Resorts the new dataset of this summary data so that it is reported
                in ascending order of Subject Number with their Activity in alphabetical
                order.
           
           Creates the final output file



##  Temporary tables

### Phase 1  ###

        dataset_url holds the URL of the data to be downloaded
        
        features.list - takes the data from the features.txt file.  These are the
                headers for the data itself.  
                
        activity.labels - takes the data from the activity_labels.txt file
        
        y.test - takes Activity Number  from the Test dataset
        x.test - takes the data set from the Test dataset
        subject.test - takes the subject number from the Test dataset
        
        y.train - takes Activity Number  from the train dataset
        x.train - takes the data set from the train dataset
        subject.train - takes the subject number from the train dataset
        
        names for train and test.data come from the features.list$V2    
        
        activity.test - is created from merging the Activity Number with the Activity
                Label on the activity.num field
                        
        test.data - is created from merging activity and subject data with the test data
                on a rownum field for the TEST dataset
                        
        activity.train - is created from merging the Activity Number with the Activity
                Label on the activity.num field
                        
        train.data - is created from merging activity and subject data with the train
                data on a rownum field for the train dataset
                        
        all.data - is created by binding the rows from test.data and train.data 

##  Phase 2 ###
simple.id - a table created from a subset of all.data for the columns rownum,Subject,
                & Activity.  This is to be used to create a new sort order of the
                final results by Subject and Activity for the selected columns of
                information

simple - table created from simple.id after a concatenation of Subject & Activity
                is made.  This is tied to a unique rownum(ber) of the data.
                
all.mean - a table created from a subset of all.data for the columns with the phrase
                "mean" in the Feature name.

all.std - a table created from a subset of all.data for the columns with the phrase
                "std" in the Feature name.    

to.process - table created from merging the columns from all.mean and all.std by rownum
                and then simple is added back in to return the subject, activity,
                and the concatenated SubjectActivity
                
## Phase 3  ####

SA - a list created from the distinct values of Subject + Activity.  This is to be
                used for the aggregation function.

result - table created from the aggregate function of the to.process table.  The
                mean function is applied to all the columns grouped by the row grouping
                of Subject + Activity.

sorted - temporary table used to hold the sorted data of Subject then Activity
                which is then used to create a sequence number.
                
finished.result - The aggregated table result is sorted for a numeric sort of
                Subject number then Activity in alphabetical order.
                
 
##  Additional Vectors added
$rownum - field added to the various datasets to keep the datasets aligned during
        binding and merging process


##Output Files
one_dataset.csv - will be written to the working directory.  This contains 
        10,299 observations 565 variables from the Test and Training datasets with
        descriptive headers for the columns and rows identifying subject and Activity.
        
finished_result.csv - will be written to the working directory.  This contains
        180 observations of 80 variables which are the mean calculations for each of
        the Features which had either the phrase "mean" or "std" in them.  The means
        are calculated at each Activity level for each Subject.

