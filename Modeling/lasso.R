library(glmnet) # ridge, elastic net, and lasso 
library(data.table)    # provides enhanced data.frame
library(ggplot2)       # plotting
library(tidyverse)
library(caret)
library(e1071)
library(scales)

#risico_studenten_df1 <- na.omit(risico_studenten_df)

#GeslagdOfNiet <- ifelse(risico_studenten_df1$RisicoStudent >0.5, "geslagd", "gezakt")
#risico_studenten<-data.frame(risico_studenten_df1,GeslagdOfNiet) 
#
## Alle megelijke kolommen
risico_studenten<-risico_studenten_df[,c("RisicoStudent","Student" ,"Geslacht","Vooropleidingniveau",
                                             "Vooropl_diplomadatum","LeeftijdStudent_op_Vandatum",
                                             "InschrijfLocatie","VanDatum", "DB_Resultaat", "SAQ_Resultaat",
                                             "SPD_Resultaat","WT_Resultaat", "DB_NrToetscijfers", 
                                             "SAQ_NrToetscijfers", "SPD_NrToetscijfers","WT_NrToetscijfers",
                                             "DB_Gemiddeld", "SAQ_Gemiddeld", "SPD_Gemiddeld","WT_Gemiddeld",
                                             "DB_Onvoldoendes","SAQ_Onvoldoendes","SPD_Onvoldoendes",
                                             "WT_Onvoldoendes", "Aanwezig", "Afwezig", "Te_Laat") ]
# Accuracy : 0.8632
##Percentage P-rendement 78.63%

#geiflterde kolommen 
risico_studenten<-risico_studenten_df[,c("RisicoStudent","Student" ,"Vooropleidingniveau",
                                             "LeeftijdStudent_op_Vandatum",
                                             "VanDatum", "DB_Resultaat", "SAQ_Resultaat",
                                             "SPD_Resultaat","WT_Resultaat", "DB_NrToetscijfers", 
                                             "SAQ_NrToetscijfers", "SPD_NrToetscijfers","WT_NrToetscijfers",
                                             "DB_Gemiddeld", "SAQ_Gemiddeld", "SPD_Gemiddeld","WT_Gemiddeld",
                                             "DB_Onvoldoendes","SAQ_Onvoldoendes","SPD_Onvoldoendes",
                                             "WT_Onvoldoendes", "Aanwezig", "Afwezig", "Te_Laat") ]
##Accuraccy: 0.8675


#geiflterde kolommen0 
risico_studenten<-risico_studenten_df[,c("RisicoStudent","Student","LeeftijdStudent_op_Vandatum",
                                             "DB_Resultaat", "SAQ_Resultaat","SPD_Resultaat",
                                             "WT_Resultaat", "WT_NrToetscijfers","SAQ_Gemiddeld",
                                             "WT_Gemiddeld","DB_Onvoldoendes","SAQ_Onvoldoendes",
                                             "SPD_Onvoldoendes","WT_Onvoldoendes","Aanwezig", "Te_Laat") ]
##Accuracy : 0.8718 

#geiflterde kolommen
risico_studenten<-risico_studenten_df[,c("RisicoStudent","Student","LeeftijdStudent_op_Vandatum","VanDatum",
                                             "DB_Resultaat", "SAQ_Resultaat","SPD_Resultaat",
                                             "WT_Resultaat", "WT_NrToetscijfers","DB_Gemiddeld", "SAQ_Gemiddeld", 
                                         "SPD_Gemiddeld","WT_Gemiddeld","DB_Onvoldoendes","SAQ_Onvoldoendes",
                                             "SPD_Onvoldoendes","WT_Onvoldoendes","Aanwezig", "Te_Laat","Afwezig") ]
##Accuracy : 0.8761

#geiflterde kolommen met alleen de eeste twee vakken SPD en WT, om Zo vroeg mogelijk te predicten
risico_studenten<-risico_studenten_df[,c("RisicoStudent","Student","VanDatum", 
                                         "SAQ_Resultaat","SPD_Resultaat",
                                         "SPD_NrToetscijfers","SAQ_NrToetscijfers","SPD_Gemiddeld",
                                         "SAQ_Gemiddeld",
                                         "SAQ_Onvoldoendes","SPD_Onvoldoendes", 
                                         "Aanwezig","Afwezig", "Te_Laat") ]
#Accuracy : 0.856

#geiflterde kolommen1
risico_studenten<-risico_studenten_df[,c("RisicoStudent","Student","VanDatum","DB_Resultaat", 
                                             "SAQ_Resultaat","SPD_Resultaat","WT_Resultaat",
                                             "WT_NrToetscijfers","DB_Gemiddeld", "SAQ_Gemiddeld", 
                                             "SPD_Gemiddeld","WT_Gemiddeld","DB_Onvoldoendes",
                                             "SAQ_Onvoldoendes","SPD_Onvoldoendes","WT_Onvoldoendes", 
                                             "Aanwezig", "Te_Laat") ]
#Accuracy : 0.8761


# Check of kolommen namen kloppen
colnames(risico_studenten)

risico_studenten[is.na(risico_studenten)] <- 0

# Split the data into training and test set
set.seed(2)
inTrain<- sample(1:nrow(risico_studenten), size=0.6*nrow(risico_studenten))

#Making a train and test sets
train <- risico_studenten[inTrain,]
test <-  risico_studenten[-inTrain,]


x <-model.matrix(train$RisicoStudent~.,train)[,-1]
y<-train$RisicoStudent

#alpha=1 to use Lasso regression
glm<- glmnet(x, y, family = "binomial", alpha = 1, lambda = NULL)

summary(glm)

# Find the best lambda using cross-validation
set.seed(2) 
cv <- cv.glmnet(x, y, alpha = 1)

# Display the best lambda value
Best_lam <- cv$lambda.min


# Fit the final model on the training data with best lambda value
model <- glmnet(x, y, alpha = 1, lambda = Best_lam)

# Dsiplay regression coefficients
co<-coef(model,exact = FALSE)
co
inds<-which(co!=0)
variables<-row.names(co)[inds]
variables<-variables[!(variables %in% '(Intercept)')];

# Make predictions on the test data
x.test <- model.matrix(test$RisicoStudent ~., test)[,-1]
predictions <- model %>% predict(x.test) %>% as.vector() 
predictions<-round(predictions, digits = 0)

#lasso.coef=predict (out ,type =" coefficients",s=bestlam )[1:20 ,]
# Model performance metrics
data.frame(
  RMSE = RMSE(predictions, test$RisicoStudent),
  Rsquare = R2(predictions, test$RisicoStudent)
)

#confusionMatrix to get the accuracy of the predict
caret::confusionMatrix(data =as.factor(predictions), reference = as.factor(test$RisicoStudent))







