library(tree)
library(rpart)
library(randomForest)
library(rpart.plot)
library(caret)

tree_fit <- tree(RisicoStudent ~ ., data = train_data)

summary(tree_fit)
plot(tree_fit)
text(tree_fit , pretty = 0)
#the most important indicator is SPD_Resultaat because the root is SPD_Resultaat

pred_tree <- predict(tree_fit, test_data, type = "class")
confusionMatrix(table(pred_tree, test_data$RisicoStudent), positive = "1")
# Accuracy : 0.7906                     

cv_tree <- cv.tree(tree_fit, FUN = prune.misclass)
cv_tree
plot(cv_tree$size, cv_tree$dev, type = "b")

prune_tree <- prune.misclass(tree_fit, best = 8)
plot(prune_tree)
text(prune_tree)


#check for improvement
pred_tree_pruned <- predict(prune_tree, test_data, type = "class")
confusionMatrix(table(pred_tree_pruned, test_data$RisicoStudent), positive =
                  "1")
# Accuracy : 0.8205

#----- rpart and cv to improve the model performance
control <- trainControl(method = "repeatedcv",
                        number = 10,
                        repeats = 2)
dt_model <-
  train(
    RisicoStudent ~ .,
    data = train_data,
    method = "rpart",
    trControl = control
  )

importance <- varImp(dt_model, scale = FALSE)
plot(importance, cex.lab = 0.5)

formula_importance <- as.formula(
  "RisicoStudent ~ WT_Resultaat +
                      SPD_Resultaat + DB_Onvoldoendes + DB_Gemiddeld + WT_Resultaat +
                                 WT_Onvoldoendes + DB_NrToetscijfers"
)
tree_rpart <-
  rpart(
    formula_importance,
    data = train_data,
    method = "class",
    control = rpart.control(minsplit = 20, cp = 0.05)
  )


dt_pred <-
  predict(tree_rpart, train_data, type = "class")
confusionMatrix(
  data = dt_pred,
  reference = train_data$RisicoStudent,
  positive = "1"
)
#cp => 0.05 - Accuracy : 0.8657
#cp => 0.01 - Accuracy : 0.8771          

## mooie tree print met rpart
rpart
rpart.plot(tree_rpart, type = 4, main = "")

#=====================
#==== RANDOM FOREST ==
#=====================

rf_tree <-
  randomForest(RisicoStudent ~ .,
               data = train_data,
               importance = TRUE)
rf_tree
# Call:
#   randomForest(formula = RisicoStudent ~ ., data = train_data)
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
# Accuracy : 0.8547                      

rf_tree_2 <-
  randomForest(
    RisicoStudent ~ .,
    data = train_data,
    mtry = 7,
    importance = TRUE
  )
pred_rf_tree_2 <- predict(rf_tree_2, test_data, type = "class")
confusionMatrix(table(pred_rf_tree_2, test_data$RisicoStudent), positive =
                  "1")
#mtry=5
# Accuracy : 0.8462                   

# mtry=6
# Accuracy : 0.8504                    

# mtry=7
# Accuracy : 0.8547          