
Getting tidy data from the raw Human Recognition Activity Samsung Smartphone Dataset
-------------------------------------------------------------------------------------

The process of getting and cleaning the raw HAR dataset is automated with the run_analysis.R script that:

- downloads the files with the raw data,
- loads the features, activity labels and training and test data sets into R dataframes,
- processes the data so that the training and test data sets are merged into one complete data set with descriptive variable names for the selected std/mean features
- replaces the activity identifiers with descriptive names for the activities
- groups the data per subject and activity and summarizes the groups by calculating the mean value of each feature in the final set

The tidy data set is written by the R script to a txt file "HARMeanSummary.txt".

The files include a CodeBook.md with the Study Design for the analysis and a Code Book that describes the variables and the units of the tidy dataset.

 