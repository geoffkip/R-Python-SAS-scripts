#### SCRIPT FOR ALL STATE INSURANCE ####

#### Load Libraries ####
knitr::opts_chunk$set(echo = TRUE)
library(data.table)
library(gridExtra)
library(corrplot)
library(GGally)
library(ggplot2)
library(e1071)


#### LOAD R DATA IN ####
setwd("~/Documents/R files/All state insurance predictions")
getwd()
traindata <-  read.csv('train.csv', 
                       header=TRUE, sep="," ,
                       stringsAsFactors=FALSE)
testdata <- read.csv('test.csv' ,header=TRUE, sep="," ,
                     stringsAsFactors=FALSE)

#### Explore Data ####
str(traindata, list.len=ncol(traindata))
names(traindata)
head(traindata)

str(testdata , list.len=ncol(traindata))
names(testdata)


#### Clean data ####

#Create 0s for outcome label in test dataset 
testdata$loss=0
#combine test and train data
alldata <- rbind(traindata, testdata)

#check number of missing values 
table(is.na(alldata))

#assign all numeric variables to variable 
nums <- sapply(traindata, is.numeric)
nums_list <- names(traindata)[nums]
#nums_select <- subset(nums, nums==TRUE)
num_var <- traindata[ , nums]
cats <- sapply(traindata, is.character)
cat_var <- traindata [ ,cats]

#check for duplicates 
cat("The number of duplicated rows are", nrow(traindata) - nrow(unique(traindata)))


#descriptive statistics 
descript <- do.call(data.frame, 
               list(mean = apply(num_var, 2, mean),
                    sd = apply(num_var, 2, sd),
                    median = apply(num_var, 2, median),
                    min = apply(num_var, 2, min),
                    max = apply(num_var, 2, max),
                    n = apply(num_var, 2, length)))
descript

cor_data = cor(alldata[,nums])
cor_data <- cor_data[-1 , -1]
corrplot(cor_data, method="circle")

#create plots for continuos variables

par(mfrow=c(1,2))

plot(traindata$loss, traindata$cont1)
plot(traindata$loss, traindata$cont2)
plot(traindata$loss, traindata$cont3)
plot(traindata$loss, traindata$cont4)
plot(traindata$loss, traindata$cont5)
plot(traindata$loss, traindata$cont6)
plot(traindata$loss, traindata$cont7)
plot(traindata$loss, traindata$cont8)
plot(traindata$loss, traindata$cont9)
plot(traindata$loss, traindata$cont10)
plot(traindata$loss, traindata$cont11)
plot(traindata$loss, traindata$cont12)
plot(traindata$loss, traindata$cont13)
plot(traindata$loss, traindata$cont14)


#plot functions 
plotBox <- function(data_in, i, lab) {
  data <- data.frame(x=data_in[[i]], y=lab)
  p <- ggplot(data=data, aes(x=x, y=y)) +geom_boxplot()+ xlab(colnames(data_in)[i]) + theme_light() + 
    ylab("log(loss)") + theme(axis.text.x = element_text(angle = 90, hjust =1))
  return (p)
}

doPlots <- function(data_in, fun, ii, lab, ncol=3) {
  pp <- list()
  for (i in ii) {
    p <- fun(data_in=data_in, i=i, lab=lab)
    pp <- c(pp, list(p))
  }
  do.call("grid.arrange", c(pp, ncol=ncol))
}

plotScatter <- function(data_in, i, lab){
  data <- data.frame(x=data_in[[i]], y = lab)
  p <- ggplot(data= data, aes(x = x, y=y)) + geom_point(size=1, alpha=0.3)+ geom_smooth(method = lm) +
    xlab(paste0(colnames(data_in)[i], '\n', 'R-Squared: ', round(cor(data_in[[i]], lab, use = 'complete.obs'), 2)))+
    ylab("log(loss)") + theme_light()
  return(suppressWarnings(p))
} 

plotDen <- function(data_in, i, lab){
  data <- data.frame(x=data_in[[i]], y=lab)
  p <- ggplot(data= data) + geom_density(aes(x = x), size = 1,alpha = 1.0) +
    xlab(paste0((colnames(data_in)[i]), '\n', 'Skewness: ',round(skewness(data_in[[i]], na.rm = TRUE), 2))) +
    theme_light() 
  return(p)
}

doPlots(cat_var, fun = plotBox, ii =1:12, lab=log(traindata$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =13:24, lab=log(traindata$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =25:39, lab=log(traindata$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =40:55, lab=log(traindata$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =56:60, lab=log(traindata$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =61:75, lab=log(traindata$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =76:90, lab=log(traindata$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =91:106, lab=log(traindata$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =107:116, lab=log(traindata$loss), ncol = 3)

#density plots for continuos variables

doPlots(num_var, fun = plotDen, ii =1:6, lab=log(traindata$loss), ncol = 3)
doPlots(num_var, fun = plotDen, ii =7:14, lab=log(traindata$loss), ncol = 3)

#scatter plots

doPlots(num_var, fun = plotScatter, ii =1:6, lab=log(traindata$loss), ncol = 3)
doPlots(num_var, fun = plotScatter, ii =7:14, lab=log(traindata$loss), ncol = 3)

#time to fit the model 
library(xgboost)
set.seed= 0 

#converting character variables to numeric 
feature.names <- names(traindata)[c(2:131)]
for (i in feature.names) {
  if (class(traindata[[i]])=="character") {
    cat("VARIABLE : ",i,"\n")
    levels <- unique(c(traindata[[i]], testdata[[i]]))
    traindata[[i]] <- as.integer(factor(traindata[[i]], levels=levels))
    testdata[[i]] <- as.integer(factor(testdata[[i]],  levels=levels))
  }
}
  
#making outcome loss a log variable 
traindata$logloss <- log(traindata$loss)
traindata1 <- traindata[,feature.names]

dtrain <- xgb.DMatrix(data=data.matrix(traindata1[,]), 
                      label=traindata$log_loss)

