## run_analysis.R ##
## Benjamin Zimmerman, 7/21/2014 ##

## Reference for data used:
## [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
##  Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
##  International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# The first function downloads and extracts the data

download.data <- function () {
  zip.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zip.file <- "accelerometer_dataset.zip"
	
require(downloader)
## the downloader package works better for me than the download.file command

  download(zip.url,zip.file, mode = "wb")
  unzip(zip.file)
} 



## First extract out all of the test and training data to get it all
## into one place. I use the row numbers as ID. 

## If you skip the first portion, go to "UCI HAR Dataset/"

#1. Combine train and test

	# Build training data table


		training_set_directory <- paste("train", "/", sep = "")
  		file.data.train <- paste(training_set_directory, "X_train", ".txt", sep = "")
  		file.activity_label.train <- paste(training_set_directory, "y_train", ".txt", sep = "")
  		file.subject.train <- paste(training_set_directory, "subject_train", ".txt", sep = "")


		subject_train = read.table(file.subject.train, col.names=c("subject_id"))
		subject_train$ID <- as.numeric(rownames(subject_train))


		# read training data
		X_train = read.table(file.data.train)
		X_train$ID <- as.numeric(rownames(X_train))
	


		# read activity type
		y_train = read.table(file.activity_label.train, col.names=c("activity_id"))  
		y_train$ID <- as.numeric(rownames(y_train))



		train <- merge(subject_train, y_train,by.x = "ID", by.y = "ID", all=TRUE)
		train <- merge(train, X_train, by.x = "ID", by.y = "ID", all=TRUE)

		train <- train[,-1]

	# Build training data table


		test_set_directory <- paste("test", "/", sep = "")
  		file.data.test <- paste(test_set_directory, "X_test", ".txt", sep = "")
  		file.activity_label.test <- paste(test_set_directory, "y_test", ".txt", sep = "")
  		file.subject.test <- paste(test_set_directory, "subject_test", ".txt", sep = "")


		subject_test = read.table(file.subject.test, col.names=c("subject_id"))
		subject_test$ID <- as.numeric(rownames(subject_test))


		# read test data
		X_test = read.table(file.data.test)
		X_test$ID <- as.numeric(rownames(X_test))
	


		# read activity type
		y_test = read.table(file.activity_label.test, col.names=c("activity_id"))  
		y_test$ID <- as.numeric(rownames(y_test))



		test <- merge(subject_test, y_test,by.x = "ID", by.y = "ID", all=TRUE)
		test <- merge(test, X_test, by.x = "ID", by.y = "ID", all=TRUE)

		test <- test[,-1]



 

		
		data <- rbind(train, test)
		

# 2. Extract only the measurements on the mean and standard deviation

	# Find the indices for features that include means and standard deviations

	
		features <- read.table("features.txt", col.names = c("feature_id","feature_label"),)["feature_label"]
		relevant_indices <- grep("mean|std", features$feature_label)

		relevant_colnames <- colnames(X_test)[relevant_indices]

		data_subset <- subset(data, select = c("subject_id","activity_id",relevant_colnames ))
		



# 3. Use descriptive activity names to name the activities in the data set

		
		activity.labels <- read.table("activity_labels.txt", col.names = c("activity_id","activity_label"))
		data_subset$activity_id <- factor(data_subset$activity_id, levels = c(1:6) , labels = activity.labels$activity_label)


# 4. Appropriately labels the data set with descriptive variable names.

	## I don't know why I have to do this, but I couldn't figure out how to name a subset of columns
		variable_subset <- data_subset[,3:81]
		names(variable_subset) <- features$feature_label[relevant_indices]
		data_subset <- cbind(data_subset[,1:2], variable_subset)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

		data_subset2 <- data_subset
		data_subset2[,2] <- as.numeric(data_subset[,2])

		aggdata <-aggregate(data_subset2, by=list(subject = data_subset2$subject_id, activity = data_subset2$activity_id), FUN=mean, na.rm=TRUE)

		drops <- c("subject","activity")
		aggdata <- aggdata[,!(names(aggdata) %in% drops)]

		aggdata$activity_id <- factor(aggdata$activity_id, levels = c(1:6) , labels = activity.labels$activity_label)

		
		write.csv(file="merged_data.csv", x = data_subset)
		write.csv(file="tidy_data.csv", x=aggdata)
