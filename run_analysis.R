library(dplyr)
library(readr)

# Function to download and unzip the dataset
download_dataset <- function(url, filename) {
  if (!file.exists(filename)) {
    download.file(url, filename, method = "curl")
  }
  
  if (!dir.exists("UCI HAR Dataset")) {
    unzip(filename)
  }
}

# Download the dataset
download_dataset(
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
  "Coursera_Week4_FinalAssignment.zip"
)

# Function to read and combine datasets
read_data <- function(type) {
  x <- read_table(paste0("UCI HAR Dataset/", type, "/X_", type, ".txt"))
  y <- read_table(paste0("UCI HAR Dataset/", type, "/y_", type, ".txt"), col_names = "code")
  subject <- read_table(paste0("UCI HAR Dataset/", type, "/subject_", type, ".txt"), col_names = "subject")
  cbind(subject, y, x)
}

# Read datasets
train_data <- read_data("train")
test_data <- read_data("test")
activities <- read_table("UCI HAR Dataset/activity_labels.txt", col_names = c("code", "activity"))
features <- read_table("UCI HAR Dataset/features.txt", col_names = c("n", "functions"))

# Step 1: Merge the training and test sets
merged_data <- rbind(train_data, test_data)
colnames(merged_data)[3:ncol(merged_data)] <- features$functions

# Step 2: Extract mean and standard deviation measurements
tidy_data <- merged_data %>% 
  select(subject, code, contains("mean"), contains("std"))

# Step 3: Use descriptive activity names
tidy_data <- tidy_data %>%
  left_join(activities, by = "code") %>%
  select(-code)

# Step 4: Label the dataset with descriptive variable names
name_mappings <- c(
  "Acc" = "Accelerometer",
  "Gyro" = "Gyroscope",
  "BodyBody" = "Body",
  "Mag" = "Magnitude",
  "^t" = "Time",
  "^f" = "Frequency",
  "tBody" = "TimeBody",
  "-mean\\(\\)" = "Mean",
  "-std\\(\\)" = "STD",
  "-freq\\(\\)" = "Frequency",
  "angle" = "Angle",
  "gravity" = "Gravity"
)

for (old_name in names(name_mappings)) {
  names(tidy_data) <- gsub(old_name, name_mappings[old_name], names(tidy_data), ignore.case = TRUE)
}

# Step 5: Create a second, independent tidy dataset with averages
final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

# Write the final dataset to a file
write_csv(final_data, "FinalTidyData.csv")