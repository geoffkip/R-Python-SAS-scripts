###Setting up BDT Map;
library(ggmap)
library(maps)
library(ggplot2)
library(dplyr)
library(zipcode)
library(plyr)
library(viridis)
library(maptools)
library(rgdal)


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

#get philly base map and make a bubble map
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
print(data_map2)


#prepare chloropleth map
#read shape file
philly_shp <- readOGR("/Users/geoffrey.kip/Documents/R files/BDT de-identified work/Benephilly_map/PhillyStreets_Zipcodes_Arc/PhillyStreets_Zipcodes_Arc.shp")
philly_shp@data$id <- rownames(philly_shp@data)
philly_shp.point <- fortify(philly_shp, region="id")
philly_shp.df <- inner_join(philly_shp.point,philly_shp@data, by="id")
names(philly_shp.df)
head(philly_shp.df)
philly_shp.df$zip <- as.numeric(philly_shp.df$ZIP_LEFT)
head(philly_shp.df)
ggplot(philly_shp.df, aes(long, lat, group=group )) + geom_polygon()

#prepare data
benephilly_data2 <- rename(benephilly_data2,c('clients_served'='value'))
philly_shp.df2 <- merge(philly_shp.df, benephilly_data2, by= "zip")


# ggplot mapping
# data layer
m0 <- ggplot(data=philly_shp.df2)
# empty map (only borders)
m1 <- m0 + geom_path(aes(x=long, y=lat, group=group), color='gray') + coord_equal()
m2 <- m1 + geom_polygon(aes(x=long, y=lat, group=group, fill=value))

# inverse order (to have visible borders)
m0 <- ggplot(data=philly_shp.df2)
m1 <- m0 + geom_polygon(aes(x=long, y=lat, group=group, fill=value)) + coord_equal()
m2 <- m1 + geom_path(aes(x=long, y=lat, group=group), color='black')
m2


