
    Study Design 
--------------------

The raw data is representing Human Activity Recognition data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The raw dataset includes the following files of interest for the final tidy data set:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample for 70% of the 30 volunteers. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample for 30% of the 30 volunteers.

Steps performed to tidy the raw data:

1. The columns in the x data sets are named based on the features vector including a sequence number to prevent duplicates.
2. The number of observations in the x, y and subject sets is equal and the test/training data sets are joined by binding the columns.
3. The resulting test and training sets are merged into one full data set.
4. Only the measurements on the mean and standard deviation are kept among the features and the extraction is done by looking for names that contain s(S)td/m(M)ean.
5. The activities in the original data set are represented by an id ranging from 1 to 6 which is mapped to an activity label in the activity_labels set. That mapping is used to replace the id with a label in the tidy data set by matching the values in the merged data set with the id in the reference table.
6. The column names are given a descriptive variable name. The subjectid and the activity are straightforward, but for the mean/std features, few text transforamtions take place: the original names are stripped off the punctuation (-,()), BodyBody is corrected with one occurrence, all the capital letters are lowered as per the best practise to secure easy reference later on, t is replaced with time and f with freq.
7. Finally, the rows are grouped by subject id and activity and for each group, the mean values of the remaining features is summarized.


    Code Book
-----------------

The tidy data set in R is a data frame with 180 observations of 88 variables defined as:

1. subjectid - integer variable that identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

2. activity - factor variable with 6 levels: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING".

3. The rest of the variables are numeric values representing the mean value of each of the selected mean/std features per subject and activity. The features are normalized and bounded within [-1,1]. 'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

   The name of each feature suggests:
   
   - whether the measurement was taken from the accelerometer ("acc") or the gyroscope ("gyro):
   
    "timebodyaccmeany", "freqbodyaccmeanz", "freqbodyaccmeanfreqy", "freqbodygyromeany", "timebodygyrostdx", "timebodygyromeanz" ... 
   
   - if the signals are time domain signals ("time") or frequency domain signals ("freq") after the Fast Fourier Transform was applied:
   
    "timebodygyromagmean", "timebodygyromagstd", "timebodygyrojerkmagmean", "timebodygyrojerkmagstd", "freqbodyaccmeanx", "freqbodyaccmeany", "freqbodyaccmeanz", "freqbodyaccstdx" ...
   
   - if the signals are jerk signals ("jerk") where the body ("body") linear acceleration and angular ("angle") velocity were derived in time:
    
    "timebodyaccjerkmeanx", "timebodyaccjerkmeany", "timebodyaccjerkmeanz", "timebodyaccjerkstdx", "timebodyaccjerkstdy", "timebodyaccjerkstdz", "angletbodyaccmeangravity", "angletbodyaccjerkmeangravitymean", "angletbodygyromeangravitymean" ...
   
   - if the magnitude ("mag") of these three-dimensional signals was calculated using the Euclidean norm:
   
    "timebodyaccmagmean", "timebodyaccmagstd", "timegravityaccmagmean", "freqbodygyromagmean", "freqbodygyromagstd", "freqbodygyromagmeanfreq", "freqbodygyrojerkmagmean", "freqbodygyrojerkmagstd", "freqbodygyrojerkmagmeanfreq" ...
    
   - if the acceleration signal was separated into body and gravity acceleration signals ("bodyacc"/"gravityacc"): 
   
    "timebodyaccmeanx", "timebodyaccmeany", "timebodyaccmeanz", "timebodyaccstdx", "timebodyaccstdy", "timebodyaccstdz", "timegravityaccmeanx", "timegravityaccmeany", "timegravityaccmeanz", "timegravityaccstdx", "timegravityaccstdy", "timegravityaccstdz", "timegravityaccmagmean", "timegravityaccmagstd" ...   
 
