library(tree)
library(rpart)
library(randomForest)
library(rpart.plot)
library(caret)


attach(train_data)

tree_fit <- tree(RisicoStudent ~ ., data = train_data)

summary(tree_fit)
plot(tree_fit)
text(tree_fit , pretty = 0)
#the most important indicator is SPD_Resultaat because the root is SPD_Resultaat

pred_tree <- predict(tree_fit, test_data, type = "class")
confusionMatrix(table(pred_tree, test_data$RisicoStudent), positive = "1")
# Accuracy : 0.765           
# Kappa : 0.4625
# Sensitivity : 0.6154          
# Specificity : 0.8397          

cv_tree <- cv.tree(tree_fit, FUN = prune.misclass)
cv_tree
plot(cv_tree$size, cv_tree$dev, type = "b")

prune_tree <- prune.misclass(tree_fit, best = 13)
plot(prune_tree)
text(prune_tree)


#check for improvement
pred_tree_pruned <- predict(prune_tree, test_data, type = "class")
confusionMatrix(table(pred_tree_pruned, test_data$RisicoStudent), positive =
                  "1")
# Accuracy : 0.8205
# Kappa : 0.5714
# Sensitivity : 0.6154
# Specificity : 0.9231
#improvement from 0.80 accuracy to 0.82

#----- rpart and cv to improve the model performance
train_data_na_omitted <- train_data %>%
  na.omit()

control <- trainControl(method = "repeatedcv",
                        number = 10,
                        repeats = 2)
dt_model <-
  train(
    RisicoStudent ~ .,
    data = train_data_na_omitted,
    method = "rpart",
    trControl = control
  )

importance <- varImp(dt_model, scale = FALSE)
plot(importance, cex.lab = 0.5)

formula_importance <- as.formula(
  "RisicoStudent ~ SPD_Resultaat +
                      SPD_Gemiddeld + InschrijfStatus + SAQ_Gemiddeld + SAQ_Onvoldoendes +
                                 Aanwezig"
)
tree_rpart <-
  rpart(
    formula_importance,
    data = train_data_na_omitted,
    method = "class",
    control = rpart.control(minsplit = 20, cp = 0.01)
  )


dt_pred <-
  predict(tree_rpart, train_data_na_omitted, type = "class")
confusionMatrix(
  data = dt_pred,
  reference = train_data_na_omitted$RisicoStudent,
  positive = "1"
)
#cp => 0.05 - Accuracy : 0.8634
#cp => 0.01 - Accuracy : 0.8944

## mooie tree print met rpart
rpart.plot(tree_rpart, type = 4, main = "")

#=====================
#==== RANDOM FOREST ==
#=====================

rf_tree <-
  randomForest(RisicoStudent ~ .,
               data = train_data_na_omitted,
               importance = TRUE)
rf_tree
# Call:
#   randomForest(formula = RisicoStudent ~ ., data = train_data_na_omitted)
# Type of random forest: classification
# Number of trees: 500
# No. of variables tried at each split: 4
#
# OOB estimate of  error rate: 15.22%
# Confusion matrix:
#   0  1 class.error
# 0 227 14  0.05809129
# 1  35 46  0.43209877

importance(rf_tree)
varImpPlot(rf_tree)

plot(rf_tree)


pred_rf_tree <- predict(rf_tree, test_data, type = "class")
confusionMatrix(table(pred_rf_tree, test_data$RisicoStudent), positive =
                  "1")
# Accuracy : 0.8047          


rf_tree_2 <-
  randomForest(
    RisicoStudent ~ .,
    data = train_data_na_omitted,
    mtry = 7,
    importance = TRUE
  )
pred_rf_tree_2 <- predict(rf_tree_2, test_data, type = "class")
confusionMatrix(table(pred_rf_tree_2, test_data$RisicoStudent), positive =
                  "1")



#mtry=5
# Accuracy : 0.7907         

# mtry=6
# Accuracy : 0.8047          

# mtry=7
# Accuracy : 0.7953          

#pruning
prune_rf_tree <- prune.rpart(rf_tree, cp = 0.05)
plot(prune_rf_tree)

pred_tree_pruned_rf <-
  predict(prune_rf_tree, test_data, type = "class")

confusionMatrix(table(pred_tree_pruned_rf, test_data$RisicoStudent),
                positive = "1")
