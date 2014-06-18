# Read the data
data1 <- read.table("train/X_train.txt")
data2 <- read.table("test/X_test.txt")
dataX <- rbind(data1, data2)

data1 <- read.table("train/subject_train.txt")
data2 <- read.table("test/subject_test.txt")
dataS <- rbind(data1, data2)

data1 <- read.table("train/y_train.txt")
data2 <- read.table("test/y_test.txt")
dataY <- rbind(data1, data2)

# Extract needed data
features <- read.table("features.txt")
tmp <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
dataX <- dataX[ , tmp]
names(dataX) <- features[tmp, 2]
names(dataX) <- tolower(gsub("\\(|\\)", "", names(dataX)))
names(dataX) <- gsub("-", ".", names(dataX))

# Merge and rename columns
act <- read.table("activity_labels.txt")
act$V2 = gsub("_", "", tolower(as.character(act$V2)))
dataY$V1 = act[dataY$V1, 2]
names(dataY) <- "activity"
names(dataS) <- "subject"
data <- cbind(dataS, dataY, dataX)

# Save output
write.table(data, "output1.txt")
data_tidy <- aggregate(data, by = list(factor(data$subject), factor(data$activity)), mean, na.rm = T)
write.table(data_tidy, "output2.txt")
