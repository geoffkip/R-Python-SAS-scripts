#script ml

#### 0. librerias ####
rm(list=ls())
library(rpart)
library(rpart.plot)

#### 1. read file ####
data.table <- read.csv('CO Final Data Merged Primary only.csv',header=TRUE)
summary(data.table)

#### 2. pre-tratment ####
data.table$target <- (data.table$BENEFIT > 0)+0

date.field.names <- c("mail_date1st",
                      "mail_date2nd","mail_date" ,
                      "second_agreed_at" , "completed_at",                    
                      "submitted_at" , "closed_at",
                      "force_submit_at"  , "submitted_at1",
                      "submitted_at2" ,"STATUS_DATE")

for (name in date.field.names) {
  print(name)
  data.table[,name] <- as.Date(data.table[,name] , format = "%d %b %Y")
}


data.table$time1 <- strptime(data.table[,"created_time"], 
                             format="%H:%M")
data.table$time2 <- strptime(data.table[,"completed_time"], 
                             format="%H:%M")
data.table$time3 <- strptime(data.table[,"submitted_time"], 
                             format="%H:%M")

data.table$target[is.na(data.table$target)] <- 0 

data.table$RSN_DESC <- substr(data.table$RSN_DESC,1,12)

names(data.table)
data.table.2 <- data.table[,c(2:14,18:23,
                              25,29:63,65:66,68:76,79:82,84:85,89:90,107)]

fit <- rpart(target ~.,data=data.table.2)
rpart.plot(fit)
names(data.table)