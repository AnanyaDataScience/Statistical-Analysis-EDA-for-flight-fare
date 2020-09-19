rm(list=ls(all=T))
setwd('C:/Users/subha/Desktop/Data Science/Projects/Statistical Analysis')

#Load Libraries
x = c("ggplot2", "corrgram", "DMwR", "caret", "randomForest", "unbalanced", "C50", "dummies", "e1071", "Information",
      "MASS", "rpart", "gbm", "ROSE", 'sampling', 'DataCombine', 'inTrees')
install.packages(x)
lapply(x, require, character.only = TRUE)
rm(x)

#Read the data
setwd('C:/Users/anany/OneDrive/Desktop/DATA SCIENCE/flight')

df = read.csv('flight.csv')
str(df)
-----------------------------------------------------------------------------------------
df$X=NULL
df$Airline=as.factor(df$Airline)
df$Source=as.factor(df$Source)
df$Destination=as.factor(df$Destination)
df$Dep_Time=as.factor(df$Dep_Time)
df$Arrival_Time=as.factor(df$Arrival_Time)
df$Total_Stops=as.factor(df$Total_Stops)
df$Additional_Info=as.factor(df$Additional_Info)
df$Journey_Day=as.factor(df$Journey_Day)
df$Journey_Month=as.factor(df$Journey_Month)
df$weekday=as.factor(df$weekday)
df$Duration=as.numeric(df$Duration)
df$Price=as.numeric(df$Price)

str(df)
-------------------------------------------------------------------------------------------
#Correlation analysis
cor(df$Duration,df$Price)
install.packages("corrgram")
library(corrgram)
numeric_index = sapply(df,is.numeric) #selecting only numeric
numeric_data = df[,numeric_index]

corrgram(df[,numeric_index], order = F,
         upper.panel=panel.pie, text.panel=panel.txt, main = "Correlation Plot")


# Duration can be dropped or kept based on business understanding and correlation of -0.5
# Here it is dropped.
--------------------------------------------------------------------------------------------
#Chi Square analysis
## Chi-squared Test of Independence
factor_index = sapply(df,is.factor)
factor_data = df[,factor_index]

for (i in 1:9)
{
  print(names(factor_data)[i])
  print(names(factor_data)[i+1])
  print(chisq.test(table(factor_data[,i],factor_data[,i+1])))
}
# All the categorical variables are highly correlated with each other
# so one should be kept. But here Airline, Total Stops, Additional Info are kept 
# because they are considered important in fare prediction. Also, journey month, journey day and weekday 
# are kept so that they capture any time series auto correlation in the data.
# And others are dropped.(more reason to drop them: couldn't find any significant difference)
# Moreover there are warnings on some chi square values that their approximation may be wrong.
# We will see later if they add upto the multicollinearity using VIF test.

df$Source=NULL
df$Destination=NULL
df$Dep_Time=NULL
df$Arrival_Time=NULL
df$Duration=NULL

------------------------------------------------------------------------------
#ANOVA test

twoway = aov(Price ~  Airline+Total_Stops+Additional_Info+Journey_Day+Journey_Month+weekday, data = df)

summary(twoway)

#The p-value of  all the variables are low (p < 0.05)

-------------------------------------------------------------------------------
install.packages("usdm")
library(usdm)

df$Airline=as.numeric(df$Airline)
df$Total_Stops=as.numeric(df$Total_Stops)
df$Additional_Info=as.numeric(df$Additional_Info)
df$weekday=as.numeric(df$weekday)
df$Journey_Day=as.numeric(df$Journey_Day)
df$Journey_Month=as.numeric(df$Journey_Month)

str(df)

vif(df[,-4])

#Not much multicollinearity in the data.
--------------------------------------------------------------------------------

----------------------------------------------------------------------------------
#run regression model
df$Airline=as.factor(df$Airline)
df$Total_Stops=as.factor(df$Total_Stops)
df$Additional_Info=as.factor(df$Additional_Info)
df$weekday=as.factor(df$weekday)
df$Journey_Day=as.factor(df$Journey_Day)
df$Journey_Month=as.factor(df$Journey_Month)

lm_model = lm(Price ~., data = df)

#Summary of the model summary(lm_model)
#F statistics value is hogh and pvalue<0.05, so all the variables indiviadually are significant.
# Here there is a very minute difference between Rsquare and ADjR2 that is because few classes of some variables are insignficant.