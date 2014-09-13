# File: run_analysis.R
# Main analysis script for GDC Course Project
#

dataset ="UCI HAR Dataset"

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

readAllSamples = function (n=-1) {
        rbind(readOneSample('train', n),
              readOneSample('test', n))
}

library(plyr)

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

dumpSummaryFile = function (df) {
        summary = summarize(df)
        write.table(summary, file='summary.txt', row.names=F, col.names=T, sep=',')
}

