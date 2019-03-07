#Extra Credit Bird Assignment
### By Chase Jenson


#First Load Tidyverse because
library(tidyverse)


#load in Bird measurement data
bird=read.csv("./Bird_Measurements.csv")

#Look at ALL of the wierd collums. Let's fix it. 
names(bird)


#We are going to work on the collums that are deal with gender in them 
#Before we do lets label the collums that don't have that. Let's call them 'important."
impt.cols = c(1:4,35:37)


#In order to simply it. We can find all of the collums that end in mass

mass=grep("mass$",(names(bird)))[-4]  

#Then we create a data that has the important collums and the collums that end in mass
bird.mass=bird[,c(impt.cols,mass)]

# Lets gather the collums and have a new collum of sex and Mass
mass.long=gather(bird.mass,Sex,Mass,8:10)

#Let's make it look a littler prettier
mass.long$Sex=str_remove(mass.long$Sex,"_mass")      


#Lets repeat the process a few more times 
mass_N=grep("mass_N",(names(bird)))
bird.mass.n=bird[,c(impt.cols,mass_N)]
mass.long.n=gather(bird.mass.n,Sex,Mass_N,8:10)
mass.long.n$Sex=str_remove(mass.long$Sex,"_mass_N")   

wing=grep("wing$",(names(bird)))
bird.wing=bird[,c(impt.cols,wing)]
wing.long=gather(bird.wing,Sex,Wing,8:10)
wing.long$Sex=str_remove(wing.long$Sex,"_wing")   

wing_N=grep("wing_N",(names(bird)))
bird.wing_N=bird[,c(impt.cols,wing_N)]
wing_N.long=gather(bird.wing_N,Sex,wing_N,8:10)
wing_N.long$Sex=str_remove(wing_N.long$Sex,"_wing_N")   

tarsus=grep("tarsus$",(names(bird)))
bird.tarsus=bird[,c(impt.cols,tarsus)]
tarsus.long=gather(bird.tarsus,Sex,tarsus,8:10)
tarsus.long$Sex=str_remove(tarsus.long$Sex,"_tarsus")   

tarsus_N=grep("tarsus_N",(names(bird)))
bird.tarsus_N=bird[,c(impt.cols,tarsus_N)]
tarsus_N.long=gather(bird.tarsus_N,Sex,tarsus_N,8:10)
tarsus_N.long$Sex=str_remove(tarsus_N.long$Sex,"_tarsus_N")   

bill=grep("bill$",(names(bird)))
bird.bill=bird[,c(impt.cols,bill)]
bill.long=gather(bird.bill,Sex,bill,8:10)
bill.long$Sex=str_remove(bill.long$Sex,"_bill")   

bill_N=grep("bill_N",(names(bird)))
bird.bill_N=bird[,c(impt.cols,bill_N)]
bill_N.long=gather(bird.bill_N,Sex,bill_N,8:10)
bill_N.long$Sex=str_remove(bill_N.long$Sex,"_bill_N")   

tail=grep("tail$",(names(bird)))
bird.tail=bird[,c(impt.cols,tail)]
tail.long=gather(bird.tail,Sex,tail,8:10)
tail.long$Sex=str_remove(tail.long$Sex,"_tail")   

tail_N=grep("tail_N",(names(bird)))
bird.tail_N=bird[,c(impt.cols,tail_N)]
tail_N.long=gather(bird.tail_N,Sex,tail_N,8:10)
tail_N.long$Sex=str_remove(tail_N.long$Sex,"_tail_N")   

#Now we have a ton of documents. We can then make a data frame from all the new collums and the important collums
# Lets call it ultrabirds, because this mess is ultra
ultrabirds=data.frame(Family=bill.long$Family,
                      Species_Number=bill.long$Species_number,
                      Species_Name=bill.long$Species_name,
                      English_Name=bill.long$English_name,
                      Sex=bill.long$Sex,
                      Mass=mass.long$Mass,
                      Mass_N=mass.long.n$Mass_N,
                      Wing=wing.long$Wing,
                      Wing_N=wing_N.long$wing_N,
                      Tarsus=tarsus.long$tarsus,
                      Tarsus_N=tarsus_N.long$tarsus_N,
                      Bill=bill.long$bill,
                      Bill_N=bill_N.long$bill_N,
                      Cultch_Size=bill.long$Clutch_size,
                      Egg_Mass=bill.long$Egg_mass,
                      Mating_System=bill.long$Mating_System)

#I know other ways to do it. I did it this way to have control over data organization. 


#There still is data intermixed. Lets have all the measurements labeled out. 
ultrabirds=gather(ultrabirds,Item,Measurment,c(6:16))

#I am not sure if we want the NA values. Lets make a second one without the NA values. 
ultrabirds.fill=na.omit(ultrabirds)

#We should make a copy of all this work to show off. Or to use in the future. 
write.csv(ultrabirds.fill,"./Jenson_Bird_Measurement_Extra_Credit.csv")
