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
train_1 <-  read.csv('train.csv', 
                       header=TRUE, sep="," ,
                       stringsAsFactors=FALSE)
test <- read.csv('test.csv' ,header=TRUE, sep="," ,
                     stringsAsFactors=FALSE)

#### Explore Data ####
str(train_1, list.len=ncol(train_1))
names(train_1)
head(train_1)

str(test , list.len=ncol(train_1))
names(test)


#### Clean data ####

#Create 0s for outcome label in test dataset 
test$loss=0
#combine test and train data
alldata <- rbind(train_1, test)

#check number of missing values 
table(is.na(alldata))

#assign all numeric variables to variable 
nums <- sapply(train_1, is.numeric)
nums_list <- names(train_1)[nums]
#nums_select <- subset(nums, nums==TRUE)
num_var <- train_1[ , nums]
cats <- sapply(train_1, is.character)
cat_var <- train_1 [ ,cats]

#check for duplicates 
cat("The number of duplicated rows are", nrow(train_1) - nrow(unique(train_1)))


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

plot(train_1$loss, train_1$cont1)
plot(train_1$loss, train_1$cont2)
plot(train_1$loss, train_1$cont3)
plot(train_1$loss, train_1$cont4)
plot(train_1$loss, train_1$cont5)
plot(train_1$loss, train_1$cont6)
plot(train_1$loss, train_1$cont7)
plot(train_1$loss, train_1$cont8)
plot(train_1$loss, train_1$cont9)
plot(train_1$loss, train_1$cont10)
plot(train_1$loss, train_1$cont11)
plot(train_1$loss, train_1$cont12)
plot(train_1$loss, train_1$cont13)
plot(train_1$loss, train_1$cont14)


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

doPlots(cat_var, fun = plotBox, ii =1:12, lab=log(train_1$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =13:24, lab=log(train_1$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =25:39, lab=log(train_1$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =40:55, lab=log(train_1$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =56:60, lab=log(train_1$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =61:75, lab=log(train_1$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =76:90, lab=log(train_1$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =91:106, lab=log(train_1$loss), ncol = 3)
doPlots(cat_var, fun = plotBox, ii =107:116, lab=log(train_1$loss), ncol = 3)

#density plots for continuos variables

doPlots(num_var, fun = plotDen, ii =1:6, lab=log(train_1$loss), ncol = 3)
doPlots(num_var, fun = plotDen, ii =7:14, lab=log(train_1$loss), ncol = 3)

#scatter plots

doPlots(num_var, fun = plotScatter, ii =1:6, lab=log(train_1$loss), ncol = 3)
doPlots(num_var, fun = plotScatter, ii =7:14, lab=log(train_1$loss), ncol = 3)

#time to fit the model 
library(xgboost)
set.seed= 0 

#converting character variables to numeric 
feature.names <- names(train_1)[c(2:131)]

for (f in feature.names) {
  if (class(train_1[[f]])=="character") {
    cat("VARIABLE : ",f,"\n")
    levels <- unique(c(train_1[[f]], test[[f]]))
    train_1[[f]] <- as.integer(factor(train_1[[f]], levels=levels))
    test[[f]] <- as.integer(factor(test[[f]],  levels=levels))
  }
}

#converting Response to Log

train_1$log_loss <- log(train_1$loss)

tra1 <- train_1[,feature.names]

dtrain <- xgb.DMatrix(data = data.matrix(tra1[,]),
                      label = train_1$log_loss)

watchlist <- list(train = dtrain)

evalerror <- function(preds, dtrain) {
  labels <- getinfo(dtrain, "label")
  err <- as.numeric(sum(abs(labels - preds)))/length(labels)
  return(list(metric = "mae error", value = err))
}

param <- list(  objective = "reg:linear",
                booster = "gbtree",
                eval_metric = evalerror,
                eta = 0.01,
                max_depth = 8,
                subsample = 0.8,
                colsample_bytree = 0.8,
                min_child_weight = 25
)

clf <- xgb.train(   params = param,
                    data = dtrain,
                    nrounds = 500,
                    verbose = 2,
                    watchlist = watchlist,
                    maximize = FALSE
)

test1 <- test[,feature.names]
dim(test)

pred1 <- exp(predict(clf, data.matrix(test1)))
submission <- data.frame(id=test$id, loss=pred1)
cat("saving the submission file\n")
write_csv(submission, "XgBoost_Run_DS.csv")

