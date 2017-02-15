library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
library(shinythemes)

#global

colorado_data <- read.csv("D:/R/R data/Colorado_data_shiny_app.csv", stringsAsFactors = FALSE)
colorado_data1 <- na.omit(colorado_data)
colorado_data1$submitted_at <- mdy(colorado_data1$submitted_at)


colorado_data2<- colorado_data1 %>%
  mutate(month = format(submitted_at, "%m"), year = format(submitted_at, "%Y")) %>%
  group_by(month, year, county, request) %>%
  summarise(applicants = sum(applicants))

colorado_data2 <- na.omit(colorado_data2)



#colorado_data2 <- colorado_data1 %>% 
  #group_by(county, submitted_at) %>%
  #summarise(Applications= sum(applicants))

#colorado_data2$submitted_at <- paste(month(colorado_data2$submitted_at), "/" , year(colorado_data2$submitted_at))

#colorado_data2$submitted_at <- as.Date(colorado_data1$submitted_at,"%m/%Y")
