---
title: "Code Book"
author: "Andre Noudjo"
date: "October 25, 2015"
output: html_document
---



```{r}
download.file(zipfiles, destfile = "./projectFiles", mode = "wb")
unlink
#require reshape2
#require plyr
#require dplyr

The above package and their respective library are installed. The ReadMe document detailed their objective

#We created a destination file to host the zip file from the web. The file is downloaded via the download.file function, then we checked if the file is not already unzip to go ahead and unzip the file.  
projectfiles <- "getdata_dataset.zip"
zipfiles <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipfiles, projectfiles, mode = "wb")

# unzip file if it is not already
if (!file.exists("UCI HAR Dataset")) { 
        unzip(projectfiles) 
}
# We also read all the files to new directory data1 which list all files, labels, and features
data1 <- list.files( "./UCI HAR Dataset", all.files = FALSE)
varnames <- read.table(file = "features.txt")
varnames[, 2] <- as.character(varnames[, 2])
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

# We extract only the measurements variables that are needed for this project which are the mean and standard deviation. We also apply descriptive activity names to name the activities in the dataset
measuredvar <- grep(".*mean.*|.*std.*", varnames[,2])
measuredvarnames <- varnames[measuredvar,2]
measuredvarnames = gsub('-mean', 'Mean', measuredvarnames)
measuredvarnames = gsub('-std', 'Std', measuredvarnames)
measuredvarnames = gsub('[-()]', '', measuredvarnames)

# We load the train and test dataset and appropriately labels them with descriptive variable names.
# then combine those data file into one dataset file which is merged together as merged data using the cbind_rows function. We then change the colnames to eliminate the generic X2 column names.
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

# The next step is to transform the activity and subjects attributes to factor. The function factor is used to encode a vector as a factor
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$activity <- as.factor(mergedData$activity)

# We convert the merged data into molten data frame using the melt function and dcast to reshape the data back to data frame with the subject and activity variable.

mergedatMelted <- melt(mergedData, id = c("subject", "activity"))

mergedData.mean <- dcast(mergedatMelted, subject + activity ~ variable, mean)

#creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
write.table(mergedData.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)
```


References
http://vita.had.co.nz/papers/tidy-data.pdf
https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html
https://github.com/hadley/data-baby-names
https://github.com/hadley/data-fuel-economy
https://cran.r-project.org/web/packages/plyr/index.html
https://cran.r-project.org/web/packages/dplyr/README.html)


