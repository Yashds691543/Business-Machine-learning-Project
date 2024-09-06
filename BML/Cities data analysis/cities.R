#Q1
library(tm)
library(SnowballC)

path <- "/Users/yashds/Downloads/BML2/HW6/comments.txt" 
data <- readLines(path)
Comments_Text <- unlist(strsplit(data, "\n"))
comments_corpus <- Corpus(VectorSource(Comments_Text))


comments_corpus <- tm_map(comments_corpus, content_transformer(tolower))
comments_corpus <- tm_map(comments_corpus, removePunctuation) 
comments_corpus <- tm_map(comments_corpus, removeNumbers)  
comments_corpus <- tm_map(comments_corpus, removeWords, stopwords("english"))  
comments_corpus <- tm_map(comments_corpus, stripWhitespace) 
comments_corpus <- tm_map(comments_corpus, stemDocument)  


dtm <- DocumentTermMatrix(comments_corpus)
dtm
tdm <- TermDocumentMatrix(comments_corpus)
tdm


#Q2
library(topicmodels)
lda_model <- LDA(dtm, k = 4) 
n_terms <- terms(lda_model, 5) 
print(n_terms)

#Q3
library(SentimentAnalysis)
sent_words<-analyzeSentiment(tdm)
sent_words

#Q4
library(udpipe)
library(word2vec)
model_bow <- word2vec(x = Comments_Text, type = "cbow", dim = 20, iter = 20)
similar_terms <- predict(model_bow, newdata = c("guest", "host"), type = "nearest", top_n = 5)
print(similar_terms)

#Q5
model_skipgr <- word2vec(x = Comments_Text, type = "skip-gram", dim = 20, iter = 20)
similar_terms_skpgr <- predict(model_skipgr, newdata = c("airbnb", "help"), type = "nearest", top_n = 5)
similar_terms_skpgr
