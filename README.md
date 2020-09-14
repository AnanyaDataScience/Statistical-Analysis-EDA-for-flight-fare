# Statistical-Analysis-EDA-for-flight-fare
In this project we do several feature extraction, some interesting EDA to acknowledge flight trends and perform statistical tests(Chi-Square, ANOVA, VIF, correlation) to check the significance of the predictors towards the price by their corresponding hypothesis and finally, OLS regression model is built using the important predictor variables and the results were analyzed.
# ABSTRACT
In this report, we will see how a flight fare prediction model is built using several factors which affect the price like the date of journey, type of airline, source and destination of journey, departure and arrival time, duration of the flight and total stops in the journey. Other factors which affect the price like if it is a holiday, a weekend, which travel season is it can also be extracted from the given details. We will study how and to what extent are these factors affecting the price using various hypothesis tests. Finally, a regression model will be built using the important predictor variables which will give us the flight fare.
# INTRODUCTION
As domestic air travel is getting more and more popular these days in India with various air ticket booking channels coming up online, travelers are trying to understand the trends in the airline industry. Hence, we collect the historical data of all airlines from major cities between the months of March and June of 2019. Here we are solving a forecasting type of problem. Broadly it will help us understand the best time to buy, flight trends and answer certain stereotypes (Does price increase near departure date, are morning flights expensive, are some airlines expensive than other?)
# DATA DESCRIPTION
Data of all airlines from major cities between the months of March and June of 2019. Attributes: 
•	Airline: The name of the airline 
•	Date_of_Journey: The date of the journey 
•	Source: The source from which the service begins.
•	Destination: The destination where the service ends
•	Route: The route taken by the flight to reach the destination.
•	Dep_Time: The time when the journey starts from the source.
•	Arrival_Time: Time of arrival at the destination.
•	Duration: Total duration of the flight
•	Total_Stops: Total stops between the source and destination.
•	Additional_Info: Additional information about the flight.
•	Price: The price of the ticket

# FEATURE EXTRACTION
In this step we mainly work on the data set and do some transformation like extracting certain variables, clean the messy data so that it can be used in our model. This step is important because for a high prediction score.
Date_of_Journey:
In the column ‘Date_of_Journey’, we can see the date format is given as dd/mm/yyyy, so we can extract data, year and month of the journey from this and drop the main column.
Arrival_Time:
In the column ‘Arrival_Time’, if we see we have combination of both time and month but we need only the time details and extract whether it is a morning or an evening flight
Total_Stops:
This column is combination of number and a categorical variable like ‘1 stop’. We need only the number details from this column, so we split that and take the number details only also we change the ‘non-stop’ into ‘0 stop’ and convert the column into integer type.
Dep_Time: 
Same as the arrival time and convert it into integer
EXPLORATORY DATA ANALYSIS
HYPOTHESIS TESTS
CORRELATION ANALYSIS

 

Pearson correlation coefficient: To check the linear association between the target variable and independent continuous variable (this condition needs to be met)
H0: Two variables are not correlated 
H1: Two variables are correlated
if p-value < 0.05, then we reject the null hypothesis and accept the H1, saying they are correlated We get p-value < 0.05, hence we accept H1 and say the target variable and continuous independent variable are correlated. r = 0.51 says they are moderately related.

# CHI-SQUARE TEST FOR CATEGORICAL VARIABLES:
Hypothesis testing:
HO: The two variables are independent
H1: The two variables are dependent
If p-value <0.01(we take confidence interval as 99% and alpha =0.01, as from our analysis see that keeping significance level as 0.05,many variables became dependent)so then we reject the null hypothesis saying that 2 variables are dependent. There should be no dependencies between Independent variables. So, we check variables who are highly dependent with other variables, we remove them. Checking the p-values, we drop "Airline","Source","Destination","Total_Stops","Journey_Month","Journey_Day","Arrival_Time"

# COMPARISON TEST:
## ANOVA TEST
It is carried out to compare between each group in a categorical variable.
ANOVA only lets us know the means for different groups are same or not. It does not help us identify which mean
is different.
Hypothesis testing:
H0: means of all levels of the categorical variable is same
H1: mean of at least one level is different If p-value < 0.05 then we reject the null hypothesis. As p-value<0.05 for all the variables, we reject H0 and hence no variables are removed

# CORRELATION TEST:
## MULTICOLLINEARITY TEST
It occurs when two or more independent variables are highly correlated with one another in a regression model.
if VIF is 1 --- Not correlated to any of the variables.
if VIF is between 1-5 --- Moderately correlated.
if VIF is above 5 --- Highly correlated.

 
We see that "Additional_Info" has a VIF>5, hence we drop the variable.

# BUILDING THE MODEL
Finally, after performing all the tests we are left with duration, weekday, dep_time and the dependent variable: price. We need to convert categorical variable weekday and Dep_Time to dummy variable. Then a multiple regression model is built using these variables.

 

# OLS SUMMARY TABLE
1) R-square - it tells that 81.7% of the variation in the outcome variable is explained by the predictor variables.
2) Adj R square - 81.7%, it considers the number of independent variables used for predicting the target variable. In doing so, it removes variables which do not add any value. In our model r-square = Adj R square which tells that the model is well fitted an all relevant independent features are included. 
3)F-statistic – compares the model with no predictors (intercept-only model) with our model
H0: states that the model with no independent variables fits the data as well as our model.
H1: says that THE model fits the data better than the intercept-only model.
We consider p-value < 0.05 to reject H0
As p <0.05, we reject H0 and say that there is much less than 5% chance that the F-statistic of 4730 could have occurred by chance under the assumption of a valid Null hypothesis.
4)Omnibus a test of the skewness and kurtosis of the residual, the omnibus value of the model is extremely high and prob (omnibus) is close to 0, indicates that residual is not normally distributed
5)Skew value of 2.17 (positively right skewed) tells the residual is not normally distributed either
6)kurtosis value is 21(thicker tails), Kurtosis of the normal distribution is 3.0.
7)Durbin Watson (>1) indicates no autocorrelation of residuals.
8)Condition no. is also low, this is used to address multi-collinearity
10)Jarque-Bera test is a joint hypothesis of the skewness being zero and the excess kurtosis being
zero. JB (P Value<0.05) Reject Ho (Non-Normal Distribution)

As our residual follows a non-normal distribution. Certain steps could be avoided to avoid this.
The non-normal pattern in the residuals indicates that the deterministic portion (predictor variables) of the model is not capturing some explanatory information that is “leaking” into the residuals. The graph could represent several ways in which the model is not explaining all that is possible. Possibilities include: A missing variable, a missing higher-order term of a variable in the model to explain the curvature, a missing interaction between terms already in the model accounting for Errors with a Non-Normal Distribution. What could have done is transforming the response variable to make the distribution of the random errors approximately normal, Transforming the predictor variables, if necessary, to attain or restore a simple functional form for the regression function.

# CONCLUSION
The flight fare prediction model is built using multiple regression on the data. Feature engineering is an important aspect in this model. We also checked the correlation between the independent variables and the price. A more robust model could be built with a greater number of data points which will give us a clearer picture. Finally, whenever in future if a flight fare is to be determined, it can be done by inputting the following details (input variables).
