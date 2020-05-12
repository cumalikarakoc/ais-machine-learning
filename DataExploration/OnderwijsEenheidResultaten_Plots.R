library(RODBC)
library(dplyr)

##install.packages("rstatix")
sql_conn <- odbcConnect("SAS_ML")
OnderwijsEenheidResultaten_df <-
  sqlQuery(sql_conn, "select * from OnderwijsEenheidResultaten")

####histogrammen
library(ggplot2)

#NrToetscijfers
ggplot(OnderwijsEenheidResultaten_df,aes(x=NrToetscijfers)) +
  geom_histogram(bins = 1, binwidth = 1
                 ,color="Black",
                 fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 500)) +
  theme_bw()

#TeBehalenStpt
ggplot(OnderwijsEenheidResultaten_df,aes(x=TeBehalenStpt)) +
  geom_bar(bins = 1, binwidth = 1
                 ,color="Black",
                 fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 500)) +
  theme_bw()

#resultaat
ggplot(OnderwijsEenheidResultaten_df,aes(x=Resultaat)) +
  geom_histogram(bins = 1, binwidth = 1
                 ,color="Black",
                 fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 500)) +
  scale_x_continuous(name="Resultaat",
                     breaks= seq(0, 10,1))+
  theme_bw()

## Barplots

#OnderwijsEenheid
ggplot(OnderwijsEenheidResultaten_df,aes(x=OnderwijsEenheid)) +
  geom_bar(width = 0.4
           ,color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 1000,100)) +
  theme_bw()

#EersteToetsKansOp
ggplot(OnderwijsEenheidResultaten_df,aes(x=EersteToetsKansOp ))+   
  geom_bar(color="Black", fill="#54a684") +
  scale_y_continuous(name="Count",  
                     breaks= seq(0, 3500, 20)) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#LaatsteToetsKansOp 
ggplot(OnderwijsEenheidResultaten_df,aes(x=LaatsteToetsKansOp ))+   
  geom_bar(color="Black", fill="#54a684") +
  scale_y_continuous(name="Count",  
                     breaks= seq(0, 3500, 20)) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
