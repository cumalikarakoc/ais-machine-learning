
set.seed(1)
# remove the columns that cause problems due to high number of levels: vooropleiding, vooropleidingdiplomadatum en vooropleidingplaats
risico_studenten_df_dt <- risico_studenten_df %>%
  replace(is.na(.), 0)

colums_to_factorise <-
  c(
    "RisicoStudent",
    "Geslacht",
    "Vooropleidingniveau",
    "Opleidingsvorm",
    "InschrijfLocatie",
    "InschrijfStatus"
  )
for (col in colums_to_factorise) {
  risico_studenten_df_dt[, col] <- as.factor(risico_studenten_df_dt[, col])
}
str(risico_studenten_df_dt)

# split data into training and test datasets in 60:40 ratio
indexes <-
  sample(1:nrow(risico_studenten_df),
         size = 0.6 * nrow(risico_studenten_df_dt))
train_data <- risico_studenten_df_dt[indexes, ]
test_data <- risico_studenten_df_dt[-indexes, ]
