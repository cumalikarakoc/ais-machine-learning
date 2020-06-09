library(glmnet) # ridge, elastic net, and lasso 
library(data.table)    # provides enhanced data.frame
library(ggplot2)       # plotting
library(tidyverse)
library(caret)
library(e1071)
library(scales)

risico_studenten <- risico_studenten_df_dt

str(risico_studenten)

#Make a matrix from the train_data to use it in the glmnet model
train_matrix <-model.matrix(train_data$RisicoStudent~.,train_data)[,-2]
train_risicoStudent<-train_data$RisicoStudent

# Find the best lambda using cross-validation
cv <- cv.glmnet(train_matrix, train_risicoStudent, alpha = 1, family="binomial")

# Display the best lambda value
Best_lam <- cv$lambda.min

# Fit the final model on the training data with best lambda value
model_glmnet <- glmnet(train_matrix, train_risicoStudent, alpha = 1, lambda = Best_lam, 
                family="binomial")

#Make a matrix from the test data to use it in the prediction
test_matrix <- model.matrix(test_data$RisicoStudent ~., test_data)[,-2]

# Make predictions on the test data
predictions<- predict(model_glmnet ,test_matrix, type ="class",s=Best_lam )

#confusionMatrix to get the accuracy of the predict
confusionMatrix(table(predictions,  test_data$RisicoStudent), positive="1")

#the output of confusionMatrix
#Confusion Matrix and Statistics
#
#p     0   1
#0 165  22
#1   5  42
#
#Accuracy : 0.8846          
#95% CI : (0.8366, 0.9226)
#No Information Rate : 0.7265          
#P-Value [Acc > NIR] : 3.21e-09        
#
#Kappa : 0.6834          
#
#Mcnemar's Test P-Value : 0.002076        
#                                          
#            Sensitivity : 0.6562          
#            Specificity : 0.9706          
#         Pos Pred Value : 0.8936          
#         Neg Pred Value : 0.8824          
#             Prevalence : 0.2735          
#         Detection Rate : 0.1795          
#   Detection Prevalence : 0.2009          
#      Balanced Accuracy : 0.8134          
#                                          
#       'Positive' Class : 1               
                              

# Dsiplay the regression coefficients
co<-coef(model_glmnet,exact = FALSE)
#view the regression coefficients
co

# Get the names of all features which dose not have 
#regression coefficient value of 0 
inds<-which(co!=0)
selected_features<-row.names(co)[inds]
selected_features<-selected_features[!(selected_features %in% '(Intercept)')];
# view the names of those features which are 
# selected using the regression coefficient
selected_features


#Making target for the train_data and test_data dataset's 
test_Risico <- as.factor(test_data$RisicoStudent)
train_Risico <- as.factor(train_data$RisicoStudent)

#To check the effect of LASSO regression we make a logistic regression using GLM
## Make a model and predictions on all features using GLM
model_glm <- glm(formula = RisicoStudent ~ ., data=train_data,  family="binomial")
Predictions_2 <- predict(model_glm, newdata=test_data,type = "response")
Predictions_2 <- round(Predictions_2)
confusionMatrix(data=as.factor(Predictions_2), reference=test_Risico, positive = "1") 


#Confusion Matrix and Statistics
#
#Reference
#Prediction   0   1
#0 158  15
#1  17  44
#
#Accuracy : 0.8632          
#95% CI : (0.8125, 0.9045)
#No Information Rate : 0.7479          
#P-Value [Acc > NIR] : 1.141e-05       
#
#Kappa : 0.6414          
#
#Mcnemar's Test P-Value : 0.8597          
#                                          
#            Sensitivity : 0.7458          
#            Specificity : 0.9029          
#         Pos Pred Value : 0.7213          
#         Neg Pred Value : 0.9133          
#             Prevalence : 0.2521          
#         Detection Rate : 0.1880          
#   Detection Prevalence : 0.2607          
#      Balanced Accuracy : 0.8243          
#                                          
#       'Positive' Class : 1       