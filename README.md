# Course Project Getting And Cleaning Data

The goal of the project:  
You should create one R script called run_analysis.R that does the following:

    1.- Merges the training and the test sets to create one data set.
    2.- Extracts only the measurements on the mean and standard deviation for each measurement. 
    3.- Uses descriptive activity names to name the activities in the data set
    4.- Appropriately labels the data set with descriptive variable names. 
    5.-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Step1: take the raw files downloaded and load in R dataframes, using read.table() with parameter skipNul = TRUE.
Step2: assign the names of features (source features.txt) to the column names of Xtrain and Xtest.
Step3: merge the train data in one dataframe and the test data in another using cbind(). Then merge both to create one data set. (accomplish 1st goal)
Step4: Extract only the measurements on the mean and standard deviation for each measurement. Define a pattern to select mean and std using grep(). The set of variables estimated from the signals to extract as requested are 
  mean(): Mean value
  std(): Standard deviation 
(accomplish 2nd goal)
Step5: merge activity labels (source activity_labels.txt) with de ids in the data set to get descriptive activity names. (accomplish 3rd goal)
Step6: "Maintain" the original names of the measures,but changed to a to a syntactically valid name and human readable. Using first the function make.names() and then patterns and gsub(). (accomplish 4th goal)
Step7: From the data set in last step, creates a second, independent tidy data set with the average of each variable for each activity and each subject, using the verbs of dplyr package: by_group() and summarize_each() 
Step8: to submit the dataset in a file use the write.table() function.

To open the tidy data in R use:

    data <- read.table(file_path, header = TRUE) 
    View(data)
