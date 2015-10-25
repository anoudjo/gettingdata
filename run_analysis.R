# R Tidy Data project: create a script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

temp <- tempfile()

download.file(zipfiles, destfile = "./projectFiles", mode = "wb")
unlink
#require reshape2
#require plyr
#require dplyr
#require tidyr

#set up a destination file
projectfiles <- "getdata_dataset.zip"
zipfiles <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipfiles, projectfiles, mode = "wb")

# unzip file if it is not already
if (!file.exists("UCI HAR Dataset")) { 
        unzip(projectfiles) 
}
# list all files and load individual files, labels and features
data1 <- list.files( "./UCI HAR Dataset", all.files = FALSE)
varnames <- read.table(file = "features.txt")
varnames[, 2] <- as.character(varnames[, 2])
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

# Extracts only the measurements on the mean and standard deviation for each measurement
# Uses descriptive activity names to name the activities in the data set
measuredvar <- grep(".*mean.*|.*std.*", varnames[,2])
measuredvarnames <- varnames[measuredvar,2]
measuredvarnames = gsub('-mean', 'Mean', measuredvarnames)
measuredvarnames = gsub('-std', 'Std', measuredvarnames)
measuredvarnames = gsub('[-()]', '', measuredvarnames)

#Appropriately labels the data set with descriptive variable names.
# load the datasets
xtestdat <- read.table(file = "test/X_test.txt", header = TRUE)
ytestdat <- read.table(file = "test/y_test.txt", header = TRUE)
subjecttest <- read.table(file = "test/subject_test.txt", header = TRUE)
testdata <- cbind(subjecttest, ytestdat, xtestdat)

xtraindat <- read.table(file = "train/X_train.txt", header = TRUE)
ytraindat <- read.table(file = "train/y_train.txt", header = TRUE)
subjecttrain <- read.table(file = "train/subject_train.txt", header = TRUE)
traindata <- cbind(subjecttrain, ytraindat, xtraindat)

# merge the train and test datasets
mergedData <- bind_rows(testdata, traindata)
colnames(mergedData) <- c("subject", "activity", measuredvarnames)

# transform the activity and subjects attributes to factor
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$activity <- as.factor(mergedData$activity)

# reshape the data with melt and produce new variable with cast

mergedatMelted <- melt(mergedData, id = c("subject", "activity"))

mergedData.mean <- dcast(mergedatMelted, subject + activity ~ variable, mean)

#creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
write.table(mergedData.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)