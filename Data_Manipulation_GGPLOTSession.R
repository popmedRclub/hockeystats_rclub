###### Data Manipulation ######

#What is tidyverse?
#library(tidyverse) will load the core tidyverse packages:
#ggplot2, for data visualisation.
#dplyr, for data manipulation.
#tidyr, for data tidying.
#readr, for data import.
#purrr, for functional programming.
#tibble, for tibbles, a modern re-imagining of data frames.
#stringr, for strings.
#forcats, for factors.


#Before we start the fun stuff, remember to set your working directory- this tells R studio to access your files from a certain folder! 

setwd("~/Desktop/Rclub") #set working directory

library("tidyverse") #notice what packages are loaded! 
library("openxlsx") #this allows us to open "xlsx" files (default files from excel)

#upload our dataframes
hockey_stats <- read_csv("top_5_points_oct30.csv") #hockey stats
players_fruit_pets <- read.xlsx("hockey_fruit_pet.xlsx") #favourite fruit and do they have a pet?

#***disclaimer -> fruit and pet are fictional 

#let's join the two dataframes together 

view(hockey_stats)
view(players_fruit_pets)

hockey_stats_fruit_pets <- inner_join(hockey_stats, players_fruit_pets, by = "Player")
view(hockey_stats_fruit_pets)

#let's say we want to look at all the columns that start with G, while we have a small dataset and can just look at the entire table --> this is useful for LARGE datasets 

select(hockey_stats_fruit_pets, Player, contains("G"))

#you can save these as a new datafeame
filtered_hockey_team_P <- select(hockey_stats_fruit_pets, Team, contains("P"))
filtered_hockey_team_P

#since the season is a bit redundant, let's select season and remove it from the dataset
hockey_stats_fruit_pets <- select(hockey_stats_fruit_pets, -("Season"))
hockey_stats_fruit_pets 

#instead of selectng based on somthing containing "P", you can select columns that end with...
select(hockey_stats_fruit_pets, Team, ends_with("et"))

#here are others ways you can select through your dataframe
#ends_with
#matches
#num_range

#we want to figure out how many players are in each team 
Team_stats_P <- hockey_stats_fruit_pets %>%
  group_by(Team) %>% 
  count(Team)
Team_stats_P

#how many players per team?
Team_stats_P

#let's calculate the mean of Goals based on team

Team_stats_G <- hockey_stats_fruit_pets %>%
  group_by(Team) %>% 
  summarize(meanG = mean(G)) %>%
  arrange(desc(meanG)) 
#what team has the lowest amount of Goals?
Team_stats_G 

#let's join the two 
Playersperteam_goals<- inner_join(Team_stats_P, Team_stats_G, by = "Team")
Playersperteam_goals


#teaser
#just to visualize -> more on this next week! 
ggplot(Playersperteam_goals, aes(x=Team, y=meanG)) +
  geom_col() +
  coord_fixed() +
  labs(title="NHL stats: Average Goals per Team",
       x="Team",
       y="Average # Goals") +
  theme_classic()

hockey_stats_fruit_pets


#how many different pets and number of each pets
Team_stats_Pet <- hockey_stats_fruit_pets %>%
  group_by(Pet) %>% 
  count(Pet)
Team_stats_Pet

#let's filter out the players that don't have pets
hockey_stats_pets <- filter(hockey_stats_fruit_pets, Pet != "None")


#from there, lets filter out the players who don have a dog
hockey_stats_dog <- filter(hockey_stats_pets, Pet == "Dog")
hockey_stats_dog # let's look
#OR 
hockey_stats_dog2 <- filter(hockey_stats_fruit_pets, Pet != "Dog")
hockey_stats_dog2# let's look


#let's filter those who like apples and have a cat
hockey_stats_apples_cats <- filter(hockey_stats_fruit_pets, Pet == "Cat" & Fruit=="Apple")
hockey_stats_apples_cats# let's look

#let's filter out those who don't like apples but have a cat
hockey_stats_noapples_cats <- filter(hockey_stats_fruit_pets, Pet == "Cat" | Fruit!="Apple")
hockey_stats_noapples_cats #let's look



#lets's filter out those who scored more or 4 goals AND have a pet rabbit
hockey_stats_4goals_rabbit <- filter(hockey_stats_fruit_pets, Pet == "Rabbit" & G >= 4)

#oh no! it doesn't work... 

hockey_stats_fruit_pets #let's look

#ah, rabbit is spelled wrong... (Rabit)
#let's fix that
hockey_stats_fruit_pets[["Pet"]] <- recode(hockey_stats_fruit_pets[["Pet"]], "Rabit" = "Rabbit")
hockey_stats_fruit_pets #let's look 

hockey_stats_4goals_rabbit <- filter(hockey_stats_fruit_pets, Pet == "Rabbit" & G >= 4)

hockey_stats_4goals_rabbit #it worked!

#what if we wanted players with a rabit OR had at least 4 goals
hockey_stats_4goals_rabbit <- filter(hockey_stats_fruit_pets, Pet == "Rabbit" | G >= 4)
hockey_stats_4goals_rabbit 

#| is an OR sign, so we want people who had at least 4 goals OR Rabbit as a pet
# using the &, there was no one who had at least 4goals and a Rabbit as a pet


#there's only 1 player who has a snake, find that person using filter
hockey_stats_snake <- filter(hockey_stats_fruit_pets, Pet == "Snake")
hockey_stats_snake


#let's rename all my columns to lower case
#hockey_stats_fruit_pets <- rename_all(.tbl=hockey_stats_fruit_pets, .funs=tolower)
#hockey_stats_fruit_pets

#actually... never mind, I want all my columns to be upper case
#hockey_stats_fruit_pets <- rename_all(.tbl=hockey_stats_fruit_pets, .funs=toupper)
#hockey_stats_fruit_pets 


#pairwise.wilcox.test(hockey_stats_fruit_pets$GOALS, hockey_stats_fruit_pets$NHL_TEAM)


#finally, let's export this to an excel spreadsheet
#write.xlsx(hockey_stats_fruit_pets, file="hockey_stats_fruit_pets.xlsx")


##################################### ggplot2 ############################################
#geom_jitter, geom_bar, geom_violin, geom_point, geom_col, geom_boxplot

# coord_cartesian



ggplot(Playersperteam_goals, aes(x=Team, y=meanG)) +
  geom_col() +
  coord_fixed() +
  labs(title="NHL stats: Average Goals per Team",
       x="Team",
       y="Average # Goals") +
  theme_classic()


hockey_stats_4goals_rabbit <- filter(hockey_stats_fruit_pets, Pet == "Rabbit" & G >= 4)

hockey_stats_4goals_rabbit


ggplot(hockey_stats_4goals_rabbit, aes(x=Player, y=G, color=Team)) +
  geom_col() +
  scale_color_manual(name=NULL, 
                     values=c("black","red", "yellow", "blue"),
                     breaks=c("BOS", "MTL", "STL", "TOR"),
                     labels=c("BOSTON", "MONTREAL", "ST. LOUIS", "TORONTO")) +
  scale_x_discrete(limits=c("DAVID.PASTRNAK", "BRENDAN.GALLAGHER", "BRAYDEN.SCHENN", "AUSTON.MATTHEWS"),
                   labels=c("David_Pastrnak", "Brendan_Gallagher", "Brayden_Schenn", "Auston_Matthews")) +
  labs(title="Rabbit owners and number of goals",
       x=NULL,
       y="Number of Goals") +
  theme_classic()


hockey_stats_apples_cats <- filter(hockey_stats_fruit_pets, Pet == "Cat" | Fruit=="Apple")
hockey_stats_apples_cats

ggplot (hockey_stats_apples_cats, aes(x=Fruit, y=G, color=Pet)) +
  geom_boxplot() +
  scale_color_manual(name=NULL, 
                     values=c("black","red", "yellow", "blue", "green"),
                     breaks=c("Cat", "Dog", "Fish", "Rabbit","None"),
                     labels=c("Cat", "Dog", "Fish", "Rabbit","None")) +
  labs(title="Fruit, Pets and Goals",
       x=NULL,
       y="Number of Goals") +
  theme_classic()

