# Getting and Cleaning Data - Course Project

This repository contains the R code, codebook, and the tidy dataset for the course project of the "Getting and Cleaning Data" course.

## Files:

- `CODEBOOK.md`: Describes how to use all this, variables, the data, and any transformations or work performed to clean up the data.

- `modified-data-processing-script.R`: Contains all the code to perform the analysis described in the following 5 steps:

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set.
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- `tidy_dataset.csv`: The output of the final step, containing the processed and summarized data.

## Running the Script:

1. Ensure you have R installed on your system.
2. Install required packages by running:
   ```R
   install.packages("dplyr")
   install.packages("readr")
   ```
3. Set your working directory to where the `modified-data-processing-script.R` file is located.
4. Run the script using:
   ```R
   source("modified-data-processing-script.R")
   ```

The script will automatically download the dataset if needed, process the data, and create the `tidy_dataset.csv` file in your working directory.

## Additional Information:

For more details about the variables, data, and transformations, please refer to the `CODEBOOK.md` file.

The original dataset comes from the "Human Activity Recognition Using Smartphones" study. More information can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
