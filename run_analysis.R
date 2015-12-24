#read the files from the UCI HAR Dataset
#features.txt contains the labels of the features (measurements / columns of the X_train and X_test)
rfeatures <- read.table("./UCI HAR Dataset/features.txt",skipNul = TRUE)

#activity_labels.txt contains the labels of the activities (to "translate" the y_train and y_test)
ractivitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt",skipNul = TRUE)
names(ractivitylabels) <- c("id","activity")

#read files from train dir
rytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", skipNul = TRUE)
rXtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", skipNul = TRUE)
rsubjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",skipNul = TRUE)

#assign the names of features to the column names of Xtrain
names(rXtrain) <- rfeatures$V2
names(rsubjecttrain) <- c("subject_train")
names(rytrain) <- c("act_labels")

#merge the train data in one dataframe
datatrain <- cbind(rsubjecttrain,rytrain,rXtrain)

#read files from test dir
rytest <- read.table("./UCI HAR Dataset/test/y_test.txt", skipNul = TRUE)
rXtest <- read.table("./UCI HAR Dataset/test/X_test.txt", skipNul = TRUE)
rsubjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt",skipNul = TRUE)
#assign the same colnames as before
names(rytest) <- names(rytrain)
names(rsubjecttest) <- names(rsubjecttrain)
names(rXtest) <- names(rXtrain)
#merge the test data in one dataframe
datatest <- cbind(rsubjecttest,rytest,rXtest)

#1.- Merge the training and the test sets to create one data set.
datatotal <- rbind(datatrain,datatest)

#2.- Extracts only the measurements on the mean and standard deviation for each measurement. 
#pattern to select mean and std
ptnmean = '*mean[^F]|std[^F]'
#select column names of the measurements on the mean and standard deviatio
colvalues <- grep(ptnmean, names(datatotal),value = TRUE)
#data with only the mean and std
datameanstd <- datatotal[,c("subject_train","act_labels",colvalues)]

#3.- Uses descriptive activity names to name the activities in the data set
datameanstd_act = merge(ractivitylabels,datameanstd,by.x = "id", by.y = "act_labels", all = TRUE)

#4.- Appropriately labels the data set with descriptive variable names.
#Mantain the original names of the measures, and the columns subject and activity 
#also have their names set above. But changed to a to a syntactically valid name
library(dplyr)
data4 <- select(datameanstd_act,-id)
names(data4) <- make.names(names(data4),unique = TRUE)
cols <- names(data4)
cols2 <- gsub("^t","Time",cols)
cols3 <- gsub("^f","Frequency",cols2)
cols4 <- gsub("*Acc*","Acceleration",cols3)
cols5 <- gsub("*Gyro*","AngularVelocity",cols4)
names(data4) <- cols5

#5.- From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
by_act_subject <- group_by(data4, activity, subject_train)
data5 <- summarize_each(by_act_subject,funs(mean))

#save the data in a textfile to submit
write.table(data5,file="dataset5.txt",row.names = FALSE)