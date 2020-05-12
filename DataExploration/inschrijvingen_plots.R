inschrijvingen_df <-
  sqlQuery(sql_conn, "select * from Inschrijvingen")

attach(inschrijvingen_df)

##Continuous Features
ggplot_cont(inschrijvingen_df, LeeftijdStudent_op_Vandatum, "LeeftijdStudent_op_Vandatum")
ggplot_cont(inschrijvingen_df, LeeftijdStudent_op_Totdatum, "LeeftijdStudent_op_Totdatum")

##Categorical Features
#Opleidingsvorm
ggplot_cat(inschrijvingen_df, Opleidingsvorm, seq(0, 3500, 500))

#InschrijfLocatie
ggplot_cat(inschrijvingen_df, InschrijfLocatie, seq(0, 3500, 500))

#VanDatum
ggplot_cat(inschrijvingen_df, VanDatum, seq(0, 3500, 500))

#TotDatum
ggplot_cat(inschrijvingen_df, TotDatum, seq(0, 3500, 500))

#InschrijfStatus
ggplot_cat(inschrijvingen_df, InschrijfStatus, seq(0, 3500, 500))

#StudieUitslagsoort
ggplot_cat(inschrijvingen_df, StudieUitslagsoort, seq(0, 3500, 500), 45)

#StudieUitslag
ggplot_cat(inschrijvingen_df, StudieUitslag, seq(0, 3500, 500), 90)
