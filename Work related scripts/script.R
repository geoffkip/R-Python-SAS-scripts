#### SCRIPT #####

#### 0. libraries ####
library(rpart)
library(rpart.plot)
library(caret)

#### 1. load data ####

data.response<-read.csv("SNAP_Workflow_AllProjects.csv")
date.columns <- c("created_at", "completed_at","submitted_at", "doc_request_date" , "resp_fu_date",
                  "nonresp_fu_date", "submit_confirm_date" , "resp1_date", "resp2_date" , "resp3_date",
                  "resp4_date"  , "resp5_date","resp6_date","agreed_at", "second_agreed_at")

for ( colum in date.columns) {
  print(colum)
  data.response[,colum] <- as.Date(data.response[,colum],"%m/%d/%y")
}

#### 2. #### 
data.response2 <- data.response[,-c(2,3,6,8,9,10,11)]
data.response2$dif1 <- as.numeric(data.response2$submit_confirm_date-data.response2$doc_request_date)
data.response2$dif2 <- as.numeric(data.response2$submitted_at-data.response2$resp1_date)
data.response2$target <- as.factor(data.response2$target)

#### 3. ####
set.seed(88)
test.split <- 0.3
train.id <- sample(c(TRUE,FALSE),prob=c(1-test.split,test.split),size=nrow(data.response2),
       replace =TRUE)

train.data <-data.response2[train.id,]
test.data <-data.response2[!train.id,]


#### 3. ####
fit <- rpart(target~.,data=train.data)
pred.response <- predict(fit, newdata=train.data,type="class")
actual.response <-train.data$target

confusionMatrix(pred.response,actual.response)

###
pred.response <- predict(fit, newdata=test.data,type="class")
actual.response <-test.data$target

confusionMatrix(pred.response,actual.response)

#### visualize decision tree ####
rpart.plot(fit)
