rm(list=ls())
# homework assignment
library('caret')

training_data <- data.frame(read.csv(file = 'pml-training.csv',na.strings=c('','NA')))
training_data<-training_data[,colSums(is.na(training_data))==0]
training_data<-training_data[,-c(1:7)]

partition=createDataPartition(y=training_data$classe, p=0.6, list=FALSE)
partition_training <- training_data[partition,]
partition_testing <- training_data[-partition,]

model_data <- train(classe~., data=partition_training, method="rf",trControl=trainControl(method="none"))
#model_data <- train(partition_training[-ncol(partition_training)], partition_training$classe, method="rf",trControl=trainControl(method="none"))
predict_data <- predict(model_data, partition_testing)
onfusionMatrix <- confusionMatrix(predict_data, as.factor(partition_testing$classe))

model_data$finalModel
plot(varImp(model_data))
confusionMatrix$overall[1]

testing_data <- data.frame(read.csv(file = 'pml-testing.csv',na.strings=c('','NA')))
testing_data<-testing_data[,colSums(is.na(testing_data))==0]
testing_data<-testing_data[,-c(1:7)]

predict_testing <- predict(model_data, testing_data)
save(predict_testing,file='predict_testing.RData')
