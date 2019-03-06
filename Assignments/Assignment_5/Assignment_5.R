#1.  loads the mtcars data set
df=mtcars
data("mtcars")
str(mtcars)

#2.  subsets the mtcars dataframe to include only **automatic transmissions**
automatic=mtcars %>% filter(am == 0)


# 3.  saves this new subset as a new file called "automatic_mtcars.csv" in your Assignment_5 directory
write.csv(automatic, "./automatic_mtcars.csv")

#4  plots the effect of horsepower on miles-per-gallon (update plot to have meaningful labels and title)

plot(x=mtcars$hp, y=mtcars$mpg, main="Horsepower Vs. Miles-Per-Gallon", xlab="Horsepower", ylab="Miles-Per-Hour")

#5 saves this plot as a png image called "mpg_vs_hp_auto.png" in your Assignment_5 directory

png(filename = "./mpg_vs_hp_auto.png")
plot(x=mtcars$hp, y=mtcars$mpg, main="Horsepower Vs. Miles-Per-Gallon", xlab="Horsepower", ylab="Miles-Per-Hour")
dev.off()

#6.  plots the effect of weight on miles-per-gallon (with improved labels, again)

plot(x=mtcars$wt, y=mtcars$mpg, main="Weight Vs. Miles-Per-Gallon", xlab="Weight", ylab="Miles-Per-Hour")

#7.  saves this second plot as a **tiff** image called "mpg_vs_wt_auto.tiff" in your Assignment_5 directory
tiff(filename="./mpg_vs_wt_auto.tiff")
plot(x=mtcars$wt, y=mtcars$mpg, main="Weight Vs. Miles-Per-Gallon", xlab="Weight", ylab="Miles-Per-Hour")
dev.off()

#8.  subsets the original mtcars dataframe to include only cars with displacements less than or equal to 200 cu.in.
library(tidyverse)
cars200 = mtcars %>% filter(disp <= 200)

#9.  saves that new subset as a csv file called mtcars_max200_displ.csv

write.csv(cars200,"./mtcars_max200_displ.csv")




#10. includes code to calculate the maximum horsepower for each of the three dataframes (original, automatic, max200)



maxhp=c(max(mtcars$hp),max(automatic$hp), max(cars200$hp))

#below is another way that includes that colum labels

mtcarsmax =max(mtcars$hp)
automaticmax=max(automatic$hp)
cars200max=max(cars200$hp)

maxhp=data.frame(Automatic=automaticmax, Cars200= cars200max, Mtcars=mtcarsmax)

#11. prints these calculations (from task 10) in a readable format to a new plaintext file called hp_maximums.txt


write.table(maxhp, file="./hp_maximums.txt", sep="\t")

\\

