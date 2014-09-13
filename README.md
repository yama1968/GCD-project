---
title: "README"
output: html_document
---

All the work is performed by the run_analysis.R script.

Where
---------------------------------------------------------------------------------------

- you should run it with working file the directory where 'UCI HAR Dataset' extracted main directory is located

What, steps 1, 2, 3, 4
---------------------------------------------------------------------------------------

- the script begins with reading each of training and testing, reading subject id, label and the 6 variables, means and standard deviation of movements along X, Y, Z axis
- then it merge them into a single data set
- and then get it into the tidyDataComplete data frame variable

What, step 5
---------------------------------------------------------------------------------------

- the script then compute the summary data set
- write it to the 'summary.txt' file
- and then get the tidyDataSummary summary data frame variable

How
---------------------------------------------------------------------------------------

- just run the script with working directory containing 'UCI HAR Dataset' head directory

Input parameters
---------------------------------------------------------------------------------------

- none

Outputs
---------------------------------------------------------------------------------------

- tidyDataComplete: complete data set as data frame
- tidyDataSummary: summary data set with averages
- 'summary.txt' csv file, produce in working directory, and can be read back with read.csv('summary.txt')

