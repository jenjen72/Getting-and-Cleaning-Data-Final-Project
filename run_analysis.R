library(dplyr)

#Declare file/folder names and URL for data source
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archiveFile<-"UCI HAR Dataset.zip"
folderName<-"UCI HAR Dataset"

#Download and unzip the dataset
if(!file.exists(archiveFile)){
  download.file(fileURL, archiveFile, method="curl")
}

if(!file.exists(folderName)){
  unzip(archiveFile)
}

#Import datasets from files
activityTable<-read.table(paste0(folderName,"\\activity_labels.txt"), col.names = c("activityNum", "activityName"))
featuresTable<-read.table(paste0(folderName,"\\features.txt"), col.names = c("featureNum", "featureName"))
subjectTest<-read.table(paste0(folderName,"\\test\\subject_test.txt"), col.names = "subject")
subjectTrain<-read.table(paste0(folderName,"\\train\\subject_train.txt"), col.names="subject")
testActivities<-read.table(paste0(folderName,"\\test\\Y_test.txt"), col.names = "activity")
trainActivities<-read.table(paste0(folderName,"\\train\\Y_train.txt"), col.names = "activity")
testData<-read.table(paste0(folderName,"\\test\\X_test.txt"), col.names = featuresTable$featureName)
trainData<-read.table(paste0(folderName,"\\train\\X_train.txt"), col.names = featuresTable$featureName)

#Combine test and train sets
allData<-rbind(testData, trainData)
allActivites<-rbind(testActivities, trainActivities)
allSubjects<-rbind(subjectTest, subjectTrain)

#Merge into one combined dataframe
mergedData<-cbind(allSubjects,allActivites,allData)

#Replace activity number with descriptive activity name
mergedData$activity <- activityTable[mergedData$activity, 2]

#Extract only columns with mean and standard deviation data
columns<-grep(".*mean.*|.*std.*",colnames(mergedData))
reducedData<-select(mergedData, subject, activity, columns)

#Replace features with descriptive variable names
names(reducedData)<-gsub("tBody","TDBody",names(reducedData))
names(reducedData)<-gsub("tGravity", "TDGravity", names(reducedData))
names(reducedData)<-gsub("fBody","FFT",names(reducedData))
names(reducedData)<-gsub(".mean", "Mean", names(reducedData))
names(reducedData)<-gsub(".std", "StdDev", names(reducedData))
names(reducedData)<-gsub("\\.*", "", names(reducedData))

#Summarize variables using mean by subject and activity
tidyData<- reducedData %>% group_by(subject, activity) %>%
           summarize_all(funs(mean))

#Write out tidy dataset
write.table(tidyData, "TidyDataset.txt", row.names = FALSE, sep="\t", quote = FALSE)

