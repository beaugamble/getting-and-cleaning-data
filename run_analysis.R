##############################################################################

## Getting and Cleaning Data - Project
## Beau Gamble
## June 14th, 2017

# This script will perform the following steps on the UCI HAR Dataset:

# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

##############################################################################

# Clean workspace
rm(list=ls())

# Set working directory to where dataset was unzipped
setwd("C:/Users/bgam941/Dropbox/Coursera/Getting and cleaning data/project/UCI HAR Dataset")

# Load required packages

library(reshape2)
library(plyr)

##############################################################################

# 1. Merge the training and the test sets to create one data set.

# First, load in all the training and test data sets
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Then, create combined data sets for the x data, y data, and subject data sets
x_combined_data <- rbind(x_train, x_test)
y_combined_data <- rbind(y_train, y_test)
subject_combined_data <- rbind(subject_train, subject_test)

##############################################################################

# 2. Extract only the measurements on the mean and standard deviation for each measurement.

# First, read in the features.txt file (it contains all the variable names)
features <- read.table("features.txt")

# Turn all those feature names into characters
features[,2] <- as.character(features[,2])

# Then, extract only the features with mean() or std() in their names
# This gives the element numbers of features[,2] that contain mean or std
mean_and_std_features <- grep(".*mean.*|.*std.*", features[,2]) 

# Then, subset the desired columns of x_data using those extracted column names
x_combined_data <- x_combined_data[, mean_and_std_features]

# Then, correct the column names
# This gives all those extracted columns their actual character names from the features list)
names(x_combined_data) <- features[mean_and_std_features, 2]

##############################################################################

# 3. Use descriptive activity names to name the activities in the data set

# Load in the activity names
activity_labels <- read.table("activity_labels.txt")

# Correct the numerical values in y_combined_data with the activity names
y_combined_data[, 1] <- activity_labels[y_combined_data[, 1], 2]

# Correct the column name in y_combined_data
names(y_combined_data) <- "activity"

# While I'm at it, I'll correct the column name in subject_combined_data
names(subject_combined_data) <- "subject_ID"

##############################################################################

# 4. Appropriately label the data set with descriptive variable names.

# First, I want to bind all the data (x, y, and subject) in a single data set
all_data <- cbind(x_combined_data, y_combined_data, subject_combined_data)

# Next, create a column vector of all_data, so the columns are easier to rename
colNames  = colnames(all_data); 

# Then, rename the columns to something more descriptive
# Information about these variables was obtained from the `features_info.txt` file
for (i in 1:length(colNames)) 
{
      colNames[i] = gsub("\\()","",colNames[i]) # remove all parentheses
      colNames[i] = gsub("-std","StdDev",colNames[i])
      colNames[i] = gsub("-mean","Mean",colNames[i])
      colNames[i] = gsub("^(f)","freq",colNames[i])
      colNames[i] = gsub("^(t)","time",colNames[i])
      colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
      colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
      colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
      colNames[i] = gsub("[Mm]ag","Magnitude",colNames[i])
      colNames[i] = gsub("[Jj]erk","Jerk",colNames[i])
};

# Then reassign those new column names to the merged data set
colnames(all_data) = colNames

##############################################################################

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

# Use the ddply function to create a data frame with the means of each variable, first per subject, then per activity
# Remember, I want to exclude the last two columns (67 and 68); these are the activity and subject_ID
means_data <- ddply(all_data, .(subject_ID, activity), function(x) colMeans(x[, 1:66]))

# Export the final tidy data set 
write.table(means_data, "meansTidyData.txt", row.name=FALSE)

##############################################################################


