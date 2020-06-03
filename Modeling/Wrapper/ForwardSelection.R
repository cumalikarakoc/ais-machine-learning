risico_studenten_df[is.na(risico_studenten_df)] = 0
risico_studenten_df = risico_studenten_df[,-c(5,7)]

set.seed(1)
inTrain <- sample(1:nrow(risico_studenten_df), size=0.6*nrow(risico_studenten_df))
risico.train <- data.frame(risico_studenten_df[inTrain,])
risico.test <-  data.frame(risico_studenten_df[-inTrain,])
test_Risico <- as.factor(risico.test$RisicoStudent)

FitAll <- glm(formula = RisicoStudent ~ ., data=risico.train)
FitStart <- glm(RisicoStudent ~ 1, data=risico.train)

step(FitStart, direction = "forward", scope = formula(FitAll))

FitBest <- glm(formula = RisicoStudent ~ WT_Resultaat + DB_Onvoldoendes + 
                 Aanwezig + SAQ_Onvoldoendes + SPD_Resultaat + WT_Gemiddeld + 
                 InschrijfStatus + WT_NrToetscijfers + VanDatum + Opleidingsvorm + 
                 DB_Resultaat + SPD_Gemiddeld, data = risico.train)

risicoBest.Predict <- predict(FitBest, newdata=risico.test)
risicoBest.Predict <- round(risicoBest.Predict)
confusionMatrix(data=as.factor(risicoBest.Predict), reference=test_Risico)
risicoAll.Predict <- predict(FitAll, newdata=risico.test)
risicoAll.Predict <- round(risicoAll.Predict)
confusionMatrix(data=as.factor(risicoAll.Predict), reference=test_Risico)