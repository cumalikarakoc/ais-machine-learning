# split data into training and test datasets in 60:40 ratio
set.seed(1)
indexes <- sample(1:nrow(risico_studenten_df), size = 0.6 * nrow(risico_studenten_df))
train_data <- risico_studenten_df[indexes]
test_data <- risico_studenten_df[-indexes]
