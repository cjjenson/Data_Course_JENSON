#1. load the “/Data/mushroom_growth.csv” data set
library(tidyverse)
library(MASS)
library(modelr)
df=read.csv("./mushroom_growth.csv")


#2. creates several plots exploring relationships between the response and predictors 

ggplot(df, aes(x=Nitrogen,y=GrowthRate,col=Species)) +geom_point() + geom_smooth(method="lm")
ggplot(df, aes(x=Light,y=GrowthRate,col=Species)) +geom_point() + geom_smooth(method="lm")
ggplot(df, aes(x=Humidity,y=GrowthRate,col=Species)) + geom_jitter() 
ggplot(df, aes(x=Temperature,y=GrowthRate,col=Species)) +geom_point() + geom_smooth(method="lm")
#3. defines at least 2 models that explain the dependent variable “GrowthRate”
mod1 = lm(GrowthRate ~ Nitrogen*Light*Humidity*Temperature, data = df)
summary(mod1)


mod2=lm(formula = GrowthRate ~ Nitrogen + Light + Humidity + Temperature + 
     Nitrogen:Light + Light:Humidity + Humidity:Temperature, data = df)
summary(mod2)


mod3 = aov(GrowthRate ~ Nitrogen+Light+Humidity+Temperature, data = df)
summary(mod3)









#4. calculates the mean sq. error of each model
df = add_predictions(df, mod1, var= "mod1")
df = add_predictions(df, mod2, var= "mod2")
df = add_predictions(df, mod3, var="mod3")



df=mutate(df, DIFF1 = abs(mod1 -GrowthRate))
df=mutate(df, DIFF2 = abs(mod2 -GrowthRate))
df=mutate(df, DIFF3 = abs(mod3 -GrowthRate))


mean(df$DIFF1)
mean(df$DIFF2)
mean(df$DIFF3)

#5. selects the best model you tried

anova(mod1, mod2)
anova(mod2, mod3)
anova(mod1,mod3)

stepAIC(mod1)
stepAIC(mod2)
stepAIC(mod3)
#6. adds predictions based on new values for the independent variables used in your model 
df = add_predictions(df, mod1, var= "mod1")
df = add_predictions(df, mod2, var= "mod2")
df = add_predictions(df, mod3, var="mod3")

#7. plots these predictions alongside the real data
ggplot(df, aes(x=Light)) +
  geom_jitter(aes(y=GrowthRate), alpha=.5) +
  geom_jitter(aes(y=mod1), color="Red") +
  geom_jitter(aes(y=mod2), color="Blue") + 
  geom_jitter(aes(y=mod3), color="Green") 







