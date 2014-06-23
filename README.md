## created by Ricardo Cossich for final project of coursera course Getting and Cleaning
## data, June 22th.

1) First i set my working directory.
2) Then _I load the files i need to create the datafiles in R
    - Activities
    - Features
    - X and y files for train and test data.
3) Rename columns in X files with the features table.
4) Add the activity and subject_id columns to the X files.
5) Add the activity name using merge command with the activities table
6) Using rbind i join data for train and test in a single data frame.
7) Using grep i filter the measured features we want to summarize (mean and std)
8) With this new filtered data frame i am ready to summarize
9) Using melt we create the intermediate table to summarize data by activity and subject.
10) using dcast we create the summarized data frame.
11) using write.table we created the text file with the final result.

