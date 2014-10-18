#run_analysis R script, 
#a ReadMe markdown document, 
#a Codebook markdown document, 
#and a tidy data text file (this last goes on Coursera). 


if(!file.exists("./UCI HAR Dataset")){dir.create("./UCI HAR Dataset")}

dataset_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 

## the files are binary files so require the mode = 'wb' parameter 
## to successfully unzip
if(!file.exists("Dataset.zip")){
        download.file(dataset_url, destfile="Dataset.zip", mode = 'wb')
}

if(!file.exists("UCI HAR Dataset")){
        unzip("Dataset.zip", overwrite= TRUE)
}

list.files()
file.remove("UCI HAR Dataset")


