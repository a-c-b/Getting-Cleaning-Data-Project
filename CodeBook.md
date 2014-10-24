# Code Book for Getting and Cleaning Data Project

####        by andrea345


### Purpose
        The purpose of this codebook is to explain the sources and the subsequent
        transformations of the dataset(s) used in the project for the course "Getting
        and Cleaning Data."

### Objectives
        The objectives were the following:
        
        The creation of one R script called run_analysis.R which does the following:
        
        1.Merges the training and the test sets to create one data set.  
        
        2.Extracts only the measurements on the mean and standard deviation for each
                measurement.  
        3.Uses descriptive activity names to name the activities in the data set.  
        
        4.Appropriately labels the data set with descriptive variable names.  
        
        5.From the data set in step 4, creates a second, independent tidy data set with
                the average of each variable for each activity and each subject.
        
        A full description of the raw datasets is available at the site where the data was obtained: 
        
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
        
        Here is the data for the project: 
        
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

        Attribution and information from their dataset is found at the bottom of this document.



###  Description of Work

        There are 3 phases to the code:
        
#### Phase 1 ###
          Set up libraries
          Set up temporary variables
          Delete possible old data.  Download data
          Unzip freshly downloaded data
          Begin transforming data sets until the Test and Training data sets
              can be combined to include descriptive activity names
              and descriptive feature names for the variable labels

#### Phase 2  ###

          Extracting only the measurements on the mean and standard deviation 
                for each measurement.
          
          This will create a second tidy dataset.  A subset of which will contain
                  only those variables out of the 564 variables in the all.data dataset
                  which have "mean" or "std" found in the header name for each of the
                  subjects at each of their Activities.
  

####  Phase 3 ###

           Calculates the means for those features which had "mean" or "std"
                in their descriptive name.
           
           Resorts the new dataset of this summary data so that it is reported
                in ascending order of Subject Number with their Activity in alphabetical
                order.
           
           Creates the final output file


###  Temporary tables

#### Phase 1  ###

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

###  Phase 2 ###
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
                
### Phase 3  ####

        SA - a list created from the distinct values of Subject + Activity.  This is to be
                        used for the aggregation function.
        
        result - table created from the aggregate function of the to.process table.  The
                        mean function is applied to all the columns grouped by the row grouping
                        of Subject + Activity.
        
        sorted - temporary table used to hold the sorted data of Subject then Activity
                        which is then used to create a sequence number.
                        
        finished.result - The aggregated table result is sorted for a numeric sort of
                        Subject number then Activity in alphabetical order.
                        
 
###  Additional Vectors added and assigned names created for the files.

        $rownum - field added to the various datasets to keep the datasets aligned                 
                during binding and merging process
        
        $SubjectActivity - a field created from the concatenation of the Subject number
                plus the Activity Label.  This is created so the summarization process
                can be shorted from two iterations to a single one.
                
        $ActivityNum - vector name assigned the first field of the activity_labels.csv
                data.This is the numeric representation of the Activity which is the
                dataset found in the y_test(or train).csv files.
                
        $Activity - is the vector name assigned to the 2nd field of the 
                activity_labels.csv data.  This is the name of the Activity.
        
        $Subject - is the vector name assigned the the vector of data in the
                subject_test(or train).csv data.
                
        All the vector names for the Features datasets (X_test.txt or X_train.txt)
                are found in the $V2 vector loaded from the features.txt file.
                
        
        
###  Output Files

        All output files will be written in .txt format with row.names = FALSE
        
        one_dataset.txt - will be written to the working directory.  This contains 
                10,299 observations 565 variables from the Test and Training datasets with
                descriptive headers for the columns and rows identifying subject and Activity.
                
        finished_result.txt - will be written to the working directory.  This contains
                180 observations of 80 variables which are the mean calculations for each of
                the Features which had either the phrase "mean" or "std" in them.  The means
                are calculated at each Activity level for each Subject.


###  Original documentation for the dataset and attribution

        
        Abstract: Human Activity Recognition database built from the recordings of 30
        subjects performing activities of daily living (ADL) while carrying a waist
        -mounted smartphone with embedded inertial sensors.
          
        
        Source:
        
        Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
        Smartlab - Non Linear Complex Systems Laboratory 
        DITEN - Universit√  degli Studi di Genova, Genoa I-16145, Italy. 
        activityrecognition '@' smartlab.ws 
        www.smartlab.ws 


        Data Set Information:
        
        The experiments have been carried out with a group of 30 volunteers within an
        age bracket of 19-48 years. Each person performed six activities (WALKING,
        WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a
        smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer
        and gyroscope, we captured 3-axial linear acceleration and 3-axial angular
        velocity at a constant rate of 50Hz. The experiments have been video-recorded
        to label the data manually. The obtained dataset has been randomly partitioned
        into two sets, where 70% of the volunteers was selected for generating the
        training data and 30% the test data. 
        
        The sensor signals (accelerometer and gyroscope) were pre-processed by applying
        noise filters and then sampled in fixed-width sliding windows of 2.56 sec and
        50% overlap (128 readings/window). The sensor acceleration signal, which has
        gravitational and body motion components, was separated using a Butterworth
        low-pass filter into body acceleration and gravity. The gravitational force
        is assumed to have only low frequency components, therefore a filter with
        0.3 Hz cutoff frequency was used. From each window, a vector of features
        was obtained by calculating variables from the time and frequency domain. 
        
        Check the README.txt file for further details about this dataset. 


        Attribute Information:
        
        For each record in the dataset it is provided: 
        - Triaxial acceleration from the accelerometer (total acceleration) and
        the estimated body acceleration. 
        - Triaxial Angular velocity from the gyroscope. 
        - A 561-feature vector with time and frequency domain variables. 
        - Its activity label. 
        - An identifier of the subject who carried out the experiment. 
        
        
        Relevant Papers:
        
        N/A
        
        
        Citation Request:
        
        [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes
        -Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware
        -Friendly Support Vector Machine. International Workshop of Ambient Assisted
        Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
        
