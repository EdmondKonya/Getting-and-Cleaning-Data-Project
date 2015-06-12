Getting and Cleaning Data: Course Project
=========================================

Introduction
------------
This repo contains the course project for the Coursera course "Getting and Cleaning data", which is part of the 
Data Science specialization.

Shrot description of the raw data
---------------------------------
The following files are available for the train and test data.

The values of the 561 features can be found in: "UCI HAR Dataset/train/X_train.txt" 
The activity labels are in: "UCI HAR Dataset/train/Y_train.txt"
The test subjects (range of 30) are defined in: "UCI HAR Dataset/train/subject_train.txt"

Description of running the script run_analysis.R and the resulting tidy dataset
-------------------------------------------------------------------------------
Prerequisites for this script are:

1. Internet connection available; In this case the script is downloading the file und unzipping it automatically under following path:
./project_data
2. Internet connection not available; In this case the script is informing the user via message, to save the unzipped data-set
(=UCI HAR Dataset) under following path ./project_data

After the unzipped data-set is available in ./project_data, the script loads the raw data into R and merges the 
test- and training-sets using rbind.

Thereafter the lables for the corresponding features are added from; "UCI HAR Dataset/features.txt" as columns to the merged
data-set (hereafter total-dataset)

Lastly, the script will create a tidy data set containing the means of all the columns, grouped by subject and activity.
This tidy dataset will be written to a tab-delimited file called tidy_data.txt, which can also be found in this repo.

About the Code Book
-------------------
The CodeBook.md file explains the transformations performed and the resulting data and variables.
