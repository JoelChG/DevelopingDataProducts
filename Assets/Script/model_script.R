# Importing libraries
library(randomForest)
library(caret)

workingDirectory <- "C:/Users/chave/Desktop/DDP-FinalProject/"
assetsDirectory <- paste(workingDirectory, "Assets", sep = "/")
outputDir <- paste(assetsDirectory, "OutputFiles", sep = "/")
setwd(workingDirectory)

# Importing the data set
data <- read.csv(paste(workingDirectory, 
                       "Assets/Dataset/diabetes_data.csv", 
                       sep = "/"), 
                 header = TRUE)

# Changing variables 2-17 to factors
factor_vars <- c(2:17)
data[, factor_vars] <- lapply(data[, factor_vars], as.factor)


# Creating data partitions for training and testing sets
set.seed(4826)
TrainingIndex <- createDataPartition(data$class, p=0.8, list = FALSE)
TrainingSet <- data[TrainingIndex,] # Training Set
TestingSet <- data[-TrainingIndex,] # Test Set

TrainingSet <- TrainingSet

# Writing the training and testing data sets for reproducibility
write.csv(TrainingSet, paste(outputDir, "training.csv", sep = "/"),
          row.names = FALSE)
write.csv(TestingSet, paste(outputDir, "testing.csv", sep = "/"),
          row.names = FALSE)

# Creating Random forest model
model <- randomForest(class ~ ., data = TrainingSet,
                      ntree = 500,
                      mtry = 4,
                      importance = TRUE)

# Evaluating the model
rf_pred <- predict(model, newdata = TestingSet)
confusionMat <- confusionMatrix(TestingSet$class, rf_pred,
                                positive = "Positive")

# Saving model to RDS file
saveRDS(model, paste(outputDir, "model.rds", sep = "/"))

# Saving confusion matrix
saveRDS(confusionMat, paste(outputDir, "confusionMatrix.rds", sep = "/"))





