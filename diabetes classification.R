#### diabetes classification script ####
library(data.table)
library(caret)
library(rpart)
library(rpart.plot)
setwd("~/R scripts")

diabetes_data <- fread("diabetes.csv",nrows=-1)
diabetes_data$Outcome <- as.factor(diabetes_data$Outcome)
set.seed(100)
trainIndex <- createDataPartition(diabetes_data$Outcome, p = .7, list = FALSE, times = 1)
traindata <- diabetes_data[trainIndex]
testdata <- diabetes_data[-trainIndex]

fit <- rpart(Outcome~.,data=traindata)
pred.response <- predict(fit, newdata=traindata, type="class")
actual.response <-traindata$Outcome

confusionMatrix(pred.response,actual.response)

#train model with test data

###
pred.response1 <- predict(fit, newdata=testdata,type="class")
actual.response1 <-testdata$Outcome

confusionMatrix(pred.response1,actual.response1)

#### visualize decision tree ####
rpart.plot(fit)

