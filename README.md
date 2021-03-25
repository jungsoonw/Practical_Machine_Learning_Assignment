# Practical_Machine_Learning_Assignment

The code consists of three components: loading the data files, training the data, and predict the result with the trained model.

# 1) loading the data files

Any format containing '' or 'NA' will be removed, this will reduce the data size to 53 variables.

library('caret')

training_data <- data.frame(read.csv(file = 'pml-training.csv',na.strings=c('','NA')))

training_data<-training_data[,colSums(is.na(training_data))==0]

training_data<-training_data[,-c(1:7)]

# 2) train the model

Use train function with 'rf'. subgroup the data into training and test variables. Accuracy > 99 % obtained with test sets.

partition=createDataPartition(y=training_data$classe, p=0.6, list=FALSE)

partition_training <- training_data[partition,]

partition_testing <- training_data[-partition,]

model_data <- train(classe~., data=partition_training, method="rf",trControl=trainControl(method="none"))

predict_data <- predict(model_data, partition_testing)

confusionMatrix <- confusionMatrix(predict_data, as.factor(partition_testing$classe))

model_data$finalModel

plot(varImp(model_data))

confusionMatrix$overall[1]

# 3) predict the test set. 

Answers are: B A B A A E D B A A B C B A E E A B B B

testing_data <- data.frame(read.csv(file = 'pml-testing.csv',na.strings=c('','NA')))

testing_data<-testing_data[,colSums(is.na(testing_data))==0]

testing_data<-testing_data[,-c(1:7)]

predict_testing <- predict(model_data, testing_data)

save(predict_testing,file='predict_testing.RData')

