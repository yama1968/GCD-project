# File: run_analysis.R
# Main analysis script for GDC Course Project
#

# location of data = name of directory
dataset ="UCI HAR Dataset"

# read one sample set of measurements, whether "train" or "test"
# Output: data frame of measurement data, with columns
#   subject: subject id (as numeric) performing activity being performed
#   activity: activity label (as factor), for the activity being performed
#   meanX, meanY, meanZ, stdX, stdY, stdZ (as numeric): means and standard deviations for X, Y, Z axis, for each measurement
# Inputs:
#   source: source set, whether "train" or "test" as character string
#   n: optional, number of samples to read from files, or -1 for all. Defaults to all

readOneSample = function (source, n=-1) {
        df = read.fwf(paste(dataset, '/', source,'/X_', source, '.txt', sep=''),
                      widths = c(17, rep(16,5)),
                      col.names = c('meanX', 'meanY', 'meanZ', 'stdX', 'stdY', 'stdZ'),
                      n = n)
        subject = read.table(paste(dataset, '/', source, '/subject_', source, '.txt', sep=''),
                             col.names = 'subject',
                             nrows = n)
        activity_labels = read.table(paste(dataset, '/activity_labels.txt', sep=''),
                                     col.names = c('actId', 'actLabel'),
                                     sep = ' ')
        activity = read.table(paste(dataset, '/', source, '/y_', source, '.txt', sep=''),
                              col.names = 'activity',
                              nrows = n)
        activity$label = factor(activity$activity,
                                levels = activity_labels$actId,
                                labels = activity_labels$actLabel)
        df = cbind(subject=subject$subject, activity=activity$label, df)
        df
}

# read both set of measurement data, "train" or "test", and merge them into a single data set
# Output: measurements data frame for train and set data, with columns
#   subject: subject id being measured
#   activity: activity label as factor, for the activity being performed during measurement
#   meanX, meanY, meanZ, stdX, stdY, stdZ: means and standard deviations for X, Y, Z axis, for each measurement
# Inputs:
#   n: optional, number of samples to read from each file, or -1 for all. Defaults to all

readAllSamples = function (n=-1) {
        rbind(readOneSample('train', n),
              readOneSample('test', n))
}

library(plyr)

# summarize measurement data set along subject and activity
# Output: data frame for summary measurement data, with columns
#   subject: subject id performing activity
#   activity: activity label as factor, for the activity being performed
#   meanX, meanY, meanZ, stdX, stdY, stdZ: mean across all measurements of mean and standard deviations for X, Y, Z axis
# Input: measurement data set to summarize

summarize = function (df) {
        ddply(df, .(subject, activity),
              summarise,
              meanX=mean(meanX),
              meanY=mean(meanY),
              meanZ=mean(meanZ),
              stdX=mean(stdX),
              stdY=mean(stdY),
              stdZ=mean(stdZ))
}

# compute and dump summary data set into csv summary file
# Output:
#   return summary of measurement data set
#   write to disk 'summary.txt' file, which can be read back with read.csv('summary.txt')
# Input: complete measurement data set to summarize and dump

dumpSummaryFile = function (df) {
        summary = summarize(df)
        write.table(summary, file='summary.txt', row.names=F, col.names=T, sep=',')
        summary
}


# Main work requested for project:

# Steps 1, 2, 3, 4:
tidyDataComplete = readAllSamples()
# Step 5:
tidyDataSummary = dumpSummaryFile(tidyDataComplete)

