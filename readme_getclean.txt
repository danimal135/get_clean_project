README

Submission for the course project of Getting and Cleaning Data

The five tasks were:

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

The solutions to each problem are described by number:

1.My code achieves this by first reading in the subject, activity, and data measurements for both sets, and using a combination of cbind and 
rbind to merge into one data set

2.THe proper columns are selected by a text search of the column names lookign for an exact match to the strings "mean()" and "std"

3 and 4.The subject column was given the name subject, and the activity column was renamed with the activity that each number represented (walking, etc.)
This was achieved in a single command that converted the activity to a factor variable and gave the corresponding label to each.

5.I used solutions enabled by dplyr to first group the columns by (group_by) a shared subject and activity.  The command summarise_each, 
passed the argument funs(mean) then computes the mean of each group.  The result is a 180 row dataset that contains a mean for each of the 66 mean
and standard deviation measurements.


