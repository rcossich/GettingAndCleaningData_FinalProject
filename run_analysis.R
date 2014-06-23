## created by Ricardo Cossich for final project of coursera course Getting and Cleaning
## data, June 22th.

## i set my working directory.
##setwd("/Volumes/SAMSUNG/Backup Disco RCE/RCE 2012/Gestion de Calidad/Capacitaciones/Cursos Coursera/Getting and Cleanind Data/Final Project Files/UCI HAR Dataset")
## start to loading the files

## activities and features
activities_table <- read.table("./activity_labels.txt",quote="\"")
features_table <- read.table("./features.txt",quote="\"")

## renaming column names, making sense
## activities
colnames(activities_table) <- c("activity_code","activity_name")
## features
colnames(features_table) <- c("feature_code","feature_name")

## TEST files
subject_test <- read.table("./test/subject_test.txt",quote="\"")
X_test <- read.table("./test/X_test.txt",quote="\"")
y_test <- read.table("./test/y_test.txt",quote="\"")

##TRAIN files
subject_train <- read.table("./train/subject_train.txt",quote="\"")
X_train <- read.table("./train/X_train.txt",quote="\"")
y_train <- read.table("./train/y_train.txt",quote="\"")

## naming X_test and X_train columns with feature name
## reading feature name in a variable
features <- features_table$feature_name
colnames(X_test) <- features
colnames(X_train) <- features

## naming y_test and y_train column
colnames(y_test) <- c("activity_code")
colnames(y_train) <- c("activity_code")

## naming subject column
colnames(subject_test) <- c("subject_id")
colnames(subject_train) <- c("subject_id")

## JOIN the data sets to take subject id and activity name into each dataset
## train and test.
new_X_test <- cbind(subject_id=subject_test$subject_id,activity_id=y_test$activity_code,X_test)
new_X_train <- cbind(subject_id=subject_train$subject_id,activity_id=y_train$activity_code,X_train)

## get the activity name by merging this new datafiles with activities_table
merged_X_test <- merge(new_X_test,activities_table,by.x="activity_id",by.y="activity_code")
merged_X_train <- merge(new_X_train,activities_table,by.x="activity_id",by.y="activity_code")

## filter columns to summarize after merging train and test data
merged_X <- rbind(merged_X_test,merged_X_train)
## create filtered features index
filtered_features <- features_table[grep("mean()|std()",features_table$feature_name),]
## create vector listing columns to import to final data frame before summarizing
columns <- c(2,filtered_features$feature_code+2,564) ## filtered_features add 2
## created final data frame before summarizing
merged_X_filtered_features <- merged_X[,columns]

## with this new data frame, use melt and then dcast to obtain the desired result.
library(reshape2)
X_melted_table <- melt(merged_X_filtered_features,id=c("subject_id","activity_name"))
summarized_X <- dcast(X_melted_table,subject_id+activity_name~variable,mean)

## we need to write the results to a file for upload to Github (as required)
write.table(summarized_X,'final_result.txt',sep='\t')
