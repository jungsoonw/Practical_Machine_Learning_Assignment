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

> model_data$finalModel

               Call:

                randomForest(x = x, y = y, mtry = param$mtry) 
 
               Type of random forest: classification
               
                     Number of trees: 500
                     
         No. of variables tried at each split: 17


        OOB estimate of  error rate: 0.7%
        
        Confusion matrix:

             A    B    C    D    E class.error

        A 3343    3    1    0    1 0.001493429

        B   16 2257    6    0    0 0.009653357

        C    0   14 2032    8    0 0.010710808

        D    0    1   22 1905    2 0.012953368

        E    0    0    1    8 2156 0.004157044

> plot(varImp(model_data))

![image](https://user-images.githubusercontent.com/81325654/112400322-62dc9000-8cc5-11eb-9f71-97763611975f.png)


> confusionMatrix$overall[1]

        Accuracy 

        0.993245 

# Graph  



# 3) predict the test set. 

Answers are: B A B A A E D B A A B C B A E E A B B B

testing_data <- data.frame(read.csv(file = 'pml-testing.csv',na.strings=c('','NA')))

testing_data<-testing_data[,colSums(is.na(testing_data))==0]

testing_data<-testing_data[,-c(1:7)]

predict_testing <- predict(model_data, testing_data)

save(predict_testing,file='predict_testing.RData')

> predict_testing

        [1] B A B A A E D B A A B C B A E E A B B B
       Levels: A B C D E

