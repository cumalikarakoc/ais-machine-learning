# split data into training and test datasets in 60:40 ratio
set.seed(1)
# remove the columns: vooropleiding, plaats and the courses from 2nd period
risico_studenten_df_dt <- risico_studenten_df %>%
  select(-c(5, 7, 13, 16, 17, 20, 21, 24, 25, 28))

risico_studenten_df_dt$RisicoStudent <-
  as.factor(risico_studenten_df_dt$RisicoStudent)

indexes <- sample(1:nrow(risico_studenten_df), size = 0.6 * nrow(risico_studenten_df_dt))
train_data <- risico_studenten_df_dt[indexes,]
test_data <- risico_studenten_df_dt[-indexes,]
