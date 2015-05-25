#Getting-Cleaning-Data-Project
=============================

###  This is the project for the coursera course Getting and Cleaning Data.
        
###  Uploaded for this project, or available, are the following documents and files:

#### In this Repo
        
        1) run_analysis.R script
        2) a Read Me markdown document
        3) a Code book markdown document
        
#### On coursera

        4) an upload the final tidy data text file of the summarized results

#### On demand

        5) a .txt file of all the Feature observations with all the data assigned
                to each Subject for each Activity
 
 
###      Phase 1: 
####     Load the files.   Clean, name and merge all the datasets.  

        The script run_analysis.R begins with deleting any previous data sets in
        your working directory which would be equal to what the unzipped directory
        structure of the down load data would be.
        
        It then downloads the data from the source.  This data is a binary file,
        so the download takes that into account, otherwise the unzip would not work.

####  Steps:  

        Load the data into temporary tables.  Make table names as close to file name 
        as possible.
        
        Combine tables of information to add descriptors to the dataset, including
        readable headers and the the association to a subject and the activity label.
        
        Create a unique row number to merge files together and keep the association
        of the data position through various binds, sorts, or merges.
        
        Merge the Activity Number with an Activity Label.  This assigns an Activity word
        to the dataset.  
        
        Create the cleaned test data set by combining the subject information with the
        activity label to the dataset.
                
        The activity on the Training dataset will be duplicated per the steps above.
        
        Merge the cleaned, labeled, activity & subject identified Test & Training
        data tables together for a combined dataset.
        
        An output text file is created for this combined dataset.
        
        All the temporary tables, except for the single combined table, are cleared
        from memory.
        
### Phase 2
####  Extracting only the measurements on the mean and standard deviation 
####  for each measurement.

        
        This will create a second tidy dataset.  A subset of which will contain
        only those variables out of the 564 variables in the all.data dataset
        which have "mean" or "std" found in the header name.

####  Steps:
        
     Get all the names of all the headers for the entire dataset so that they
     can be returned after processing.  Put them into a temporary variable.
     
     Preserve the first three columns of information.  This is the identifying
     information of the dataset regarding the data vector "rownum" (i.e., position
     within the dataset), the Subject, and the word value of the Activity the Subject
     was doing.
     
     Create temporary tables which consist of the columns of information which have 
     headers with the phrases "mean" or "std" in them.  These are the columns with
     Mean or Standard Deviations applied to the Features.
     
     Create a new dataset of subsetted columns of information relating only to those
     vectors which have "mean" or "std" calculations applied to the Features.  Merge 
     these columns back with the Subject and Activity vectors.  This second tidy dataset
     is ready to process for the summation exercise in Phase 3.
     
     
     
### Phase 3
####  Calculate the Averages for the combined datasets

        Create the dataset which stores the result of the mean value
        for all features which contained either the phrase "mean" or "std"
        for all the subjects for each of their activities.
        
####  Steps:   

        Create a list from the concatenation of the Subject number +
        the Activity Label.  This variable will simplify the steps of
        aggregation as the unique value by which all the data will 
        be averaged.
        
        Summarize the dataset by the value of Subject+Activity using the
        mean function.  This creates an error on the column vectory by which
        we were summarizing the data (SubjectActivity).  Remove this column
        from the dataset.
        
        "Put" the names back onto the dataset to include the Subject and their
        Activity.
        
        Create a sort key using the numeric value of the Subject and the Alpha-numeric
        value of Activity.  Apply this sort key to the new dataset and sort it
        so that the subjects will be numbered 1-30 in numerical, not character order
        with the Activity being the tie breaker.
        
        Create a .txt output file of the cleaned dataset and upload that to coursera.
        
        
        
        
        
     
     
     
     
     
        
                        
