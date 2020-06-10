klasDeelnames_df <-
  sqlQuery(sql_conn, "select * from KlasDeelnames")

attach(klasDeelnames_df)

##Categorical Features
#Studiejaar
ggplot_cat(klasDeelnames_df, Studiejaar,"Studiejaar", seq(0, 1000, 200))

#Klas
ggplot_cat(klasDeelnames_df, Klas, "Klas", seq(0, 100, 20))

#BeginDatum
ggplot_cat(klasDeelnames_df, BeginDatum, "BeginDatum", seq(0, 500, 100))

#EindDatum
ggplot_cat(klasDeelnames_df, EindDatum, "EindDatum", seq(0, 500, 100))
