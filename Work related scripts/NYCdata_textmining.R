setwd("D:/R/R data")
getwd()

####install all packages ####
library(data.table)
library(tm)
library(readr)
library(slam)
library(SnowballC)


####load data ####
textdata <- fread("D:/R/R data/NYCdatainquiry.csv")
str(textdata)
names(textdata)
textdata1 <- textdata[, c("inquiryID" , "Inquiry_Name","Brief_Description" , "call_date")]
head(textdata1)
textdata2 <- as.data.frame(textdata1)
textdata2 <- textdata2[1:10000, ]

#turn into corpus vector 
text <- Corpus(VectorSource(textdata2['Inquiry_Name']))
class(text)
text <- tm_map(text, content_transformer(removeNumbers))
text <- tm_map(text, content_transformer(removePunctuation))
text <- tm_map(text, content_transformer(stripWhitespace))
text <- tm_map(text, content_transformer(tolower))

stopwords <- read_csv("D:/R/R data/stopwords.csv")
stopwords = unique(stopwords)
stopwords[1:100,]
stopwords <- as.data.frame(stopwords)

text <- tm_map(text, removeWords, stopwords[, 'words'])


#STEM DOCUMENTS 
text <- tm_map(text, stemDocument)


to.WF = function(corpus){
  require(tm)
  ## Compute a term-document matrix and then 
  ## compute the word frequencies.
  library(slam)
  tdm <- TermDocumentMatrix(corpus, control = list(stopwords = FALSE))
  tdm <- removeSparseTerms(tdm, 0.9999999)
  freq <- row_sums(tdm, na.rm = T)   
  ## Sort the word frequency and build a dataframe
  ## including the cumulative frequecy of the words.
  freq <- sort(freq, decreasing = TRUE)
  word.freq <- data.frame(word = factor(names(freq), levels = names(freq)), 
                          freq = freq)
  word.freq['Cum'] <- cumsum(word.freq['freq'])/sum(word.freq$freq)
  word.freq
}

wf = to.WF(text)
head(wf, n = 20)


bar.TDF = function(word.freq){
  library(ggplot2)
  #dev.new(width=12, height=9)
  ggplot(word.freq[1:40,], aes(word, freq)) +
    geom_bar(stat = 'identity') +
    ggtitle('Frequency of most common words') +
    ylab('Frequency') +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}
bar.TDF(wf)
