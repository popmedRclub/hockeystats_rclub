#make a folder on your desktop and set the working directory here as that folder. 

setwd("~/Desktop/Rclub")

#go to the bottom right quadrant and look under the files tab!

#each package you load understand certain comands.. however, we don't want to load every package we have. Only load what is necessary and if later on you need a package, you can always load one later. 

#we want to constantly save our work, we can do this by saving the R script-> however this disadvantage is we have to run all the code again. To combat this issue we can save it as a project! 


library("tidyverse")
library("readr")

#there are muliple ways to upload a file
#1. through bottom right quadrant OR
#2. code
#tip: unsure the code? as you are doing it the #1, copy and paste the code and keep it for later!


hockey_stats <- read_csv("top_5_points_oct30.csv")

# "<-" this is assigning a name to the task you are doing

#what if you wanted to upload a different type of file?
#there is read_tsv, read_delim, read_file

################################################################################################################################
#want to upload an excel sheet? you use a different package like -> library("openxlsx"), through the help button on the bottom right quadrant, you can look up what that package can do by typing openxlsx!!!
################################################################################################################################

#back to our example

#opens in new window
View(hockey_stats)

#tibble uploads in console
hockey_stats
#understanding types of variables; dbl, chr, num, int, lgl, str

#number of rows
nrow(hockey_stats)
#76

#number of columns
ncol(hockey_stats)
#15

#number of rows and columns
dim(hockey_stats)
#76 15

colnames(hockey_stats)
# [1] "Player"   "Season"   "Team"     "Position" "GP"       "TOI"      "G"       
#[8] "A"        "P"        "P1"       "P.60"     "P1.60"    "GS"       "GS.60"   
#[15] "CF"   

# top portion of table
head(hockey_stats)

#last portion of table
tail(hockey_stats)


summary(hockey_stats)
# Minimum, Q1, median, mean, Q3, max for each column

library("dplyr")
glimpse(hockey_stats)
# structure of dataframe

select(hockey_stats, "Player") 
#v.s
hockey_stats$Player

# counts the number of times each player comes up in Dataframe
count(hockey_stats, Player)

# counts the number of times each total goals comes up in Dataframe
count(hockey_stats, GP)

#this determines the average GP within each team
average_GP <- hockey_stats %>%
  group_by(Team)

# now, find a way to look a table you created (hint: there are MULTIPLE ways)

#now, with TOI, calculate mean AND sd

average_TOI <- hockey_stats %>%
  group_by(Team) %>%
  summarize(mean_TOI = mean(TOI), (sd_TOI = sd(TOI)))


#now, with G, calculate mean AND arrange in descending order
average_G <- hockey_stats %>%
  group_by(Team) %>%
  summarize(mean_G = mean(G)) %>%
  arrange(desc(mean_G))

#how would you arrange in ascending order? (hint: help function --> "arrange" under dyplyr package)

#inner join brings together 2 datasets together using a commonality. If there isn't one, you can specify (hint: help function --> "inner_join")

#what does the "by=NULL" mean? (hint: help function --> inner_join)

average_GperGP <- inner_join(average_GP,average_G, by=NULL)

average_TOIperGP <- inner_join(average_GP,average_TOI, by=NULL)


library("ggplot2")

ggplot(average_GperGP, aes(x=GP, y=mean_G, color=Team)) +
  geom_point(shape=19, size=2) + 
  coord_fixed() +
  labs(title="NHL stats on average # goals based on games played",
       x="Games Played",
       y="Average Goals") +
  theme_classic()

#try saving this document (hint: at least two ways you can do this)



ggplot(average_TOIperGP, aes(x=GP, y=mean_TOI, color=Team)) +
  geom_point(shape=19, size=2) + 
  coord_fixed() +
  labs(title="NHL stats on average TOI based on games played",
       x="Games Played",
       y="TOI") +
  theme_classic()
#looks wonky right? how could we fix the axes? 

#for fun
#try changing the shape and size (hint: use help function --> "ggplot" to look at number scale)


#try changing the plot (hint: use help function --> "ggplot" to look at different "geom_")




