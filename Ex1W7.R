#install.packages("SnowballC")
library("SnowballC")
words <- c("Learning", "Learned", "Learn", "Learning")
stemmedWords <- wordStem(words)
print(stemmedWords)

#install.packages("SnowballC")
library("SnowballC")
words <- c("Learning", "Learned", "Learn", "Learning")
stemmedWords <- wordStem(words)
print(stemmedWords)

#install.packages("textstem")
library("textstem")
lemmatize_words(c("trouble","troubled","troublesome","troubles"))

install.packages("tm")
library("tm")
stopwords("en")

someText <- c("I love programming and specifically data science because of 
the statistics and ML")
filteredText <- removeWords(someText, stopwords("en"))
filteredText

#Document Term Matrix
txt <- c("I liked this programming course and liked the lectures", "The course and 
lectures are useful as a primer for programming", "I liked the programming aspects 
of the course")
txtCorpus <- VCorpus(VectorSource(txt))
docTermMat <- DocumentTermMatrix(txtCorpus)
inspect(docTermMat)

#barplot of term frequencies
wordFreq <- colSums(as.matrix(docTermMat))
txt <- wordFreq[ order(wordFreq, decreasing = TRUE) ]
barplot(txt)

#Create a Word cloud
install.packages("wordcloud")
library("wordcloud")
wordcloud(words=labels(wordFreq), freq=wordFreq, min.freq = 1)
?Wordcloud

#Discover term associations
findAssocs(docTermMat, "lectures", 0.4)

#Create a tf-idf Matrix and study the results
tf <- DocumentTermMatrix(txtCorpus)
tfIdf <- weightTfIdf(tf, normalize = FALSE)
inspect(tfIdf)

#Try some basic topic modelling
install.packages("topicmodels")
library("topicmodels")
data("AssociatedPress")
topicModelling <- LDA(AssociatedPress, k=4)
terms(topicModelling, 10)

#Sentiment of text
install.packages("sentimentr")
library("sentimentr")
s <- sentiment(c("I am very happy", "I am not very happy"))
print(s)
# Plot histogram of sentiment scores
hist(s$sentiment,
     main = "Histogram of Sentiment Scores",
     xlab = "Sentiment Score",
     col = "skyblue",
     border = "white")