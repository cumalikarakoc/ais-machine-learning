library(RODBC)
library(dplyr)
library(tidyr)

sql_conn <- odbcConnect("SAS_ML_FILTERED")

#===============================
#======= Inschrijvingen ========
#===============================
inschrijvingen_df <- sqlQuery(sql_conn, "Select Student, Opleidingsvorm, InschrijfLocatie, InschrijfStatus,
                              LeeftijdStudent_op_Vandatum, VanDatum from Inschrijvingen")

#===============================
#= OnderwijsEenheidResultaten ==
#===============================
onderwijseenheidsResultaten_raw <- sqlQuery(sql_conn, "Select distinct Student, OnderwijsEenheid, Resultaat,
                                           NrToetscijfers from OnderwijsEenheidResultaten") 

resultaat <- onderwijseenheidsResultaten_raw %>%
  group_by(Student) %>%
  select(Student, OnderwijsEenheid, Resultaat) %>%
  spread(OnderwijsEenheid, Resultaat)%>%
  rename(DB_Resultaat = DB, SAQ_Resultaat = SAQ, SPD_Resultaat = SPD,
         WT_Resultaat = WT)

nrToetscijfers <- onderwijseenheidsResultaten_raw %>%
  group_by(Student) %>%
  select(Student, OnderwijsEenheid, NrToetscijfers) %>%
  spread(OnderwijsEenheid, NrToetscijfers) %>%
  rename(DB_NrToetscijfers = DB, SAQ_NrToetscijfers = SAQ, SPD_NrToetscijfers = SPD,
         WT_NrToetscijfers = WT)

onderwijseenheidsResultaten_df <- merge(resultaat, nrToetscijfers, by="Student")


#===============================
#====== ToetsResultaten ========
#===============================
toetsResultaten_raw <- sqlQuery(sql_conn, "Select Student, OnderwijsEenheid, Resultaat, Onvoldoende
                                           from ToetsResultaten")

# resultaat_toets <-
  toetsResultaten_raw %>%
  group_by(Student) %>%
  select(Student, OnderwijsEenheid, Resultaat) 
  # %>%
  spread(OnderwijsEenheid, Resultaat)%>%  rename(DB_Resultaat = DB, SAQ_Resultaat = SAQ, SPD_Resultaat = SPD,
         WT_Resultaat = WT)

onvoldoendes <- onderwijseenheidsResultaten_raw %>%
  group_by(Student) %>%
  select(Student, OnderwijsEenheid, NrToetscijfers) %>%
  spread(OnderwijsEenheid, NrToetscijfers) %>%
  rename(DB_NrToetscijfers = DB, SAQ_NrToetscijfers = SAQ, SPD_NrToetscijfers = SPD,
         WT_NrToetscijfers = WT)

onderwijseenheidsResultaten_df <- merge(resultaat, nrToetscijfers, by="Student")
#===============================
#====== Aanwezigheid ===========
#===============================
aanwezigheid_df <- sqlQuery(sql_conn, "Select Student, AanwezigheidsType from Aanwezigheid") %>%
  group_by(Student, AanwezigheidsType) %>%
  tally() %>%
  mutate(Perc = round(100 * n / sum(n), 2)) %>%
  select(Student, AanwezigheidsType, Perc) %>%
  spread(AanwezigheidsType, Perc, fill = 0)

