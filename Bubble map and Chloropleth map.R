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
library(foreign)
library(classInt)
library(scales)


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
  ggtitle("Client Served")
data_map2<- data_map + scale_size(breaks = (c(0, 50, 100, 150, 200, 250)), labels = c(0, 50, 100, 150, 200, 250), name = "Clients Served")
print(data_map2)


#prepare chloropleth map
#read shape file
philly_shp <- readOGR("/Users/geoffrey.kip/Documents/R files/BDT de-identified work/Benephilly_map/data/Zipcodes_Poly.shp")
philly_shp@data$id <- rownames(philly_shp@data)
philly_shp.point <- fortify(philly_shp, region="id")
philly_shp.df <- inner_join(philly_shp.point,philly_shp@data, by="id")
names(philly_shp.df)
head(philly_shp.df)
ggplot(philly_shp.df, aes(long, lat, group=group )) + geom_polygon()

#dbfdata <- read.dbf("Zipcodes_Poly.dbf", as.is = TRUE)

#zips <- read.csv("Zipcodes_Poly.csv")
#write.dbf(zips, "Zipcodes_Poly.dbf", factor2char = TRUE, max_nchar = 254)
#philly_shp.df2 <- merge(philly_shp.df, zips, by="id")
#philly_shp.df[,1:2] <- round(philly_shp.df[,1:2],2)
#benephilly_data2[,5:6] <- round(benephilly_data2[,5:6],2)
#prepare data
#benephilly_data2 <- rename(benephilly_data2,c('clients_served'='value', 'longitude'= 'long' , 'latitude'= 'lat'))
#philly_shp.df3 <- merge(philly_shp.df2, benephilly_data2, by=c("zip"))


# ggplot mapping
# data layer
m0 <- ggplot(data=philly_shp.df)
# empty map (only borders)
m1 <- m0 + geom_path(aes(x=long, y=lat, group=group), color='gray') + coord_equal()
m1b <- m1  + geom_point(aes(x = long, y = lat, size = value), 
                         data = benephilly_data2, alpha = .5, pch=21, fill="red")


m2 <- m1 + geom_polygon(aes(x=long, y=lat, group=group, fill=CLIENTS_SE))

# inverse order (to have visible borders)
m0 <- ggplot(data=philly_shp.df)
m1 <- m0 + geom_polygon(aes(x=long, y=lat, group=group, fill=CLIENTS_SE)) + coord_equal()
m2 <- m1 + geom_path(aes(x=long, y=lat, group=group), color='black')
m2


#make breaks for Chloropleth map
philly_shp.df$CLIENTS_SE <- as.numeric(levels(philly_shp.df$CLIENTS_SE))[philly_shp.df$CLIENTS_SE]
#natural.interval= classIntervals(philly_shp.df$CLIENTS_SE, n=5, style='jenks')$brks

#labels
philly_shp.df2 <-philly_shp.df[,c(1,2,9)]
philly_shp.df2 <- subset(philly_shp.df2, !duplicated(philly_shp.df2$CODE))

benephilly_data2b <-benephilly_data2[! benephilly_data2$zip %in% c(19105,19193, 19102),]

#simple beginnings
ggplot() +
  geom_polygon(data = philly_shp.df, 
               aes(x = long, y = lat, group = group, fill = CLIENTS_SE), 
               color = "black", size = 0.25) + 
  coord_map()+
  scale_fill_distiller(name="Clients Served", palette = "YlGn", breaks = pretty_breaks(n = 6))+
  theme_nothing(legend = TRUE)+
  geom_text(data=benephilly_data2b, aes(longitude,latitude,label=zip), color="grey",
            size=2,fontface="bold")+
  labs(title="Clients Served by Zipcode")

##better map
#ggplot() +
 #geom_polygon(data = philly_shp.df, 
  #             aes(x = long, y = lat, group = group, fill = order(CLIENTS_SE)), 
   #            color = "black", size = 0.25) + 
  #coord_map()+
  #scale_color_gradient2(low="green", mid="red",high="blue", midpoint=150,
  #                      breaks=c(50,100,150,200,250,300), labels=c(50,100,150,200,250,300)) +
  #theme(text=element_text(size=15))

  #theme_nothing(legend = TRUE)+
  #labs(title="Clients Served by Zipcode")
