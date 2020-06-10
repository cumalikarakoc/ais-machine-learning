library(ggplot2)
library(RODBC)
library(dplyr)

sql_conn <- odbcConnect("SAS_ML_FILT")
Aanwezigheid_df <- sqlQuery(sql_conn, "select * from Aanwezigheid")

### Aanwezigheid ###

## RegistratieMoment
ggplot(Aanwezigheid_df,aes(x=RegistratieMoment)) + 
  geom_histogram(binwidth = 15,
                 color="Black",
                 fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 7000, 500)) +
  theme_bw()

## AanwezigheidsType
ggplot(Aanwezigheid_df,aes(x=AanwezigheidsType)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 60000, 5000)) +
  theme_bw()
