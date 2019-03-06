df = read.csv("./landdata-states.csv") 
class(df) 
head(df) 


class(df$State)
class(df$Date)

dim(df) 
str(df) 
summary(df)


hist(df$Land.Value) 
plot(x=df$region,y=df$Land.Value)

class(df$region)
class(df$Land.Value)

plot(x=df$Year,y=df$Land.Value)

plot(x=df$Year,y=df$Land.Value,col=df$region)

df2=read.delim("./ITS_mapping.csv")
summary(df2)

png(filename = "./silly_boxplot.png")
plot(x=df2$Ecosystem,y=df2$Lat, main="Silly_Boxplot",xlab="Ecosystem", ylab= "Lat" )
dev.off()