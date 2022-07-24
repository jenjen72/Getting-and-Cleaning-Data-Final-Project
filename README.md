# Getting-and-Cleaning-Data-Final-Project
The final project in the Getting and Cleaning Data course

The run_analysis.r program does the following:

1. Downloads the dataset archive file
2. Unzips the dataset archive
3. Imports the following files from the archive into tables:
	a. activity_labels.txt -> activityTable
	b. features.txt - > featuresTable
	c. subject_test.txt -> subjectTest
	d. subject_train.txt -> subjectTrain
	e. Y_test.txt -> testActivities
	f. Y_train.txt -> trainActivities
	g. X_test.txt -> testData
	h. X_train.txt -> trainData
4. Perform row combine on the test and train tables to create the following tables:
	a. subjectTest & subjectTrain -> allSubjects
	b. testActivities & trainActivities -> allActivities
	c. testData & trainData -> allData
5. 	Perform a column combine to merge subjects, activities, and data into one table:
		allSubjects & allActivities & allData -> mergedData
6. Replace numeric activity identifiers with descriptive activity identifiers in mergedData table
7. Extract only mean and standard deviation features from the mergeData table into the reducedData table
8. Perform text substitutions to create more descriptive variable names for the features in the reducedData table
9. Use mean to summarize the features grouped by both the subject and activity variables into the tidyData dataframe
10. Write out the tidyData dataframe into a tab delimited text file.
