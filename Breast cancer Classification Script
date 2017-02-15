#### breast clancer classification script ####
library(data.table)
library(caret)
library(rpart)
library(rpart.plot)
library(dplyr)
setwd("~/R scripts")

cancer_data <- read.csv("breast_cancer.csv")
str(cancer_data)
summary(cancer_data)
#code malignant as 1 and benign as 0
cancer_data$diagnosis2 <- ifelse(cancer_data$diagnosis == "M", 1, 0)
cancer_data$X <- NULL
cancer_data$id <- NULL
cancer_data$diagnosis <- NULL
names(cancer_data)

colnames(cancer_data) = gsub(" ", "_", colnames(cancer_data)) 
##for some reason glm does not like spaces in the column names
glm(diagnosis2 ~., data = cancer_data) %>% summary()

cancer_data$diagnosis2 <- as.factor(cancer_data$diagnosis2)

idx <- sample(seq(1, 2), size = nrow(cancer_data), replace = TRUE, prob = c(.7, .3))
train_data <- cancer_data[idx == 1,]
test_data <- cancer_data[idx == 2,]

require(randomForest)

RF_model <- randomForest(diagnosis2 ~ . , data=cancer_data)
varImpPlot(RF_model)

fit <- randomForest(diagnosis2 ~ . , data=train_data)
pred.response <- predict(fit, newdata=train_data, type="class")
actual.response <-train_data$diagnosis2
confusionMatrix(pred.response,actual.response)


pred.response1 <- predict(fit, newdata=test_data,type="class")
actual.response1 <-test_data$diagnosis2

confusionMatrix(pred.response1,actual.response1)

