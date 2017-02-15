#####Machine learning classifier 
#load libraries
library(randomForest)
library(caret)
library(e1071)
library(rpart)
library(rpart.plot)
library(ipred)
library(mlbench)

setwd("P:/Geoffrey/Data science")
data <- read.csv("Machine_learning_data.csv", stringsAsFactors = FALSE)
data$screening_age_groups <- NULL
data$county <- NULL
str(data)

#Convert variables to factor
character <- c(1:2,25:29,31)
data[,character] <- lapply(data[,character] , as.factor)
str(data)

#split data into train and test datasets

## 70% of the sample size
smp_size <- floor(0.70 * nrow(data))
set.seed(123)
train_ind <- sample(seq_len(nrow(data)), size = smp_size)

train <- data[train_ind, ]
#train <- train[1:60000,]
test <- data[-train_ind, ]
#test  <- test[1:20000,]

## set the seed to make your partition reproductible

#lets try with Rpart decision trees

rpart.fit <- rpart(submitted ~ . , method="class" ,data=train)
rpart.plot(rpart.fit)

predict2 <- predict(rpart.fit,test, type="class")

confusionMatrix(predict2, test$submitted)

#Accuracy=0.9903

#Random Forest model
modelFit= randomForest(submitted ~ . ,data=train)
varImp(modelFit)
varImpPlot(modelFit)


prediction=predict(modelFit, test)

confusionMatrix(prediction, test$submitted)

Output <- cbind(as.data.frame(prediction), test$submitted)

subset <- subset (Output, prediction != test$submitted)

#accuracy=0.9955

#Compare different machine learning algorithms

# prepare training scheme

control <- trainControl(method="repeatedcv", number=10, repeats=3)
# CART
set.seed(7)
fit.cart <- train(submitted~., data=train, method="rpart", trControl=control)
# LDA
set.seed(7)
fit.lda <- train(submitted~., data=train, method="lda", trControl=control)
# SVM
set.seed(7)
fit.svm <- train(submitted~., data=train, method="svmRadial", trControl=control)
# kNN
set.seed(7)
fit.knn <- train(submitted~., data=train, method="knn", trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(submitted~., data=train, method="rf", trControl=control)
# collect resamples
results <- resamples(list(CART=fit.cart, LDA=fit.lda, SVM=fit.svm, KNN=fit.knn, RF=fit.rf))



#bagging algorithms building an ensemble bagging method

# Example of Bagging algorithms
control <- trainControl(method="repeatedcv", number=10, repeats=3)
seed <- 7
metric <- "Accuracy"
# Bagged CART
set.seed(seed)
fit.treebag <- train(submitted~., data=data, method="treebag", metric=metric, trControl=control)
# Random Forest
set.seed(seed)
fit.rf <- train(Class~., data=dataset, method="rf", metric=metric, trControl=control)
# summarize results
bagging_results <- resamples(list(treebag=fit.treebag, rf=fit.rf))
summary(bagging_results)
dotplot(bagging_results)

