####time series forecasting

#load libraries 
library(data.table)
library(readr)
library(lubridate)
library(dplyr)
library(forecast)
library(reshape)
library(reshape2)

 forecast <- fread("D:/R/R data/CO_Forecast_Raw_Data.csv")
 
head(forecast)
forecast$Date <- mdy(forecast$Date)
class(forecast$Date)
forecast$date[1:20]
#forecast<- forecast[forecast$Date > '2016-01-01',]

#SPLICE DATA
forecast1 <- forecast[ which(forecast$Field=='Response Calls' 
                         & forecast$Date > '2015-01-01'), ]

forecast1$month <- month((forecast1$Date))
forecast1$year <- year(forecast1$Date)
forecast1$Date <- as.POSIXct(forecast1$Date)
class(forecast1$Date)

forecast1[,"month1"] <- ifelse(forecast1[,"month"] == 1, "JAN", 
                       ifelse(forecast1[,"month"] == 2, "FEB", 
                       ifelse(forecast1[,"month"] == 3, "MAR", 
                       ifelse(forecast1[,"month"] == 4, "APR",
                       ifelse(forecast1[,"month"] == 5, "MAY", 
                       ifelse(forecast1[,"month"] == 6, "JUN",        
                       ifelse(forecast1[,"month"] == 7, "JUL",       
                       ifelse(forecast1[,"month"] == 8, "AUG",  
                       ifelse(forecast1[,"month"] == 9, "SEP", 
                       ifelse(forecast1[,"month"] == 10, "OCT", 
                       ifelse(forecast1[,"month"] == 11, "NOV",        
                       ifelse(forecast1[,"month"] == 12, "DEC", NA))))))))))))


forecast.plot <- function(df, col = 'Value'){
  require(ggplot2)
  ggplot(df, aes_string('Date', col)) +
    geom_line() +
    ggtitle(paste('Time series of', 'Response Calls')) +
    xlab('Time')
}

forecast.plot((forecast1))

#byMon <- group_by(forecast1, month1)
# <- summarize(byMon, count=n())

forecast1$month1 <- factor(forecast1$month1, levels=c("JAN" , "FEB" ,"MAR", "APR" , "MAY", "JUN", "JUL", "AUG","SEP"
                                                      ,"OCT", "NOV", "DEC"),
                           ordered=TRUE)
str(forecast1)

forecast2 <- forecast1 %>% 
  group_by(year,month1) %>%
  summarise(Calls= sum(Value))

#forecast3 <- rbind(forecast2,data.frame("year"=2015, "month1"="JAN", "Calls"= 200))

forecast3 <- forecast2[,2:3]

forecast4 <- as.data.frame(t(forecast3[,-1]))
colnames(forecast4) <- forecast3$month1

#forecast5 <- forecast4 %>% 
  #group_by(year)


#time series
forecast_ts <- forecast1[,c(1,4)]
class(forecast_ts$Date)

temp <- ts(forecast_ts$Value)
temp
#temp_diff <- diff(temp)
#temp_diff

#check for stationarity 
acf(temp)
pacf(temp)

###significant lags die off quick so it looks stationary 


#temp1 <- decompose(temp)
plot.ts(temp)

fit.forecast = auto.arima(temp)
summary(fit.forecast)

forecast.fit = forecast(fit.forecast,h=25)
summary(forecast.fit)

plot(forecast.fit)

forecasted_values <- as.numeric(forecast.fit$mean)
forecasted_values

