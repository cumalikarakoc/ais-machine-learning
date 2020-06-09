#===============================
#============ Setup ============
#===============================
library(caret)
risico_studenten_df[is.na(risico_studenten_df)] = 0
risico_studenten_df = risico_studenten_df[,-c(5,7)]
risico_studenten_df_Blok1 = risico_studenten_df[,-c(11,14,15,18,19,22,23,26)]
ctrl <- rfeControl(functions = rfFuncs, method = "cv", number = 10)

#===============================
#=========== 1e Blok ===========
#===============================

set.seed(1)
Blok1.inTrain <- sample(1:nrow(risico_studenten_df_Blok1), size=0.6*nrow(risico_studenten_df_Blok1))
Blok1.train <- data.frame(risico_studenten_df_Blok1[Blok1.inTrain,])
Blok1.test <-  data.frame(risico_studenten_df_Blok1[-Blok1.inTrain,])
Blok1.test_Risico <- as.factor(Blok1.test$RisicoStudent)
Blok1.train_Risico <- as.factor(Blok1.train$RisicoStudent)

#===============================
#====== Forward Selection ======
#===============================

Blok1.FitAll <- glm(formula = RisicoStudent ~ ., data=Blok1.train)
Blok1.FitStart <- glm(RisicoStudent ~ 1, data=Blok1.train)
step(Blok1.FitStart, direction = "forward", scope = formula(Blok1.FitAll))
Blok1fs.FitBest <- glm(formula = RisicoStudent ~ SPD_Resultaat + SAQ_Onvoldoendes + 
                       InschrijfStatus + Aanwezig + SPD_NrToetscijfers + SPD_Gemiddeld + 
                       Opleidingsvorm + Vooropl_diplomadatum + Te_Laat, data = Blok1.train)

Blok1fs.Predict <- predict(Blok1fs.FitBest, newdata=Blok1.test)
Blok1fs.Predict <- round(Blok1fs.Predict)
confusionMatrix(data=as.factor(Blok1fs.Predict), reference=Blok1.test_Risico, positive = "1") #0.8376

Blok1All.Predict <- predict(Blok1.FitAll, newdata=Blok1.test)
Blok1All.Predict <- round(Blok1All.Predict)
confusionMatrix(data=as.factor(Blok1All.Predict), reference=Blok1.test_Risico, positive = "1") #0.8504

#===============================
# Recursive Feature Elimination
#===============================

set.seed(3)
Blok1.rfe <- rfe(Blok1.train[,-2], as.factor(Blok1.train$RisicoStudent), rfeControl = ctrl)
print(Blok1.rfe)
predictors(Blok1.rfe)
plot(Blok1.rfe, type=c("g", "o"))
#zelfde als alle features dus 0.8504


#===============================
#======== 1e + 2e Blok =========
#===============================
set.seed(2)
Blok1_2.inTrain <- sample(1:nrow(risico_studenten_df), size=0.6*nrow(risico_studenten_df))
Blok1_2.train <- data.frame(risico_studenten_df[Blok1_2.inTrain,])
Blok1_2.test <-  data.frame(risico_studenten_df[-Blok1_2.inTrain,])
Blok1_2.test_Risico <- as.factor(Blok1_2.test$RisicoStudent)
Blok1_2.train_Risico <- as.factor(Blok1_2.train$RisicoStudent)

#===============================
#====== Forward Selection ======
#===============================

Blok1_2.FitAll <- glm(formula = RisicoStudent ~ ., data=Blok1_2.train)
Blok1_2.FitStart <- glm(RisicoStudent ~ 1, data=Blok1_2.train)
step(Blok1_2.FitStart, direction = "forward", scope = formula(Blok1_2.FitAll))
Blok1_2fs.FitBest <- glm(formula = RisicoStudent ~ WT_Resultaat + InschrijfStatus + 
                           DB_Onvoldoendes + Aanwezig + WT_Onvoldoendes + DB_Resultaat + 
                           SAQ_Onvoldoendes + SPD_Gemiddeld + Afwezig + Opleidingsvorm + 
                           SPD_Resultaat + Vooropl_diplomadatum + LeeftijdStudent_op_Vandatum + 
                           DB_NrToetscijfers, data = Blok1_2.train)

Blok1_2fs.Predict <- predict(Blok1_2fs.FitBest, newdata=Blok1_2.test)
Blok1_2fs.Predict <- round(Blok1_2fs.Predict)
confusionMatrix(data=as.factor(Blok1_2fs.Predict), reference=Blok1_2.test_Risico, positive = "1") #0.8504

Blok1_2All.Predict <- predict(Blok1_2.FitAll, newdata=Blok1_2.test)
Blok1_2All.Predict <- round(Blok1_2All.Predict)
confusionMatrix(data=as.factor(Blok1_2All.Predict), reference=Blok1_2.test_Risico, positive = "1") #0.859

#===============================
# Recursive Feature Elimination
#===============================

set.seed(4)
Blok1_2.rfe <- rfe(Blok1_2.train[,-2], as.factor(Blok1_2.train$RisicoStudent), rfeControl = ctrl)
print(Blok1_2.rfe)
predictors(Blok1_2.rfe)
plot(Blok1_2.rfe, type=c("g", "o"))

Blok1_2rfe.FitBest <- glm(formula = RisicoStudent ~ InschrijfStatus + WT_Resultaat + WT_Gemiddeld + DB_Resultaat + 
                            DB_Gemiddeld + SPD_Resultaat + Aanwezig + WT_Onvoldoendes + SAQ_Gemiddeld + Afwezig + 
                            DB_Onvoldoendes + SAQ_Onvoldoendes + SPD_Gemiddeld + DB_NrToetscijfers + 
                            WT_NrToetscijfers + SAQ_Resultaat, data = Blok1_2.train)

Blok1_2rfe.Predict <- predict(Blok1_2rfe.FitBest, newdata=Blok1_2.test)
Blok1_2rfe.Predict <- round(Blok1_2rfe.Predict)
confusionMatrix(data=as.factor(Blok1_2rfe.Predict), reference=Blok1_2.test_Risico, positive = "1") #0.859
