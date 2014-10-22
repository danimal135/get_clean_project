library(dplyr)

run_analysis<-function ()
{

## script must be executed from the unzipped package folder
## Block #1 for merging the data sets

  
##the column names are read as a 2 column, 561 row table 
feature_labels<-read.table("features.txt")
feature_labels<-as.character(feature_labels[,2])



## read in test data and names
test_x<-read.table("test/X_test.txt",header=FALSE)
names(test_x)<-feature_labels

## read in the subjects with the column name subject
subj_test<-read.table("test/subject_test.txt",col.names="subject")
# read in the activities
test_y<-read.table("test/y_test.txt",col.names="activity")
#combine the test data sets with the subject, activity, and parameters
test_combined<-cbind(subj_test,test_y,test_x)
rm(subj_test,test_y,test_x)
## reading in and naming the training dataset
train_x<-read.table("train/X_train.txt",header=FALSE)
names(train_x)<-feature_labels

## reading in the subjects in the training set
subj_train<-read.table("train/subject_train.txt",col.names="subject")

##reading in the activities of the training set
train_y<-read.table("train/y_train.txt", col.names="activity")

## combine the training set in the same format as the test set
train_combined<-cbind(subj_train,train_y,train_x)


## This is the solution to the first problem of selecting the data
## uses row bind to combine the labeled training and test sets
combined_all<-rbind(train_combined,test_combined)
rm(train_combined,test_combined)

## These two commands use grep to search for the mean and std character strings
## in the names of the columns

means<-grep("mean()",names(combined_all),fixed=TRUE)
stds<-grep("std()",names(combined_all),fixed=TRUE)

# This command stores the column indices of all the variables and puts them in numerical
# order

means_stds<-sort(c(1,2,means,stds))

# selecting from the total data set only the desired columns

selected_data<-combined_all[,means_stds]

selected_data$activity<-factor(selected_data$activity,labels=c("Walking","Walking_upstairs","walking_downstairs","sitting","standing","laying"))
selected_data$subject<-factor(selected_data$subject)

## Final Step, uses dplyr to group the rows by subject and activity, then
## it calculates the mean of each mean and standard deviation.  This gives the
## 180 rows because there are 30 subjects and 6 activities.

subjact<-group_by(selected_data,subject,activity)
tidy_data<-summarise_each(subjact,funs(mean))

write.table(tidy_data,file="tidydata.txt",row.names=FALSE)
  
}