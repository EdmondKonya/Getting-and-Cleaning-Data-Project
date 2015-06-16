#Check if the working directory already contains a subdirectory called project_data with the data-set.
if(!file.exists("./project_data")){  
  
  #In case there is no directory, the file is downloaded and unzipped, 
  #whereas the original zip-file is being deleted.
  fileURl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURl, destfile = "./project_data.zip")
  unzip(zipfile = "./project_data.zip", exdir = "./project_data")
  unlink("./project_data.zip")
  setwd("./project_data")
  
  #In case there is already a sub-directory, which contians a file, the working directory is set to
  #./project_data.
} else { 
  
  message("The file has already been downloaded! Please make sure, that the unziped data 
          is stored in ./project_data")
  setwd("./project_data")
}

#Obtain training-data, including lables and user-ID
trainsample <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
trainsample[,562] <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep = "", header = FALSE)
trainsample[,563] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)

#Obtain test-data, including lables and user-ID
testsample <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
testsample[,562] <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep = "", header = FALSE)
testsample[,563] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)

#Merge training- and test-sample to 1 total dataset
totaldata <- rbind(testsample, trainsample)

#Obtain activity-lables, describing the type of movement
activitylables <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)

#Obtain feature/varaible-names and fromat them in a more readable way
features <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE)
features[, 2] <- gsub("[()]", "", features[, 2])
features[, 2] <- gsub("[-]", "_", features[, 2])

#Transpose feature/varaible-names and use them as column-names for the total dataset
colnames_all <- t(features)
colnames(totaldata) <- c(colnames_all[2,],"activity","subject")
colnames(totaldata) <- tolower(colnames(totaldata))

#Select only relevant colomns, containing "mean" and "std"
relevant_col <- grep("*mean*|*std*|activity|subject", colnames(totaldata))
totaldata <- totaldata[, relevant_col]

#Loop throught activitylable and replace number of activity with corresponding label
activitynr <- 1
for (activitynr in 1:nrow(activitylables)) {
  
  totaldata$activity <- gsub(activitynr, activitylables[activitynr, "V2"], totaldata$activity)
  activitynr <- activitynr + 1 
  
}

#Calculating the mean, grouped by "activity" and "subject" and cleaning the resulting data set
tidy_data <- aggregate(totaldata, by=list(totaldata$activity, totaldata$subject), mean)
tidy_data$activity <- NULL
tidy_data$subject <- NULL

#Printing out a.txt file
write.table(tidy_data, file = "tidy_data.txt", sep = " ", row.name=FALSE)


