#SKILLS TEST 1
#_____________


#Do a fresh "git pull" to get the skills test files.
#The files you will need are:
#  DNA_Conc_by_Extraction_Date.csv
#ZAHN_Plot1.jpeg #this is an example for you to try and duplicate
#ZAHN_Plot2.jpeg #same as above
#README.txt #this file containing the test prompts

#The DNA_Conc_by_Extraction_Date.csv file is data from old DNA extractions. I had two lab students perform PCR on these extractions to see if older DNA extractions would be harder to amplify.

#Originally, my student Katy did PCR and measured the resultant DNA concentrations, but they seemed pretty low...
#So I had a second student, Ben, perform the same PCR reactions so I could see if this was consistent.
#Incidentally, some of the PCRs were done in one lab and some in another.

#The columns in this file are as follows:
#  "Extract.Number"         	Simply a number identifying the extraction order
#"Year_Collected"         	The year the DNA was originally extracted before being put into deep freeze
#"Extract.Code"           	A lab-specific code for each extraction ... don't worry about this one
#"Date_Collected"        	The date the DNA was originally extracted in the format YYYY-MM-DD
#"DNA_Concentration_Katy" 	The DNA concentration that Katy got after PCR of that extraction
#"DNA_Concentration_Ben"  	The DNA concentration that Ben got after PCR of that extraction
#"Lab"       			The lab room where PCR was performed ("Upstairs" or "Downstairs")


########################
##### YOUR TASKS #######
########################

# Before anything else, make yourself a new directory in your personal Git Repository called "Exam_1"
# Start a new RProject in there called Exam_1.Rproj
# Copy the four files in MY Exam_1 directory into your own Exam_1 directory
# Create a new R script (this will have all your code for your exam) in YOUR Exam_1 directory
# Name it LASTNAME_Skills_Test_1.R
# This way, I can do a "git pull" in your repository and run your R script using your relative filepaths


#I. 	
#Once you get the file loaded into an R object as a data frame, feel free to do some exploratory visualizations or summaries to get a feel for the data if you like.
#Your first task, though, is to create separate histograms of the DNA concentrations for Katy and Ben. Make sure to add nice labels to these (x-axis and main title).
df=read.delim("./DNA_Conc_by_Extraction_Date.csv")
hist(df$DNA_Concentration_Katy,xlab= "Katy's Concentration", main= "Katy's Concentration")
hist(df$DNA_Concentration_Ben,xlab= "Ben's Concentration", main= "Ben's Concentration")

#II. 	
#Your second task is to look at DNA concentrations from the different extraction years. 
#One way to do this in a separate figure for each student is demonstrated in those two files:	ZAHN_Plot1.jpeg and ZAHN_Plot2.jpeg 
#Open those files in some image viewing program and take a look. I'd like you to re-create these exactly, including the labels.
#This is tricky, so I'll give a hint: the plot() function behaves differently depending on the classes of vectors that are given to it.
plot(x=factor(df$Year_Collected),y=df$DNA_Concentration_Katy, main="Katy's Extractions", xlab="Year", ylab="DNA Concentration")  

plot(x=factor(df$Year_Collected),y=df$DNA_Concentration_Ben, main="Ben's Extractions", xlab="Year", ylab="DNA Concentration")  
#III.
#Once you have your code for creating the figures correctly, you need to save those two images in YOUR Exam_1 directory. Name them similarly to how I named mine.
#Make sure your code is saving the files. Don't do it manually with the mouse!
jpeg(filename = "JENSON_Plot1")
plot(x=factor(df$Year_Collected),y=df$DNA_Concentration_Katy, main="Katy's Extractions", xlab="Year", ylab="DNA Concentration")  
dev.off()

jpeg(filename = "JENSON_Plot2")
plot(x=factor(df$Year_Collected),y=df$DNA_Concentration_Ben, main="Ben's Extractions", xlab="Year", ylab="DNA Concentration")  
dev.off()  
#  IV.
#Take a look at Ben's concentrations vs Katy's concentrations. 
#You can do this however you like... with a plot or with summary stats or both.
#It looks like Ben had consistently higher DNA yields than Katy did...but surely it wasn't uniformly better, right? With some samples, he only had a marginal improvement over Katy.
#With other samples, he had a relatively massive improvement over her.
#Your task here is to write some code that tells us: in which extraction YEAR, was Ben's performance the lowest RELATIVE TO Katy's performance?


library(tidyverse)

df %>% filter(Year_Collected > 2005) %>%  mutate(SUM= DNA_Concentration_Ben + DNA_Concentration_Katy)
df2=df %>% filter(Year_Collected > 2005) %>%  mutate(SUM= DNA_Concentration_Ben + DNA_Concentration_Katy)

df3= df %>% group_by(Year_Collected) %>% summarise(N= n(), MeanBEN = mean(DNA_Concentration_Ben), MeanKATY = mean(DNA_Concentration_Katy))
df3$diff=df3$MeanBEN-df3$MeanKATY
df3[which.max(df3$diff),]

#V.
#For this final problem, let's just look at Ben's DNA concentration values. 
#I think Katy messed up her PCRs, and at any rate, we can't use them for sequencing.
#Besides, our original purpose for this experiment was to see if DNA extractions sitting in a freezer degraded over time.
#To that end, I want you to make a new data frame (just using Ben's values) that has one column containing the years that DNA extractions were made, 
#and another column that contains the AVERAGE of the values within that year. 
#Just to be clear, this data frame should have only 12 rows (one for each year)! You will need to find a way to take the average of Ben's DNA values in each separate year. 
#A for-loop, or repeated subsetting, or some other way...
#Once you have this new data frame of averages by year, write some code that shows which extraction year has the highest average DNA concentration (and what that concentration is)


df4= df %>% group_by(Year_Collected) %>% summarise(N= n(), MeanBEN = mean(DNA_Concentration_Ben), SDBen =sd(DNA_Concentration_Ben))


df5= df %>% group_by(Year_Collected) %>% summarise(MeanBEN = mean(DNA_Concentration_Ben))

write.csv(df5,file="./Ben_average_by_year.csv")

df5[which.max(df5$MeanBEN),]


#VI.
#Push the following to your github web page in your new Exam_1 directory:
#1. Boxplot of DNA concentration values by year for Katy
#2. Boxplot of DNA concentration values by year for Ben
#3. Your .csv file of a data frame with YEAR as column 1 and Ben_Average_Conc as column 2 (named "Ben_average_by_year.csv")
#4. Your complete R script file, saved as LASTNAME_Skills_Test_1.R
