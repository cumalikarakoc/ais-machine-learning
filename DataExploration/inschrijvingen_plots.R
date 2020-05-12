library(ggplot2)
library(RODBC)

sql_conn <- odbcConnect("SAS_ML_FILTERED")
inschrijvingen_df <-
  sqlQuery(sql_conn, "select * from Inschrijvingen")


attach(inschrijvingen_df)

feature <- LeeftijdStudent_op_Vandatum
footer <- "LeeftijdStudent_op_Vandatum"  

feature <- LeeftijdStudent_op_Totdatum
footer <- "LeeftijdStudent_op_Totdatum"

ggplot(inschrijvingen_df, aes(x = feature)) +
  geom_histogram(color = "black",
                 fill = "dark turquoise",
                 binwidth = 1) +
  geom_vline(aes(
    xintercept = mean(feature, na.rm = TRUE),
    color = "mean"), linetype = "dashed", size = 1) +
  scale_color_manual(name = "statistics",
                     values = c(mean = "red")) +
  scale_x_continuous(name = footer) 


#Categorical
#Opleidingsvorm
#InschrijfLocatie
#VanDatum
#TotDatum
#InschrijfStatus
#StudieUtslagsort
#StudieUitslag