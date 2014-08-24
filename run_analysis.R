
## Getting and Cleaning Data

## Programmming Assignment 

## run_analysis.R

##  You should create one R script called run_analysis.R that does the following. 
##    1. Merges the training and the test sets to create one data set.
##    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##    3. Uses descriptive activity names to name the activities in the data set
##    4. Appropriately labels the data set with descriptive variable names. 
##    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Joe Baweja

# Read in the data from files
features = read.table('./features.txt',header=FALSE, colClasses="character");
activity_labels = read.table('./activity_labels.txt',header=FALSE, colClasses="character"); #activities
subject_train = read.table('./train/subject_train.txt',header=FALSE); #trainDAta_sub
x_train = read.table('./train/x_train.txt',header=FALSE); #trainData
y_train = read.table('./train/y_train.txt',header=FALSE); #trainiDAta_act

# Read in the test data
subject_test = read.table('./test/subject_test.txt',header=FALSE); #testDAta_sub
x_test = read.table('./test/x_test.txt',header=FALSE); #testDAta
y_test = read.table('./test/y_test.txt',header=FALSE); #testDAta_act

# Use descriptive activity names to name the activities in the data set
y_test$V1 <- factor(y_test$V1,levels=activity_labels$V1,labels=activity_labels$V2)
y_train$V1 <- factor(y_train$V1,levels=activity_labels$V1,labels=activity_labels$V2)

# Appropriately label the data set with descriptive activity names.
colnames(x_test)<-features$V2
colnames(x_train)<-features$V2
colnames(y_test)<-c("Activity")
colnames(y_train)<-c("Activity")
colnames(subject_test)<-c("Subject")
colnames(subject_train)<-c("Subject")

testData<-cbind(x_test,y_test)
testData<-cbind(testData,subject_test)
trainData<-cbind(x_train,y_train)
trainData<-cbind(trainData,subject_train)

combinedData<-rbind(testData,trainData)

# Extract only the measurements on the mean and standard deviation for each measurement.
combinedData_mean<-sapply(largeData,mean,na.rm=TRUE)
combinedData_sd<-sapply(largeData,sd,na.rm=TRUE)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
DT <- data.table(combinedData)
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy,file="tidy.txt",sep="\t",row.names = FALSE)
