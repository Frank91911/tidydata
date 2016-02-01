## This R-script takes two data sets, merges them together
## and gives the mean of each variable by "Activity" and "Subject".

## Load neccessary packages.
library(plyr)
library(reshape2)
## Read and load data.
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
## Create merged data set.
label <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
measurment <- rbind(x_train, x_test)
## Extract the mean and Standard deviation data.
merged_dataset <- cbind(label, subject, measurment[,1:6])
colnames(merged_dataset) <- c("Activity", "Subject", "X-mean", "Y-mean", "Z-mean", "X-stdev", "Y-stdev", "Z-stdev")
merged_dataset$Activity <- invisible(revalue(as.character(merged_dataset$Activity), c("1" = "Walking", "2" = "Walking Upstairs", "3" = "Walking Downstairs", "4" = "Sitting", "5" = "Standing", "6" = "Laying Down")))
## Output mean of variables by "Activity" and "Subject".
melted <- melt(merged_dataset, id.vars=c("Activity", "Subject"))
activity_subject_mean <- ddply(melted, c("Activity", "Subject", "variable"), summarise, mean = mean(value))
## Creates text file of output.
write.table(activity_subject_mean, file = "analysis.txt", row.names = FALSE, quote = FALSE)