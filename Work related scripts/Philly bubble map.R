###Setting up BDT Map;
library(ggmap)
library(maps)
library(ggplot2)
library(dplyr)
library(zipcode)
library(plyr)
library(viridis)

setwd("~/Documents/R files/BDT de-identified work/Benephilly_map/data")

data(zipcode)
zipcode$zip <- as.numeric(zipcode$zip)
str(zipcode)

benephilly_data <- read.csv("map_data.csv")
benephilly_data <- na.omit(benephilly_data)
benephilly_data$Zip <- as.numeric(benephilly_data$Zip)
str(benephilly_data)
colnames(benephilly_data) <- c("zip" ,"clients_served")
benephilly_data$zip <-clean.zipcodes(benephilly_data$zip)
benephilly_data2<- merge(benephilly_data, zipcode, by='zip')
head(benephilly_data2)

#get philly base map
philly <- get_map(location = "philadelphia", zoom=11, crop=T, scale="auto" ,
                  color="color" , maptype="terrain")

philly_map<- ggmap(philly, extent="panel" , padding=0)
philly_map

data_map <- philly_map + geom_point(data=benephilly_data2, aes(x=longitude, y=latitude)
                        ,size=benephilly_data2$clients_served, pch=21, fill="red")+ ggtitle("Client Locations")

data_map <- philly_map + geom_point(aes(x = longitude, y = latitude, size = clients_served), 
                                    data = benephilly_data2, alpha = .5, pch=21, fill="red") +
                        ggtitle("Client Locations")
data_map2<- data_map + scale_size(breaks = (c(0, 50, 100, 150, 200, 250)), labels = c(0, 50, 100, 150, 200, 250), name = "Clients Served")
print(Legend)

