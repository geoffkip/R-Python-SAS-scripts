##### CLUSTER ANALYSIS ####
library(cluster)
library(klaR)
library(fpc)
setwd("P:/Geoffrey/Data science")
Client_data <- read.csv("Ceo Clients.csv", stringsAsFactors = FALSE)
Client_data$Program_name <- NULL
#Factor_variables <- Client_data[, c(6:8,10:23)]
#$primary_language_other[Factor_variables$primary_language_other==''] <- NA

#Client_data[sapply(Factor_variables, is.character)] <- lapply(Client_data[sapply(Client_data, is.character)], as.factor)

#Convert variables to numeric 
numeric <- c(6:8)
Client_data[,numeric] <- lapply(Client_data[,numeric] , as.numeric)

#Convert variables to factor
character <- c(10:23)
Client_data[,character] <- lapply(Client_data[,character] , as.factor)

#drop variables
Client_data[,c(2:5, 9,24 )] <- NULL
str(Client_data)

##Do the clustering
Client_data2 <- Client_data
Client_data2$Family_Name <- NULL
cluster.results <-kmodes(na.omit(Client_data2), 4, iter.max = 10, weighted = FALSE ) 

cluster.output <- cbind(na.omit(Client_data),cluster.results$cluster)

clusplot(na.omit(Client_data2), cluster.results$cluster, color=TRUE, shade=TRUE, 
         labels=2, lines=0)