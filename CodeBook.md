# Codebook for Modified Data Processing Script

## About the Source Data

The source data comes from the Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## About the R Script

The modified R script (`modified-data-processing-script.R`) performs data preparation and processing in several steps:

1. **Load Required Libraries**
   - The script uses `dplyr` for data manipulation and `readr` for writing CSV files.

2. **Download and Unzip the Dataset**
   - Checks if the zip file exists, downloads if necessary.
   - Unzips the file if the dataset directory doesn't exist.

3. **Read Data Files**
   - A `read_data` function is created to simplify file reading.
   - The following files are read:
     * `features.txt`: List of all features.
     * `activity_labels.txt`: Links the class labels with their activity name.
     * `train/X_train.txt`: Training set.
     * `train/y_train.txt`: Training labels.
     * `train/subject_train.txt`: Subject who performed the activity for each window sample in the training set.
     * `test/X_test.txt`: Test set.
     * `test/y_test.txt`: Test labels.
     * `test/subject_test.txt`: Subject who performed the activity for each window sample in the test set.

4. **Set Column Names**
   - Appropriate column names are assigned to each dataset.

5. **Merge Datasets**
   - Training and test sets are merged using `bind_rows` and `bind_cols` functions.

6. **Extract Mean and Standard Deviation Measurements**
   - A new dataset is created with only the measurements on the mean and standard deviation for each measurement.

7. **Use Descriptive Activity Names**
   - Activity codes are replaced with descriptive activity names.

8. **Clean Up Variable Names**
   - A `clean_names` function is created to make variable names more descriptive:
     * "t" at the start of a name is replaced with "Time"
     * "f" at the start of a name is replaced with "Frequency"
     * "Acc" is replaced with "Accelerometer"
     * "Gyro" is replaced with "Gyroscope"
     * "Mag" is replaced with "Magnitude"
     * "BodyBody" is replaced with "Body"
     * "-mean()" is replaced with "Mean"
     * "-std()" is replaced with "Std"
     * "-freq()" is replaced with "Frequency"

9. **Create Tidy Dataset with Averages**
   - A new tidy dataset is created with the average of each variable for each activity and each subject.

10. **Write the Tidy Dataset to a File**
    - The final tidy dataset is written to a CSV file named "tidy_dataset.csv".

## Output

The script produces a tidy dataset ("tidy_dataset.csv") with the following variables:

1. `subject`: The ID of the test subject
2. `activity`: The type of activity performed
3. Various measurement variables: These are averages of the mean and standard deviation measurements for each subject and activity. The variable names describe the measurement type (e.g., TimeBodyAccelerometerMeanX, FrequencyBodyGyroscopeStdY).

Note: The exact number and names of measurement variables will depend on the original dataset and the mean/std extraction process.