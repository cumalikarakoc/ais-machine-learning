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

set.seed(5)
pred_tree <- predict(tree_fit, test_data, type = "class")
confusionMatrix(table(pred_tree, test_data$RisicoStudent), positive = "1")
# Accuracy : 0.7991                     

cv_tree <- cv.tree(tree_fit, FUN = prune.misclass)
cv_tree
plot(cv_tree$size, cv_tree$dev, type = "b")

prune_tree <- prune.misclass(tree_fit, best = 9)
plot(prune_tree)
text(prune_tree)


#check for improvement
pred_tree_pruned <- predict(prune_tree, test_data, type = "class")
confusionMatrix(table(pred_tree_pruned, test_data$RisicoStudent), positive =
                  "1")
# Accuracy : 0.8291

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
# No. of variables tried at each split: 5
#
# OOB estimate of  error rate: 15.22%
# Confusion matrix:
#   0  1 class.error
# 0 227 14  0.05809129
# 1  35 46  0.43209877
varImpPlot(rf_tree)

pred_rf_tree <- predict(rf_tree, test_data, type = "class")
confusionMatrix(table(pred_rf_tree, test_data$RisicoStudent), positive = "1")
# Accuracy : 0.8889                     

rf_tree_2 <-
  randomForest(
    RisicoStudent ~ .,
    data = train_data,
    mtry = 4,
    importance = TRUE
  )
pred_rf_tree_2 <- predict(rf_tree_2, test_data, type = "class")
confusionMatrix(table(pred_rf_tree_2, test_data$RisicoStudent), positive = "1")
#mtry=4
# Accuracy : 0.8846                

# mtry=6
# Accuracy : 0.8846
