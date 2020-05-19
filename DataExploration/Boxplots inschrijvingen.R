setwd("//mac/Home/Desktop/AIS Project/data onderzoek")

Inschrijvingen <- read.csv(file="inschrijvingen_data.csv", sep = ",", dec=".", strip.white = TRUE,
                           check.names = FALSE)


ggplot(Inschrijvingen,aes(y=leeftijdStudent_op_Totdatum)) +
  geom_boxplot(fill="#54a684") 


ggplot(Inschrijvingen,aes(y=LeeftijdStudent_op_Vandatum)) +
  geom_boxplot(fill="#54a684") 

