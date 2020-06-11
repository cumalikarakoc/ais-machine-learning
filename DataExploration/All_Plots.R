#===============================
#====== Hist & Bar plots =======
#===============================

### Aanwezigheid ###
attach(Aanwezigheid_df)
## RegistratieMoment
ggplot_date(Aanwezigheid_df, RegistratieMoment, 15, seq(0, 7000, 500), "RegistratieMoment")
## AanwezigheidsType
ggplot_cat(Aanwezigheid_df, AanwezigheidsType, seq(0, 65000, 5000), "AanwezigheidsType")


### IngeleverdeBeroepsProducten ###
attach(IngeleverdeBeroepsProducten_df)
## OnderwijsEenheid
ggplot_cat(IngeleverdeBeroepsProducten_df, OnderwijsEenheid, seq(0, 2000, 200), "OnderwijsEenheid")
## Toets
ggplot_cat(IngeleverdeBeroepsProducten_df, Toets, seq(0, 3500, 100), "Toets")
## Plaatsingsdatum
ggplot_date(IngeleverdeBeroepsProducten_df, Plaatsingsdatum, 25, seq(0, 1000, 50), "Plaatsingsdatum")


### Inschrijvingen ###
attach(Inschrijvingen_df)
## LeeftijdStudent_op_Vandatum
ggplot_cont(Inschrijvingen_df, LeeftijdStudent_op_Vandatum, "LeeftijdStudent_op_Vandatum")
## LeeftijdStudent_op_Totdatum
ggplot_cont(Inschrijvingen_df, LeeftijdStudent_op_Totdatum, "LeeftijdStudent_op_Totdatum")
## Opleidingsvorm
ggplot_cat(Inschrijvingen_df, Opleidingsvorm, seq(0, 2000, 100), "Opleidingsvorm")
## InschrijfLocatie
ggplot_cat(Inschrijvingen_df, InschrijfLocatie, seq(0, 1200, 100), "InschrijfLocatie")
## VanDatum
ggplot_cat(Inschrijvingen_df, VanDatum, seq(0, 1100, 100), "VanDatum")
## TotDatum
ggplot_date(Inschrijvingen_df, TotDatum, 45, seq(0, 300, 50), "TotDatum")
## InschrijfStatus
ggplot_cat(Inschrijvingen_df, InschrijfStatus, seq(0, 1500, 100), "InschrijfStatus")
## StudieUitslagsoort
ggplot_cat(Inschrijvingen_df, StudieUitslagsoort, seq(0, 600, 100), "StudieUitslagsoort", 45)
## StudieUitslag
ggplot_cat(Inschrijvingen_df, StudieUitslag, seq(0, 500, 50), "StudieUitslag", 90)


### KlasDeelnames ###
attach(KlasDeelnames_df)
## Klas
ggplot_cat(KlasDeelnames_df, Klas, seq(0, 40, 5), "Klas")
## BeginDatum
ggplot_cat(KlasDeelnames_df, BeginDatum, seq(0, 400, 50), "BeginDatum")
## EindDatum
ggplot_cat(KlasDeelnames_df, EindDatum, seq(0, 400, 20), "EindDatum")


### LessenDocent ###
attach(LessenDocent_df)
## ldi_ProgrammaCode
ggplot_cat(LessenDocent_df, ldi_ProgrammaCode, seq(0, 300, 25), "ldi_ProgrammaCode")
## ldi_StudieJaar
ggplot_cat(LessenDocent_df, ldi_StudieJaar, seq(0, 180, 20), "ldi_StudieJaar")
## ldi_Vestiging
ggplot_cat(LessenDocent_df, ldi_Vestiging, seq(0, 180, 20), "ldi_Vestiging")
## ldi_OWECode
ggplot_cat(LessenDocent_df, ldi_OWECode, seq(0, 100, 10), "ldi_OWECode")
## ldi_Suffix
ggplot_cat(LessenDocent_df, ldi_Suffix, seq(0, 200, 20), "ldi_Suffix")
## ldi_Periode
ggplot_cat(LessenDocent_df, ldi_Periode, seq(0, 160, 20), "ldi_Periode")
## ldi_Klascode
ggplot_cat(LessenDocent_df, ldi_Klascode, seq(0, 12, 1), "ldi_Klascode", 45)


### OnderwijsEenheidResultaten ###
attach(OnderwijsEenheidResultaten_df)
## NrToetscijfers
ggplot_cont(OnderwijsEenheidResultaten_df, NrToetscijfers, "NrToetscijfers")
## Resultaat
ggplot_cont(OnderwijsEenheidResultaten_df, Resultaat, "Resultaat")
## OnderwijsEenheid
ggplot_cat(OnderwijsEenheidResultaten_df, OnderwijsEenheid, seq(0, 700, 100), "OnderwijsEenheid")
## EersteToetsKansOp
ggplot_date(OnderwijsEenheidResultaten_df, EersteToetsKansOp, 35, seq(0, 650, 50), "EersteToetsKansOp")
## LaatsteToetsKansOp 
ggplot_date(OnderwijsEenheidResultaten_df, LaatsteToetsKansOp, 35, seq(0, 500, 50), "LaatsteToetsKansOp")


### Studenten ###
attach(Studenten_df)
## Geslacht
ggplot_cat(Studenten_df, Geslacht, seq(0, 700, 100), "Geslacht")
## Woonplaats_PostcodeRegio
ggplot_cat(Studenten_df, Woonplaats_PostcodeRegio, seq(0, 140, 10), "Woonplaats_PostcodeRegio")
## PropedeuseOrientatie
ggplot_cat(Studenten_df, PropedeuseOrientatie, seq(0, 380, 20), "PropedeuseOrientatie")
## Profiel
ggplot_cat(Studenten_df, Profiel, seq(0, 260, 20), "Profiel")
## VooropleidingNiveau
ggplot_cat(Studenten_df, VooropleidingNiveau, seq(0, 360, 20), "VooropleidingNiveau")
## Vooropleiding
ggplot_cat(Studenten_df, Vooropleiding, seq(0, 100, 10), "Vooropleiding", 90)
## Vooropl_DiplomaDatum
ggplot_date(Studenten_df, Vooropl_DiplomaDatum, 350, seq(0, 500, 50), "Vooropl_DiplomaDatum")
## VooropleidingPlaats
ggplot_cat(Studenten_df, VooropleidingPlaats, seq(0, 120, 10), "VooropleidingPlaats", 90)


### ToetsResultaten ###
attach(ToetsResultaten_df)
## Resultaat
ggplot_cont(ToetsResultaten_df, Resultaat, "Resultaat")
## OnderwijsEenheid
ggplot_cat(ToetsResultaten_df, OnderwijsEenheid, seq(0, 4000, 500), "OnderwijsEenheid")
## Toetscode
ggplot_cat(ToetsResultaten_df, Toetscode, seq(0, 1100, 100), "Toetscode")
## CijferBehaald
ggplot_date(ToetsResultaten_df, CijferBehaald, 15, seq(0, 1000, 100), "CijferBehaald")
## Onvoldoende
ggplot_cat(ToetsResultaten_df, Onvoldoende, seq(0, 8500, 500), "Onvoldoende")


#===============================
#========== Boxplots ===========
#===============================

### Inschrijvingen ###
attach(Inschrijvingen_df)
## LeeftijdStudent_op_Vandatum
ggplot_box(Inschrijvingen_df, LeeftijdStudent_op_Vandatum, seq(0, 50, 5), "LeeftijdStudent_op_Vandatum")
## LeeftijdStudent_op_Totdatum
ggplot_box(Inschrijvingen_df, LeeftijdStudent_op_Totdatum, seq(0, 50, 5), "LeeftijdStudent_op_Totdatum")

### OnderwijsEenheidResultaten ###
attach(OnderwijsEenheidResultaten_df)
## NrToetscijfers
ggplot_box(OnderwijsEenheidResultaten_df, NrToetscijfers, seq(0, 13, 0.5), "NrToetscijfers")
## Resultaat (OnderwijsEenheidResultaten)
ggplot_box(OnderwijsEenheidResultaten_df, Resultaat, seq(0, 11, 0.5), "Resultaat")

### ToetsResultaten ###
attach(ToetsResultaten_df)
## Resultaat (ToetsResultaten)
ggplot_box(ToetsResultaten_df, Resultaat, seq(0, 105, 5), "Resultaat")
