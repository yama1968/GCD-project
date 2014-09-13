---
title: "README"
output: html_document
---

All the work is performed by the `run_analysis.R` script, by a simple command:
```
source('<directory>./run_analysis.R')
```

Where
---------------------------------------------------------------------------------------

- you should run it with **as working directory where the extracted 'UCI HAR Dataset' main directory is located**

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

Inputs
---------------------------------------------------------------------------------------

- none

Outputs
---------------------------------------------------------------------------------------

- tidyDataComplete variable: complete measurements data set as data frame
- tidyDataSummary variable: summary measurements data set with averages, grouped by subject and activity
- 'summary.txt' CSV file, produced in working directory, and can be read back with `read.csv('summary.txt')`


