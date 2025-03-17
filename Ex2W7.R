install.packages("caret)")
library(caret)
modelLookup("C5.0")
data <- data[,c(2:32)]

set.seed(1) 
partition <- createDataPartition(data$diagnosis, p=0.7, list=FALSE)   
trainingData <- data[partition,] 
testData  <- data[-partition,] 
#Now build the model using C5.0 decision tree: 
model <- train(diagnosis~., method="C5.0", data= trainingData) 
model

# can change which metric to use for selecting the best model:
model <- train(diagnosis~., method="C5.0", data= trainingData, metric ="Kappa") 
model

control <- trainControl(method="cv", number=10,  selectionFunction = "oneSE") 
model <- train(diagnosis~., method="C5.0", data= trainingData, trControl=control) 
model

#custom Grid Search
customGrid <- expand.grid(model=c("rules", "tree"), trials = c(20, 25,30,35,40), winnow=c(FALSE)) 

model <- train(diagnosis~., method="C5.0", data= trainingData, tuneGrid=customGrid) 
model 
