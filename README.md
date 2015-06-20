# Getting and Cleaning Data

The file `run_analysis.R`, when sourced, will provide three
interesting data frames and a command to write the tidy version of the
data to disk.  *Note* that this script assumes that the Human Activity
Recognition Using Smartphones Dataset is located in the `dataset`
directory at the same level as this file, though that dataset *is not*
included in this repository (it is simply too large and it is readily
accessible online).

`gacd.rawData` stores the complete raw data from the 'Human Activity
Recognition Using Smartphones Dataset'.  That frame has a column for
each reading in the datasets plus columns for userId and activityId.
It has rows for each reading in the test and train datasets.

`gacd.data` is a cleaned-up subset of that data.  The differences are
(a) that this version uses descriptive variable names for the columns,
(b) this version contains an activityName column with a descriptive
activity name, and (c) this *only* contains measurement columns that
deal with standard deviation or mean.

`gacd.tidyData` is an even further cleaned version of this data.  It
is ordered by userId and activityName, and it has one row per
userId/activityName pair.  It has a column for each of the mean and
standard deviation columns in `gacd.data`, where the value for that
column is the average measurement (of that value) for the
userId/activityName pair.

`gacd.writeToTxt` gives you a simple wrapper command to write any of
these datasets to a space-delimited file.
