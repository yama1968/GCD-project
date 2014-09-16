---
title: "CodeBook.md"
output:
  html_document:
    theme: cosmo
---

Source data
---------------------------------------------------------------------------------------

Data is obtained from the files in the `train` and `test` directories, which contains one line per measurement (with xx=`train` or `test`)
- subject_xx.txt with subject identifier as an integer
- y_xx.txt with activity id as an integer
- X_xx.txt with 561 numeric values in fixed width format (1 space, and then 561 16-characters numeric values)

From top level `UCI HAR Dataset` directory, we use
- features.txt to determine that the mean and std variables are the first 6 numeric values of each sample measurement
- activity_labels.txt to determine text label of activity from integer value

Transformations for getting complete data sets of means and standard deviations per measurement
---------------------------------------------------------------------------------------

For each directory, 'train' and 'test', we perform the same operations:
- read the X_xx.txt file as fixed width, extracting only the first 6 values of each measurement line, naming them: meanX, meanY, meanZ, stdX, stdY, stdZ
- read the subject_xx.txt for the subject identifier, and transform it into a factor
- read the activity_labels.txt to get relationship between activity ids and activity labels
- read the activity ids from y_xx.txt, and translate into activity labels
- column bind subject ids, activity labels and the 6 variables meanX, meanY, meanZ, stdX, stdY, stdZ to get an 8 columns measurement data frame, one line per measurement sample

Then we row bind the two 8 columns data frames to get the complete data set

Result: complete measurement data set
------------------------------------------------------------------------------------------

- subject: a numeric value, id of the subject performing the activity and being measured
- activity: a character string as factor, describing the activity being performed by the subject
- meanX, meanY, meanZ, stdX, stdY, stdZ: measurements for respectively mean and standard deviations, in the X, Y, Z axis, for the subject at measurement point

Transformations for getting summary data set
-----------------------------------------------------------------------------------------

Summarize the complete data set:
- along subject id and activity label
- taking the mean of variables meanX, meanY, meanZ, stdX, stdY, stdZ, across all measurements with same subject id and activity label

Result: summary data set
------------------------------------------------------------------------------------------

- subject: a numeric, id of the subject being summarized, with values between 1 and 30
- activity: a character string as factor, describing the activity being summarized, which can take the following values:
```
WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING
```
- meanX, meanY, meanZ, stdX, stdY, stdZ: average of measured values across all sample, for respectively mean and standard deviations, in the X, Y, Z axis. Their values range from -1.0000 to 1.0000

The summary ```summary.txt``` file can be read with the following R command:
```
df = read.csv('summary.txt')
```




