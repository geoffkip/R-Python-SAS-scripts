#### Housing Regression Script
library(dplyr)
library(ggplot2)
library(Amelia)
library(mice)
library(lattice)

##Script to show the method of imputation for missing variables
#set working directory 
setwd("~/Dropbox/House Regression Kaggle data")

#load training  and test dataset
train_data <- read.csv("train.csv")
train_data$Id <- NULL
#Set train target
train_target <- train_data$SalePrice
train_data[,80] <- NULL 

test_data <- read.csv("test.csv")
test_data$Id <-NULL 

combined_data <- rbind(train_data, test_data)

#Explore combined dataset
head(combined_data)
str(combined_data)

#find number of rows with missing data
Missing <- sapply(combined_data, function(x) sum(is.na(x))); Missing[Missing>0]
Missing1 <- Missing[Missing>0]
summary(combined_data[,names(Missing1)])
str(combined_data[,names(Missing1)])
#impute missing variables
combined_data$LotFrontage <- ifelse(is.na(combined_data$LotFrontage), 
                                 mean(combined_data$LotFrontage, na.rm = TRUE), 
                                 combined_data$LotFrontage)

combined_data$MasVnrArea <- ifelse (is.na(combined_data$MasVnrArea), 
                                 mean(combined_data$MasVnrArea,na.rm=TRUE),
                                 combined_data$MasVnrArea)

combined_data$GarageYrBlt[is.na(combined_data$GarageYrBlt)] <- 1980

var_NAtoWithout<-c("Alley","BsmtQual","BsmtCond","BsmtExposure",
"BsmtFinType1","BsmtFinType2","FireplaceQu","GarageType","GarageFinish",
"GarageQual","GarageCond","PoolQC","Fence","MiscFeature")

## impute NA to without

without<-function(data,var){
  levels(data[,var]) <- c(levels(data[,var]), "without")
  data[,var][is.na(data[,var])] <- "without"
  return(data[,var])
}

for (i in 1:length(var_NAtoWithout)){
  combined_data[,var_NAtoWithout[i]]<-without(combined_data,var_NAtoWithout[i]) 
}

#Plot missing variables
## Plot NA pattern 
missmap(combined_data, col=c('Red', 'Green'), y.cex=0.2, x.cex=0.8,main = "After Imputation")

#Use the Mice package to imput the rest of the missing variables
data_imp<-mice(combined_data, m=1, method='cart', printFlag=FALSE)
data_imputed<-complete(data_imp, action = 1, include = FALSE)

#Check imputation via following plots
xyplot(data_imp, LotFrontage ~ LotArea,main="Check Imputation Result")
xyplot(data_imp,MasVnrArea ~ MasVnrType,main="Check Imputation Result")

missmap(data_imputed, col=c('Red', 'Green'), y.cex=0.2, x.cex=0.8,main = "No missing")

