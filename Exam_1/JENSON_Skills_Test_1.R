library(readxl)
library(tidyverse)
df=read.csv(file="./DNA_Conc_by_Extraction_Date.csv",head = TRUE, sep="")

hist(df$DNA_Concentration_Katy,
     main= "DNA Concentration Katy",
     xlab= "Concentration")

hist(df$DNA_Concentration_Ben,
     main= "DNA Concentration Ben",
     xlab= "Concentration")

jpeg(filename = "JENSON_Plot1.jpeg")
ggplot(df,aes(x=Year_Collected,y=DNA_Concentration_Katy, group=Year_Collected)) +
  geom_boxplot() + ggtitle("Katy's Extractions") +
  xlab("Year") + ylab("DNA Concentration") +  theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
   panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +  
  theme(plot.title = element_text(hjust = 0.5)) 
dev.off

jpeg(filename = "JENSON_Plot2.jpeg")
ggplot(df,aes(x=Year_Collected,y=DNA_Concentration_Ben, group=Year_Collected)) +
  geom_boxplot() + ggtitle("Bens's Extractions") +
  xlab("Year") + ylab("DNA Concentration") +  theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +  
  theme(plot.title = element_text(hjust = 0.5)) 
dev.off


Katy_Year_Average=aggregate(df[, 4], list(df$Year_Collected), mean)
Ben_Year_Average=aggregate(df[, 5], list(df$Year_Collected), mean)


