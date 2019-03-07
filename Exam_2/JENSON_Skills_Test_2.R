#There are 2 main tasks (I, and II) below:
library(tidyverse)
library(MASS)
library(modelr)
# I. 	Simple tidying exercise

#1.  Read in salaries.csv
#This is faculty salary information from 1995 - Split up by university, state, faculty rank, and university tier
df=read.csv("./salaries.csv")



#2.  Convert to usable tidy format so we can look at "Salary" as a dependent variable (10 points)
salary=gather(df,Rank,Salary,5:7) 

#3.  Create boxplot of salary by University Tier, colored by Faculty Rank (10 points)
#x-axis = Tier
#y-axis = Salary
#Boxplot fill color = Rank
#Title = "Faculty Salaries - 1995"


ggplot(salary, aes(x=Tier, y=Salary, fill=Rank)) + 
  geom_boxplot() +
  ggtitle("Faculty Salaries - 1995") + theme(plot.title = element_text(hjust = 0.5)) 

#4.  Export this delightful boxplot to a file named "LASTNAME_exam2_plot1.jpeg" (10 points)
jpeg("./JENSON_exam2_plot1.jpeg")
ggplot(salary, aes(x=Tier, y=Salary, fill=Rank)) + 
  geom_boxplot() +
  ggtitle("Faculty Salaries - 1995") + 
  theme(plot.title = element_text(hjust = 0.5)) 
dev.off()

#II. Linear modeling and predictions

#1.  Read in atmosphere.csv (pretty clean data set)

df2=read.csv("./atmosphere.csv")

#These are observations of fungal diversity (number of different species) found in air samples along a time series
#SampleID - The unique sample ID for the observation (dd-mm-YYYY)
#Year - What do you think?
 # Quarter - Q1 = Jan/Feb/Mar, Q2 = Apr/May/Jun, etc
#Month - This stands for "Magpie ovulation number..." no, it's just Month
#Mday - Day of the month
#BarcodeSequence - Not important
#Aerosol_Density - Number of detectable particles in the air sample per cubic cm
#CO2_Concentration - CO2 ppm on the day the sample was taken
#Diversity - Number of different fungal species found in the air sample
#Precip - Precipitation on the sampling day (mm)

#2.  Create two different linear models with Diversity as the dependent variable. The second model should have the
#same terms as the first, but an additional one or two terms as well. (10 points)
mod1= lm(Diversity ~  CO2_Concentration, data = df2)

mod2= lm(Diversity ~  Aerosol_Density*CO2_Concentration*Precip, data = df2)

summary(mod1)
summary(mod2)

stepAIC(mod1)
stepAIC(mod2)


#3.  Compare the residuals of the two models and document which has better explanatory power for the data (10 points)
mean(residuals(mod1)^2)
mean(residuals(mod2)^2)
 
######### Mod2 had a squared residual mean of 16337.3 while Mod1 had 370504.3 Mod 2 has the better explanatory power.



#4.  Use these both models to predict Diversity values in the data set (10 points)

df2 = add_predictions(df2, mod1, var="pred1")
df2 = add_predictions(df2, mod2, var= "pred2")

#5.  Make a plot showing actual Diversity values, along with the two models' predicted Diversity values.
 #   Use color or some other aesthetic to differentiate the actual values and both predictions (10 points)

jpeg("./JENSON_exam2_plot2.jpeg")
ggplot(df2, aes(x=CO2_Concentration)) +
  geom_jitter(aes(y=Diversity), alpha=.5) +
  geom_jitter(aes(y=pred1), color="Red") +
  geom_jitter(aes(y=pred2), color="Blue")  +
  ggtitle("Diversity_Prediction") + 
  theme(plot.title = element_text(hjust = 0.5)) 
dev.off
  #  6.  Write code to show the predicted values of Diversity for each model using the hypothetical data 
   # found in hyp_data.csv (10 points)
hyp_data=read.csv("./hyp_data.csv")
hyp_data$mod1.predict=predict(mod1, newdata = hyp_data)
hyp_data$mod2.predict=predict(mod2, newdata = hyp_data)

    #7.  Export a text file that contains the summary output from *both* your models to "model_summaries.txt" (10 points)
summary(mod1)
summary(mod2)

sink("model_summaries.txt")
print(summary(mod1))
print(summary(mod2))
sink() 
    #*Bonus*
    #8.  Add these predicted values (from hypothetical data - Part II, Step 6) to a plot of actual data 
    #and differentiate them by color. (10 bonus points possible for a pretty graph)
jpeg("./JENSON_exam2_plot3.jpeg")
ggplot(df2, aes(x=CO2_Concentration)) +
  geom_jitter(aes(y=Diversity), alpha=.5) +
  geom_jitter(aes(y=pred1), color="Red") +
  geom_jitter(aes(y=pred2), color="Blue")  +
  geom_jitter(data = hyp_data,aes(y=mod1.predict), col="Orange") +
  geom_jitter(data = hyp_data,aes(y=mod2.predict), col="Green")  +
  ggtitle("Diversity_Prediction_With_Hyp_Data") + 
  theme(plot.title = element_text(hjust = 0.5)) 
dev.off()
#Push the following to your github web page in your new Exam_2 directory:
#	1.  Your complete R script for ALL the above tasks, saved as LASTNAME_Skills_Test_2.R
#	2.  Your plot from Part I
#	3.  Any plots generated from Part II
#	5.  A separate R script for importing and cleaning up the bird data (from Tuesday) 
#	    *20 BONUS if your script works and is well-documented*
