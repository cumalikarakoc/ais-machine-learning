

beroepsp <- read.csv(file="IngeleverdeBeroepsproducten_data.csv", sep = ",", dec=".", strip.white = TRUE,
                     check.names = FALSE)
names(beroepsp)


# OnderwijsEenheid  
ggplot(beroepsp,aes(x=OnderwijsEenheid)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 200)) +
  theme_bw()



#Toets 
ggplot(beroepsp,aes(x=Toets)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 100)) +
  theme_bw()



#Plaatsingsdatum
ggplot(beroepsp,aes(x=Plaatsingsdatum)) +
  geom_bar(color="Black",
           fill="#54a684") +
  scale_y_continuous(name="Count",
                     breaks= seq(0, 3500, 50)) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



