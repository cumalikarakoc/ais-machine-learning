library(ggplot2)
library(RODBC)
library(dplyr)

sql_conn <- odbcConnect("SAS_ML_FILT")
ToetsResultaten_df <- sqlQuery(sql_conn, "select * from ToetsResultaten")

### ToetsResultaten ###

## OnderwijsEenheid
ggplot(ToetsResultaten_df,aes(x=OnderwijsEenheid)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 250)) +
  theme_bw()

## Toetscode
ggplot(ToetsResultaten_df,aes(x=Toetscode)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 800, 100)) +
  theme_bw()

## CijferBehaald
ggplot(ToetsResultaten_df,aes(x=CijferBehaald)) + 
  geom_histogram(binwidth = 15,
                 color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 1200, 200)) +
  theme_bw()

## Resultaat
ggplot(ToetsResultaten_df,aes(x=Resultaat)) + 
  geom_histogram(binwidth = 3,
                 color="Black",
                 fill="#54a684") +
  scale_x_continuous(name="Resultaat",
                     breaks= seq(0, 100, 10)) + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 1000, 100)) +
  theme_bw()

## Toetscode
ggplot(ToetsResultaten_df,aes(x=Onvoldoende)) + 
  geom_bar(color="Black",
           fill="#54a684") +
  scale_x_continuous(name="Onvoldoende",
                     breaks= seq(0, 1, 1)) + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 8000, 500)) +
  theme_bw()
