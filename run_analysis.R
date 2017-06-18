# 0. Downloading the files with raw data

# Creating a local directory where the files will be placed

dir.create("project_har")
setwd("project_har")

# Downloading and unpacking the zipped files and setting the new directory as a working directory

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","HAR.zip")
unzip("HAR.zip")
setwd("./UCI HAR Dataset")

# Loading the raw data into R data frames
features <- read.table("features.txt",header=FALSE,stringsAsFactors = FALSE)
activity_labels <- read.table("activity_labels.txt",header=FALSE)

subject_test <- read.table("./test/subject_test.txt",header=FALSE)
x_test <- read.table("./test/X_test.txt",header=FALSE)
y_test <- read.table("./test/y_test.txt",header=FALSE)

subject_train <- read.table("./train/subject_train.txt",header=FALSE)
x_train <- read.table("./train/X_train.txt",header=FALSE)
y_train <- read.table("./train/y_train.txt",header=FALSE)

# Naming the columns in the test and train x data sets with the feature labels 
# preceeded by the sequence numbers in the first column of the features set to avoid duplicates.
# This is required to be able to select the std and mean features based on the column names

onefeatures <- paste(features$V1,features$V2)

featurelist <- as.vector(onefeatures)

colnames(x_test) <- featurelist
colnames(x_train) <- featurelist

# 1. Merging the training and the test data sets into one data set

testset <- cbind(subject_test,x_test,y_test)

trainset <- cbind(subject_train,x_train,y_train)

fullset <- rbind(trainset,testset)

# 2. Extracting the measurements on the mean and standard deviation for each measurement

filteredset <- cbind(fullset[1],fullset[ncol(fullset)],fullset[grepl("[sS][tT][dD]|[mM][eE][aA][nN]",colnames(fullset))])

# 3. Applying descriptive activity names to name the activities in the data set

filteredset[2]<-lapply(filteredset[2], function(x) activity_labels$V2[match(x, activity_labels$V1)])

# 4. Labelling the data set with descriptive variable names

colnames(filteredset)[1] <- "subjectid"
colnames(filteredset)[2] <- "activity"

# The column names representing the features are stripped off the punctuation (-,()),
# BodyBody is corrected with one occurrence, all the capital letters are lowered,
# t is replaced with time and f with freq

colnames(filteredset) <- gsub("\\S+ |[[:punct:]]","",colnames(filteredset)) 
colnames(filteredset) <- gsub("BodyBody","Body",colnames(filteredset))
colnames(filteredset) <- tolower(colnames(filteredset))
colnames(filteredset) <- gsub("^t","time",colnames(filteredset)) 
colnames(filteredset) <- gsub("^f","freq",colnames(filteredset)) 

# 5. Creating a new ndependent tidy set with the average of each variable for each activity and each subject

avgFeatures <- filteredset %>% group_by(subjectid, activity) %>% summarise_each(funs(mean(., na.rm=TRUE)))

write.table(avgFeatures,"HARMeanSummary.txt",row.name=FALSE)
