# File: run_analysis.R
# Main analysis script for GDC Course Project
#

# location of data = name of directory
dataset ="UCI HAR Dataset"

# read one sample set of data, whether "train" or "test"
# Output: data frame of sample data, with columns
#   subject: subject id performing activity
#   activity: activity label as factor, for the activity being performed
#   meanX, meanY, meanZ, stdX, stdY, stdZ: means and standard deviations for X, Y, Z axis, during period of each sample
# Inputs:
#   source: source set, whether "train" or "test"
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
        df = cbind(subject, activity=activity$label, df)
        df
}

# read both set of data, "train" or "test", and merge them into a single data set
# Output: data frame for train and set data, with columns
#   subject: subject id performing activity
#   activity: activity label as factor, for the activity being performed
#   meanX, meanY, meanZ, stdX, stdY, stdZ: means and standard deviations for X, Y, Z axis, during period of each sample
# Inputs:
#   n: optional, number of samples to read from each files, or -1 for all. Defaults to all

readAllSamples = function (n=-1) {
        rbind(readOneSample('train', n),
              readOneSample('test', n))
}

library(plyr)

# summarize data set along subject and activity
# Output: data frame for summary data, with columns
#   subject: subject id performing activity
#   activity: activity label as factor, for the activity being performed
#   meanX, meanY, meanZ, stdX, stdY, stdZ: mean along all samples of mean and standard deviations for X, Y, Z axis
# Input: data set to summarize

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
#   return summary data set
#   write to disk 'summary.txt' file, which can be read back with read.csv('summary.txt')
# Input: complete data set to summarize and dump

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

