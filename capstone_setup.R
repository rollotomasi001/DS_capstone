## Setup
# Call the required libraries and set the working directory.
setwd("~/R/Coursera-SwiftKey/final/en_US")
library(NLP)
library(tm)
library(RWeka)
library(ngram)
#library(wordcloud)

## Summarize the Data
#Calculate the file sizes
# fsb <- file.info("en_US.blogs.txt")$size / 1024^2
# fsn <- file.info("en_US.news.txt")$size / 1024^2
# fst <- file.info("en_US.twitter.txt")$size / 1024^2
# file_sizes <- c(fsb,fsn,fst)

# Read in the data
blogs <- readLines("en_US.blogs.txt", skipNul=TRUE)
news <- readLines("en_US.news.txt", skipNul=TRUE)
twitter <- readLines("en_US.twitter.txt", skipNul=TRUE)

# Calculate the lengths of the datasets
# lb <- length(blogs)
# ln <- length(news)
# lt <- length(twitter)
# file_lengths <- c(lb,ln,lt)

# Calculate the longest lines
# mb <- max(nchar(blogs))
# mn <- max(nchar(news))
# mt <- max(nchar(twitter))
# max_char <- c(mb,mn,mt)

# Compile a data frame summarizing the data
# frame_labels <- c('blogs','news','twitter')
# data.summary <- data.frame(frame_labels,file_sizes,file_lengths,max_char)
# data.summary


# We can further summarize the length of lines in each data source, with the mean, median, and quartiles.
# summary(nchar(blogs))
# summary(nchar(news))
# summary(nchar(twitter))

## Clean the Data
# First we will create a sample subset of the data to explore, using 500 lines per dataset. Anything more would result in memory errors in future steps.
sampleblogs <- sample(blogs,750)
samplenews <- sample(news,750)
sampletwitter <- sample(twitter,750)
sampleall <- c(sampleblogs,samplenews,sampletwitter)

# Next, we will remove non-ASCII characters.
# Convert string to vector of words
samptemp <- unlist(strsplit(sampleall, split=", "))

# Find indices of words with non-ASCII characters
nonascii <- grep("samptemp", iconv(samptemp, "latin1", "ASCII", sub="samptemp"))

# Subset original vector of words to exclude words with non-ASCII char
sampengl <- samptemp[-nonascii]

# Convert vector back to a string
sampleall <- paste(sampengl, collapse = ", ")

# To further clean the data, we will remove profanity, stop words, numbers, punctuation, white space, and set to lowercase.

# samplecon <- Corpus(VectorSource(sampleall))
# profane <- readLines("profanity.txt")
# samplecon <- tm_map(samplecon, removeWords, profane)
# samplecon <- tm_map(samplecon, removeNumbers)
# samplecon <- tm_map(samplecon, removePunctuation)
# samplecon <- tm_map(samplecon, removeWords, stopwords("english"))
# samplecon <- tm_map(samplecon, stripWhitespace)
# samplecon <- tm_map(samplecon, content_transformer(tolower))

## Explore the Data
# Finally, we will explore the data to observe the most frequent words. We will explore n-grams and tokenization in the near future.
# Create a document-term matrix
# dtm <- DocumentTermMatrix(samplecon)
# dtm2 <- as.matrix(dtm)

# Calculate the highest frequency words
# frequency <- colSums(dtm2)
# frequency <- sort(frequency,decreasing=TRUE)
# head(frequency)

# Create a Word Cloud to display the most frequent words
# words <- names(frequency)
# wordcloud(words[1:100],frequency[1:100])


samplepro <- preprocess(sampleall, case = "lower", remove.punct = TRUE, 
                        remove.numbers = TRUE, fix.spacing = TRUE)
samp_ng <- ngram_asweka(samplepro, min=2, max=5)
write.csv(samp_ng, 'news_ngrams.csv', row.names=FALSE)
