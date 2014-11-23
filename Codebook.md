#Codebook

## Intro

This code book that describes the variables, the data, and any transformations or work to clean up the data within the W3 project of the Coursera "Getting and Cleaning data" course.

## Data source
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

## Variables
The set of variables that were estimated from these signals are: 
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autoregression coefficients with Burg order equal to 4
* correlation(): Correlation coefficient between two signals
* maxInds(): Index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): Skewness of the frequency domain signal 
* kurtosis(): Kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between some vectors.

No unit of measures is reported as all features were normalized and bounded within [-1,1].

The dataset includes the following files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

## Transformations with the R script

The R script run_analysis.R need to be loaded into your R working directory, and implements the following steps:
* 1. Merges the training and the test sets to create one data set. As preliminary operations, it checks if the necessary data are already existing in the working directory, otherwise it downloads them, same for the package "plyr" needed within the code. Then all the relevant files are read. The merge at point 1 is done with the cbind and rbind functions.
* 2. Extracts only the measurements on the mean and standard deviation for each measurement. Means and std dev are identified and extracted by column name.
* 3. Uses descriptive activity names to name the activities in the data set. Activities can be named via a join on the activity id (description are in activity_labels.txt)
* 4. Appropriately labels the data set with descriptive activity names. Some string manipulations can be done with the gsub function, to better read the column names.
* 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. The required results are written in a file "tidy.txt" (tidy data set with the average of each variable for each activity and each subject, this is done with the ddply in combination with mean function).
