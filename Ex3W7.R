install.packages("word2vec")
library(word2vec)
install.packages("janeaustenr")
library("janeaustenr")
set.seed(1) 
txt <- austen_books() 
model <- word2vec(x = txt$text[txt$book == "Sense & Sensibility"], type = "cbow", dim = 15, iter = 20) 
embeddings <- as.matrix(model) 

View(embeddings) 
vocabulary <- summary(model, type = "vocabulary") 
vocabulary 
length(vocabulary)

embeddings["hope",] 
neighbourWords <- predict(model, c("Lucy"), type = "nearest", top_n = 50) 
neighbourWords

#Now try typing in more words: 
neighbourWords <- predict(model, c("Lucy", "man", "woman"), type = "nearest", top_n = 10) 
neighbourWords

#Develop a word2vec model using just 2 dimensions 
set.seed(1) 
txt <- austen_books() 
model <- word2vec(x = txt$text[txt$book == "Sense & Sensibility"], type = "cbow", dim = 2, iter = 20) 
embeddings <- as.matrix(model) 
embeddings <- predict(model, c( 
  "John","Lucy","Edward","Marianne","Elinor","woman","man","she", 
  "he","Colonel","Brandon", "rain", "weather"), type = "embedding") 
# now represented using just 2 values (2 dimensions)

embeddings <- as.data.frame(embeddings) 
plot(embeddings$V1, embeddings$V2) 
text(embeddings$V1, embeddings$V2, labels = row.names(embeddings), pos = 1)

# Euclidean distance between word vectors: 
euclidean <- function(a, b) sqrt(sum((a - b)^2)) 
euclidean(embeddings["rain",], embeddings["weather",]) 
euclidean(embeddings["Brandon",], embeddings["Colonel",]) 

install.packages("lsa")
library("lsa") 
set.seed(1) 
txt <- austen_books() 
model <- word2vec(x = txt$text[txt$book == "Sense & Sensibility"], type = "cbow", dim = 2,  iter = 20) 
embeddings <- as.matrix(model) 
cosine(embeddings["Lucy",], embeddings["Elinor",])

#calculating the correlation between different word vectors: 
set.seed(1) 
txt <- austen_books() 
model <- word2vec(x = txt$text[txt$book == "Sense & Sensibility"], type = "cbow", dim = 15, 
                  iter = 20) 
embeddings <- as.matrix(model) 
cor(embeddings["Brandon",], embeddings["Colonel",]) 
cor(embeddings["weather",], embeddings["rain",]) 

#arithmetic with word vectors, consider the 
following as an example: 
  set.seed(1) 
txt <- austen_books() 
model <- word2vec(x = txt$text[txt$book == "Sense & Sensibility"], type = "cbow", dim = 2, 
                  iter = 20) 
embeddings <- as.matrix(model) 
vector <- embeddings["hurry", ] + embeddings["walk", ] 
predict(model, vector, type = "nearest", top_n = 10)