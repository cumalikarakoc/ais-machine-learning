inschrijvingen_df <-
  sqlQuery(sql_conn, "select * from Inschrijvingen")

attach(inschrijvingen_df)

##Continuous Features
ggplot_cont(inschrijvingen_df, LeeftijdStudent_op_Vandatum, "LeeftijdStudent_op_Vandatum")
ggplot_cont(inschrijvingen_df, LeeftijdStudent_op_Totdatum, "LeeftijdStudent_op_Totdatum")

##Categorical Features
#Opleidingsvorm
ggplot_cat(inschrijvingen_df, Opleidingsvorm, "Opleidingsvorm", seq(0, 3500, 500))

#InschrijfLocatie
ggplot_cat(inschrijvingen_df, InschrijfLocatie, "InschrijfLocatie", seq(0, 3500, 500))

#VanDatum
ggplot_cat(inschrijvingen_df, VanDatum, "VanDatum", seq(0, 1000, 100))

#TotDatum
ggplot_cat(inschrijvingen_df, TotDatum, "TotDatum", seq(0, 300, 50))

#InschrijfStatus
ggplot_cat(inschrijvingen_df, InschrijfStatus, "InschrijfStatus", seq(0, 1000, 200))

#StudieUitslagsoort
ggplot_cat(inschrijvingen_df, StudieUitslagsoort, "StudieUitslagsoort", seq(0, 400, 100), 45)

#StudieUitslag
ggplot_cat(inschrijvingen_df, StudieUitslag, "StudieUitslag", seq(0, 500, 100), 90)
