# Tidy Version of Human Activity Recognition Using Smartphones Dataset

## Data

This analysis is run on the Human Activity Recognition Using
Smartphones Dataset.  The original version can be found at
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
I downloaded this as a `zip` file from
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
I downloaded this file on June 19, 2015 at 7:32am Eastern.  You can
find the downloaded version at `dataset` in this directory.


## Study Design

The code used to convert the data into a tidy data format can be found
in `run_analysis.R`, but here is an overview of what happens there:

1. I assembled the training data by combining the data (`X_train.txt`), user ids (`subject_train.txt`), and activity ids (`y_train.txt`) into a data frame.
2. I did the same thing for the test data.
3. I combined the training and test data into one long table (adding the one to the bottom of the other).
4. I used a regex to find the column indices and names for all columns that calculated mean or standard deviation.
5. In the process of doing that, I used the R function `make.names` to create legal, descriptive names for the relevant columns.
6. I then used that list to subset the raw data into just the mean/standard deviation columns.
7. I used the column names from step 4/5 (the clean ones) to label the columns in my subsetted data.
8. Since the rows hadn't changed, I was able to add the userId/activityNames from the raw data back into the subsetted data. This left me with a table where each row has all the mean/standard deviation columns *plus* activity and user identifying information.
9. I used a combination of `melt`, `dcast`, and `arrange` to reshape the data:

  * I `melt`ed the data into tuples of userId, activityName, variable, and value.  This yielded many short rows for each of the longer rows in the existing data.
  * I `dcast` the data back into a wide table where each userId/activityName gets one row and the value for each column is the average of all the values for that variable/userId/activityName group in the `melt`ed data.
  * I `arrange`d the data to order by userId and then activityName.

The tidy data we are left with has one row for every user/activity pair, and a column for the average of each of the mean/standard deviation measures for that user/activity pair.

### Project Objectives

This part of the assignment has five requirements.  Here they are
along with a pointer to where I completed them in the above steps.

1. Merges the training and the test sets to create one data set.
  * Steps 1 - 3
2. Extracts only the measurements on the mean and standard deviation for each measurement.
  * Step 4
3. Uses descriptive activity names to name the activities in the data set.
  * Step 8
4. Appropriately labels the data set with descriptive variable names.
  * Steps 4 - 5
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  * Steps 6 - 7 and 9

## Code Book

* userId: the number used to identify the subject across all datasets
* activityName: the name of the activity the measurements are for (e.g., 'WALKING')
* tBodyAcc.mean...X: Mean of body linear acceleration along X axis.
* tBodyAcc.mean...Y: Mean of body linear acceleration along Y axis.
* tBodyAcc.mean...Z: Mean of body linear acceleration along Z axis.
* tBodyAcc.std...X: Standard deviation of body linear acceleration along X axis.
* tBodyAcc.std...Y: Standard deviation of body linear acceleration along Y axis.
* tBodyAcc.std...Z: Standard deviation of body linear acceleration along Z axis.
* tGravityAcc.mean...X: Mean of gravity linear acceleration along X axis.
* tGravityAcc.mean...Y: Mean of gravity linear acceleration along Y axis.
* tGravityAcc.mean...Z: Mean of gravity linear acceleration along Z axis.
* tGravityAcc.std...X: Standard deviation of gravity linear acceleration along X axis.
* tGravityAcc.std...Y: Standard deviation of gravity linear acceleration along Y axis.
* tGravityAcc.std...Z: Standard deviation of gravity linear acceleration along Z axis.
* tBodyAccJerk.mean...X: Mean of body linear acceleration jerk along X axis.
* tBodyAccJerk.mean...Y: Mean of body linear acceleration jerk along Y axis.
* tBodyAccJerk.mean...Z: Mean of body linear acceleration jerk along Z axis.
* tBodyAccJerk.std...X: Standard deviation of body linear acceleration jerk along X axis.
* tBodyAccJerk.std...Y: Standard deviation of body linear acceleration jerk along Y axis.
* tBodyAccJerk.std...Z: Standard deviation of body linear acceleration jerk along Z axis.
* tBodyGyro.mean...X: Mean of body angular velocity along X axis.
* tBodyGyro.mean...Y: Mean of body angular velocity along Y axis.
* tBodyGyro.mean...Z: Mean of body angular velocity along Z axis.
* tBodyGyro.std...X: Standard deviation of body angular velocity along X axis.
* tBodyGyro.std...Y: Standard deviation of body angular velocity along Y axis.
* tBodyGyro.std...Z: Standard deviation of body angular velocity along Z axis.
* tBodyGyroJerk.mean...X: Mean of body angular velocity jerk along X axis.
* tBodyGyroJerk.mean...Y: Mean of body angular velocity jerk along Y axis.
* tBodyGyroJerk.mean...Z: Mean of body angular velocity jerk along Z axis.
* tBodyGyroJerk.std...X: Standard deviation of body angular velocity jerk along X axis.
* tBodyGyroJerk.std...Y: Standard deviation of body angular velocity jerk along Y axis.
* tBodyGyroJerk.std...Z: Standard deviation of body angular velocity jerk along Z axis.
* tBodyAccMag.mean..: Mean of the magnitude (using Euclidean norm) of body linear acceleration.
* tBodyAccMag.std..: Standard deviation of the magnitude (using Euclidean norm) of body linear acceleration.
* tGravityAccMag.mean..: Mean of the magnitude (using Euclidean norm) of gravity linear acceleration.
* tGravityAccMag.std..: Standard deviation of the magnitude (using Euclidean norm) of gravity linear acceleration.
* tBodyAccJerkMag.mean..: Mean of the magnitude (using Euclidean norm) of gravity linear acceleration jerk.
* tBodyAccJerkMag.std..: Standard deviation of the magnitude (using Euclidean norm) of gravity linear acceleration jerk.
* tBodyGyroMag.mean..: Mean of the magnitude (using Euclidean norm) of body angular velocity.
* tBodyGyroMag.std..: Standard deviation of the magnitude (using Euclidean norm) of body angular velocity.
* tBodyGyroJerkMag.mean..: Mean of the magnitude (using Euclidean norm) of body angular velocity jerk.
* tBodyGyroJerkMag.std..: Standard deviation of the magnitude (using Euclidean norm) of body angular velocity jerk.
* fBodyAcc.mean...X: Fast Fourier Transform of mean of body linear acceleration along X axis.
* fBodyAcc.mean...Y: Fast Fourier Transform of mean of body linear acceleration along Y axis.
* fBodyAcc.mean...Z: Fast Fourier Transform of mean of body linear acceleration along Z axis.
* fBodyAcc.std...X: Fast Fourier Transform of standard deviation of body linear acceleration along X axis.
* fBodyAcc.std...Y: Fast Fourier Transform of standard deviation of body linear acceleration along Y axis.
* fBodyAcc.std...Z: Fast Fourier Transform of standard deviation of body linear acceleration along Z axis.
* fBodyAccJerk.mean...X: Fast Fourier Transform of mean of body linear acceleration jerk along X axis.
* fBodyAccJerk.mean...Y: Fast Fourier Transform of mean of body linear acceleration jerk along Y axis.
* fBodyAccJerk.mean...Z: Fast Fourier Transform of mean of body linear acceleration jerk along Z axis.
* fBodyAccJerk.std...X: Fast Fourier Transform of standard deviation of body linear acceleration jerk along X axis.
* fBodyAccJerk.std...Y: Fast Fourier Transform of standard deviation of body linear acceleration jerk along Y axis.
* fBodyAccJerk.std...Z: Fast Fourier Transform of standard deviation of body linear acceleration jerk along Z axis.
* fBodyGyro.mean...X: Fast Fourier Transform of mean of body angular velocity along X axis.
* fBodyGyro.mean...Y: Fast Fourier Transform of mean of body angular velocity along Y axis.
* fBodyGyro.mean...Z: Fast Fourier Transform of mean of body angular velocity along Z axis.
* fBodyGyro.std...X: Fast Fourier Transform of standard deviation of body angular velocity along X axis.
* fBodyGyro.std...Y: Fast Fourier Transform of standard deviation of body angular velocity along Y axis.
* fBodyGyro.std...Z: Fast Fourier Transform of standard deviation of body angular velocity along Z axis.
* fBodyAccMag.mean..: Fast Fourier Transform of mean of the magnitude (using Euclidean norm) of body linear acceleration.
* fBodyAccMag.std..: Fast Fourier Transform of standard deviation of the magnitude (using Euclidean norm) of body linear acceleration.
* fBodyBodyAccJerkMag.mean..: Fast Fourier Transform of mean of the magnitude (using Euclidean norm) of body angular velocity jerk.
* fBodyBodyAccJerkMag.std..: Fast Fourier Transform of standard deviation of the magnitude (using Euclidean norm) of body angular velocity jerk.
* fBodyBodyGyroMag.mean..: Fast Fourier Transform of mean of the magnitude (using Euclidean norm) of body angular velocity.
* fBodyBodyGyroMag.std..: Fast Fourier Transform of standard deviation of the magnitude (using Euclidean norm) of body angular velocity.
* fBodyBodyGyroJerkMag.mean..: Fast Fourier Transform of mean of the magnitude (using Euclidean norm) of body angular velocity jerk.
* fBodyBodyGyroJerkMag.std..: Fast Fourier Transform of standard deviation of the magnitude (using Euclidean norm) of body angular velocity jerk.
