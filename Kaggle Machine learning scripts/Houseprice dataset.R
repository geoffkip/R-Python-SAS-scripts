#Read in training dataset
traindata <- read.csv("~/Documents/R files/Kaggle housing regression/train.csv", row.names=1)
traindata
#explore training dataset 
str(traindata)
head(traindata)
dim(traindata)
#ensure results are repeatable 
set.seed(7)

#rank features by importance 
library(mlbench)
library(caret)
library(Boruta)
names(traindata) <- gsub("_", "", names(traindata))

#check for missing values
summary(traindata)
#Replace blank cells with NA 
traindata[traindata == ""] <- NA
# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
#train model 
model <-train(SalePrice ~ ., data=traindata , na.rm=TRUE , method="lvq" ,
              preProcess="scale", trControl=control)