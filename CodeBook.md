# Getting and Cleaning Data - Project

Beau Gamble

June 14, 2017

## Overview

This codebook describes the variables, data and any transformations or work that were performed to clean up the data, from the Week 4 Project of the Coursera Course "Getting and Cleaning Data".

A complete description of the data used in this project is available at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The source data can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Identifiers

* `subject_ID` - The participant identifier number
* `activity` - The type of activity performed whilst measurements were recorded

## Activity Labels

* `WALKING`: value `1`
* `WALKING_UPSTAIRS`: value `2`
* `WALKING_DOWNSTAIRS`: value `3`
* `SITTING`: value `4`
* `STANDING`: value `5`
* `LAYING`: value `6`

## Feature selection

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The two variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

## Steps for data cleaning and analysis

### Step 1. Merge the training and the test sets to create one data set.
After setting the source directory for the files, training and test data were combined.

### Step 2. Extract only the measurements on the mean and standard deviation for each measurement. 
Only the columns containing "mean" or "std" were extracted.

### Step 3. Use descriptive activity names to name the activities in the data set
Activity names were loaded in from the `activity_labels.txt` file.

### Step 4. Appropriately label the data set with descriptive activity names.
`gsub()` function was used to replace column names with more descriptive titles.

### Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
`ddply()` function was used to calculate means for each variable (for each activity and subject). 
These means were written to a final tidy data set named `meansTidyData.txt`.
