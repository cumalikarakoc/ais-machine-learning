

studenten <- read.csv(file="studenten_data.csv", sep = ",", dec=".", strip.white = TRUE,
                     check.names = FALSE)



# Geslacht
ggplot(studenten,aes(x=Geslacht)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 100)) +
  theme_bw()



#Woonplaats_PostcodeRegio

ggplot(studenten,aes(x=Woonplaats_PostcodeRegio)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 30)) +
  scale_x_continuous(breaks= seq(0, 3500, 10))+
  theme_bw()



#PropedeuseOrientatie
ggplot(studenten,aes(x=PropedeuseOrientatie)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 50)) +
  theme_bw()




#Profiel
ggplot(studenten,aes(x=Profiel)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 25)) +
  theme_bw()



#VooropleidingNiveau
ggplot(studenten,aes(x=VooropleidingNiveau)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 50)) +
  theme_bw()




#Vooropleiding
ggplot(studenten,aes(x=Vooropleiding)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 10)) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




#Vooropl_DiplomaDatum
ggplot(studenten,aes(x=Vooropl_DiplomaDatum)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 20)) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




#VooropleidingPlaats
ggplot(studenten,aes(x=VooropleidingPlaats)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 25)) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




