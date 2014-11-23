# This R script does the following: 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# check package, download data and read files
if (!require(plyr)) { 
        install.packages("plyr") 
}

if (!file.exists("UCI HAR Dataset")) {
        print("downloading data")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "Dataset.zip", method = "curl")
        unzip("Dataset.zip")
}
print("Loading existing data in folder UCI HAR Dataset")
features <- read.table("./UCI HAR Dataset/features.txt", colClasses = c("character"))
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityId", "Activity"))
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
print("Loading completed")

# 1. Merge and label columns
X_test<-cbind(cbind(X_test,y_test),subject_test)
X_train<-cbind(cbind(X_train,y_train),subject_train)
total<-rbind(X_test,X_train)
print("Merge completed")

labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(total) <- labels

# 2. Extract mean and stddev
print("Extracting mean and stddev")
total_mean_std <- total[,grepl("mean|std|Subject|ActivityId", names(total))]

# 3. name activities in the data set
print("renaming activities")
total_mean_std <- join(total_mean_std, activity_labels, by = "ActivityId", match = "first")
total_mean_std <- total_mean_std[,-1]

# 4. labels the data set
print("renaming dataset")
names(total_mean_std) <- gsub('\\(|\\)',"",names(total_mean_std), perl = TRUE)
names(total_mean_std) <- make.names(names(total_mean_std))
names(total_mean_std) <- gsub('GyroJerk',"AngAcc",names(total_mean_std))
names(total_mean_std) <- gsub('Gyro',"AngSpeed",names(total_mean_std))

# 5. create tidy data set
print("creating tidy dataset")
data_temp = ddply(total_mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(data_temp, file = "tidy.txt")
