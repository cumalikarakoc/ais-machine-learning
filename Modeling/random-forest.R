library(tree)
library(rpart)
library(randomForest)
library(rpart.plot)
library(caret)

tree_fit <- tree(RisicoStudent ~ ., data = train_data)

summary(tree_fit)
plot(tree_fit)
text(tree_fit , pretty = 0)
#the most important indicator is WT_Resultaat because the root is SPD_Resultaat

set.seed(5)
pred_tree <- predict(tree_fit, test_data, type = "class")
confusionMatrix(table(pred_tree, test_data$RisicoStudent), positive = "1")
# Accuracy : 0.8034                     

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

#=====================
#==== RANDOM FOREST ==
#=====================
rf_tree <-
  randomForest(RisicoStudent ~ .,
               data = train_data,
               importance = TRUE)
rf_tree
# Call:
#   randomForest(formula = RisicoStudent ~ ., data = train_data,      importance = TRUE) 
# Type of random forest: classification
# Number of trees: 500
# No. of variables tried at each split: 5
# 
# OOB estimate of  error rate: 10.57%
# Confusion matrix:
#   0  1 class.error
# 0 244 12   0.0468750
# 1  25 69   0.2659574
varImpPlot(rf_tree)

pred_rf_tree <- predict(rf_tree, test_data, type = "class")
confusionMatrix(table(pred_rf_tree, test_data$RisicoStudent), positive = "1")
# Accuracy : 0.8675                     

rf_tree_2 <-
  randomForest(
    RisicoStudent ~ .,
    data = train_data,
    mtry = 6,
    importance = TRUE
  )
pred_rf_tree_2 <- predict(rf_tree_2, test_data, type = "class")
confusionMatrix(table(pred_rf_tree_2, test_data$RisicoStudent), positive = "1")
#mtry=4
# Accuracy : 0.8547                          

# mtry=6
# Accuracy : 0.8632          
