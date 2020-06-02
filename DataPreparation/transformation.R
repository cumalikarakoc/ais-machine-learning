library(RODBC)
library(dplyr)
library(tidyr)

sql_conn <- odbcConnect("SAS_ML_FILTERED")

#===============================
#======= Inschrijvingen ========
#===============================
inschrijvingen_raw <-
  sqlQuery(
    sql_conn,
    "Select Student, Opleidingsvorm, InschrijfLocatie, InschrijfStatus,
                              LeeftijdStudent_op_Vandatum, VanDatum, StudieUitslagsoort, StudieUitslag from Inschrijvingen"
  )

inschrijvingen_df <- inschrijvingen_raw %>%
  filter(StudieUitslagsoort == 'Einde 1e jaar (oud)') %>%
  mutate(
    RisicoStudent = ifelse(
      StudieUitslag == 'Positief studieadvies Jr1'
      |
        StudieUitslag == 'Voorlopig positief studieadvies Jr 1',
      0,
      1
    )
  )  %>%
  select(
    Student,
    Opleidingsvorm,
    InschrijfLocatie,
    LeeftijdStudent_op_Vandatum,
    InschrijfStatus,
    VanDatum,
    RisicoStudent
  )

#===============================
#======= Studenten =============
#===============================
studenten_df <-
  sqlQuery(
    sql_conn,
    "Select id as Student, Geslacht, Vooropleidingniveau, Vooropleiding, Vooropl_diplomadatum, Vooropleidingplaats
from SAS_ML_FILTERED.dbo.Studenten"
  )

#===============================
#= OnderwijsEenheidResultaten ==
#===============================
onderwijseenheidsResultaten_raw <-
  sqlQuery(
    sql_conn,
    "Select distinct Student, OnderwijsEenheid, Resultaat,
                                           NrToetscijfers from OnderwijsEenheidResultaten"
  )

resultaat <- onderwijseenheidsResultaten_raw %>%
  group_by(Student) %>%
  select(Student, OnderwijsEenheid, Resultaat) %>%
  spread(OnderwijsEenheid, Resultaat) %>%
  rename(
    DB_Resultaat = DB,
    SAQ_Resultaat = SAQ,
    SPD_Resultaat = SPD,
    WT_Resultaat = WT
  )

nrToetscijfers <- onderwijseenheidsResultaten_raw %>%
  group_by(Student) %>%
  select(Student, OnderwijsEenheid, NrToetscijfers) %>%
  spread(OnderwijsEenheid, NrToetscijfers) %>%
  rename(
    DB_NrToetscijfers = DB,
    SAQ_NrToetscijfers = SAQ,
    SPD_NrToetscijfers = SPD,
    WT_NrToetscijfers = WT
  )

onderwijseenheidsResultaten_df <-
  merge(resultaat, nrToetscijfers, by = "Student")


#===============================
#====== ToetsResultaten ========
#===============================
toetsResultaten_raw <-
  sqlQuery(
    sql_conn,
    "Select Student, OnderwijsEenheid, Toetscode, max(Resultaat) as Resultaat, sum(Onvoldoende) as Onvoldoendes
                                            from SAS_ML_FILTERED.dbo.ToetsResultaten
                                            group by Student, OnderwijsEenheid, Toetscode
                                            order by Student"
  )

gemiddeld <-
  toetsResultaten_raw %>%
  group_by(Student, OnderwijsEenheid) %>%
  summarise(Gemiddeld = mean(Resultaat)) %>%
  select(Student, OnderwijsEenheid, Gemiddeld) %>%
  spread(OnderwijsEenheid, Gemiddeld, fill = 0) %>%
  rename(
    DB_Gemiddeld = DB,
    SAQ_Gemiddeld = SAQ,
    SPD_Gemiddeld = SPD,
    WT_Gemiddeld = WT
  )

aantal_onvoldoendes <-
  toetsResultaten_raw %>%
  group_by(Student, OnderwijsEenheid) %>%
  summarise(Onvoldoendes = sum(Onvoldoendes)) %>%
  select(Student, OnderwijsEenheid, Onvoldoendes) %>%
  spread(OnderwijsEenheid, Onvoldoendes, fill = 0) %>%
  rename(
    DB_Onvoldoendes = DB,
    SAQ_Onvoldoendes = SAQ,
    SPD_Onvoldoendes = SPD,
    WT_Onvoldoendes = WT
  )


toetsResultaten_df <-
  merge(gemiddeld, aantal_onvoldoendes, by = "Student")
#===============================
#====== Aanwezigheid ===========
#===============================
aanwezigheid_df <-
  sqlQuery(sql_conn, "Select Student, AanwezigheidsType from Aanwezigheid") %>%
  group_by(Student, AanwezigheidsType) %>%
  tally() %>%
  mutate(Perc = round(100 * n / sum(n), 2)) %>%
  select(Student, AanwezigheidsType, Perc) %>%
  spread(AanwezigheidsType, Perc, fill = 0)


#===============================
#====== Merge dataframes =======
#===============================
risico_studenten_df <- studenten_df %>%
  merge(inschrijvingen_df, by = "Student") %>%
  select(
    Student,
    RisicoStudent,
    Geslacht,
    Vooropleidingniveau,
    Vooropleiding,
    Vooropl_diplomadatum,
    Vooropleidingplaats,
    Opleidingsvorm,
    InschrijfLocatie,
    LeeftijdStudent_op_Vandatum,
    InschrijfStatus,
    VanDatum
  ) %>%
  merge(onderwijseenheidsResultaten_df, by = "Student") %>%
  merge(toetsResultaten_df, by = "Student") %>%
  merge(aanwezigheid_df, by = "Student")

# rename column with whitespace
risico_studenten_df <- risico_studenten_df %>%
  rename(
    Te_Laat = `Te laat`
  )

dim(risico_studenten_df)
hist(risico_studenten_df$RisicoStudent)
str(risico_studenten_df)


