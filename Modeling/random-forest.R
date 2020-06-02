library(tree)

attach(train_data)

risico_studenten_df$RisicoStudent <- as.factor(risico_studenten_df$RisicoStudent)
tree_fit <- tree(RisicoStudent~., data = train_data)

summary(tree_fit)
plot(tree_fit)
text(tree_fit , pretty = 0)
 #the most important indicator is SPD_Resultaat because the root is SPD_Resultaat

pred_tree <- predict(tree_fit, test_data, type = "class")
confusionMatrix(table(pred_tree, test_data$RisicoStudent))
