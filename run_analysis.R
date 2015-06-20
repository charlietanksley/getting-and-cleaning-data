library('data.table')
library('dplyr')
library('reshape2')

## Join all the training data together and all the testing data
## together.  Then stick the frames on top of one another.
##
## Returns the big data frame.
gacd.assembleRawData <- function() {
    trainActivities <- read.table('dataset/train/y_train.txt')
    trainUserIds <- read.table('dataset/train/subject_train.txt')
    trainData <- mutate(read.table('dataset/train/X_train.txt'), activityId = trainActivities[,1], userId = trainUserIds[,1])

    testActivities <- read.table('dataset/test/y_test.txt')
    testUserIds <- read.table('dataset/test/subject_test.txt')
    testData <- mutate(read.table('dataset/test/X_test.txt'), activityId = testActivities[,1], userId = testUserIds[,1])

    rbind(trainData, testData)
}

## Get the index and column name for any column that calculates `std`
## or `mean`.
##
## *Uses `make.names` to make sure column names use only legal entities.*
##
## Returns a data frame with colIndex (the column number in the big
## table) and colNames (the name to use for the column ) columns.
gacd.getColumnIndicies <- function(tbl) {
    features <- read.table('dataset/features.txt')
    features <- features[which(grepl(pattern = '-(std|mean)\\(\\)', x = features$V2, ignore.case = TRUE)), ]
    features <- cbind(features, make.names(features[, 2], unique = TRUE, allow_ = FALSE))
    names(features) <- c('colIndex', 'rawColNames', 'colNames')

    features[, c('colIndex', 'colNames')]
}

## Take the `activityId` and `userId` columns from `from` and put them
## on the `to` data frame.
gacd.addIdentifyingInformation <- function(to, from) {
    to <- mutate(to, activityId = from[, 'activityId'])
    to <- mutate(to, userId = from[, 'userId'])

    to
}

## Inserts into the data frame the human readable activity description
## (e.g., 'WALKING') on each row according to the (integer)
## `activityId`.
gacd.addActivityNames <- function(tbl) {
    activities <- read.table('dataset/activity_labels.txt')
    names(activities) <- c('activityId', 'activityName')

    tbl <- merge(x = tbl, y = activities, by.x = 'activityId', by.y = 'activityId')
}

## Converts the large data frame into one that
## * is ordered by userId and activityName (one row for each pair), and
## * has, for each Mean or Standard Deviation column in the original
##   data, one cell with the average for that field for each
##   userId/activityName pair.
##
## Returns this new summary data frame.
gacd.createTidyData <- function(x, id.vars, measure.vars) {
    melted <- melt(data = x, id.vars = id.vars, measure.vars = measure.vars)
    casted  <- dcast(melted, userId + activityName ~ variable, fun=function(x) sum(x) / length(x))
    ordered <- arrange(casted, userId, activityName)

    ordered
}

## Write the data frame to a file.
gacd.writeToTxt <- function(data, filename) {
    write.table(data, filename, row.names = FALSE)
}

gacd.rawData <- gacd.assembleRawData()

## Filter table to just the columns we want.
gacd.columns <- gacd.getColumnIndicies()
gacd.data <- gacd.rawData[, gacd.columns$colIndex]

## Use proper variable names on our main data table
names(gacd.data) <- gacd.columns$colName

## Add in identifying information
gacd.data <- gacd.addIdentifyingInformation(to = gacd.data, from = gacd.rawData)

## Add in activity description
gacd.data <- gacd.addActivityNames(gacd.data)

## Pull out tidy data set
gacd.tidyData <- gacd.createTidyData(x = gacd.data,
                                 id.vars = c('userId', 'activityName'),
                                 measure.vars = gacd.columns$colName)
