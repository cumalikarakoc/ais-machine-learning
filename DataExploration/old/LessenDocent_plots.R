library(ggplot2)
library(RODBC)
library(dplyr)

sql_conn <- odbcConnect("SAS_ML_FILT")
LessenDocent_df <- sqlQuery(sql_conn, "select * from LessenDocent")

### LessenDocent ###

## ldi_ProgrammaCode
ggplot(LessenDocent_df,aes(x=ldi_ProgrammaCode)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 300, 25)) +
  theme_bw()

## ldi_StudieJaar
ggplot(LessenDocent_df,aes(x=ldi_StudieJaar)) + 
  geom_bar(color="Black",
           fill="#54a684") +
  scale_x_continuous(name="ldi_StudieJaar",
                     breaks= seq(2018, 2019, 1)) + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 150, 15)) +
  theme_bw()

## ldi_Vestiging
ggplot(LessenDocent_df,aes(x=ldi_Vestiging)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 150, 15)) +
  theme_bw()

## ldi_OWECode
ggplot(LessenDocent_df,aes(x=ldi_OWECode)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 75, 5)) +
  theme_bw()

## ldi_Suffix
ggplot(LessenDocent_df,aes(x=ldi_Suffix)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 100, 5)) +
  theme_bw()

## ldi_Periode
ggplot(LessenDocent_df,aes(x=ldi_Periode)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 120, 10)) +
  theme_bw()

## ldi_Klascode
ggplot(LessenDocent_df,aes(x=ldi_Klascode)) + 
  geom_bar(color="Black",
           fill="#54a684") + 
  scale_y_continuous(name="Count",
                     breaks= seq(0, 20, 1)) +
  theme_bw()
