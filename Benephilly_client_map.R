###Setting up BDT Map;
library(ggmap)
library(maps)
library(ggplot2)
library(dplyr)
library(zipcode)

states <- map_data("state")
counties <- map_data("county")

data(zipcode)
zipcode$zip <- as.numeric(zipcode$zip)

setwd("~/Documents/R files/BDT de-identified work/Benephilly_map")

benephilly_data <- read.csv("map_data.csv")
benephilly_data <- na.omit(benephilly_data)
benephilly_data$Zip <- as.numeric(benephilly_data$Zip)
str(benephilly_data)


ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)  # do this to leave off the color legend'

Pennsylvania <- subset(counties, region %in% c("pennsylvania"))
Philadelphia <- subset(Pennsylvania, subregion =="philadelphia")


philly_base <- ggplot(data = Philadelphia, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")
philly_base + theme_nothing()


