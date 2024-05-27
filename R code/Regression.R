nfldata<-read.csv(file=file.choose())
head(nfldata)
##### Step 1: multiple regression 

#EDA: explanatory variables: number of injuries by week, rest days (factor and continuous), 
# total yards, pass yards, rush yards, points scored, percent yards rush, surface (factor)

plot(nfldata$NumberOfInjuries~nfldata$RestDays)
plot(nfldata$NumberOfInjuries~as.factor(nfldata$CategoriesRestDays))
plot(nfldata$NumberOfInjuries~nfldata$TotalYards)
plot(nfldata$NumberOfInjuries~as.factor(nfldata$Surface))
colnames(nfldata)

# make the first LMs

continuouslm=lm(NumberOfInjuries~Week+RestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)
summary(continuouslm)
plot(continuouslm)
vif(continuouslm)
#a small normality issue maybe? Because we want to make inferences, lets do a sqrt transformation: 
continuous.sqrt=lm(SQRTNumberOfInjuries~Week+RestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)
summary(continuous.sqrt)
plot(continuous.sqrt)


# now make it with categorical rest days 

catlm=lm(NumberOfInjuries~Week+CategoriesRestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)
summary(catlm)
plot(catlm)
#a small normality issue maybe? Because we want to make inferences, lets do a sqrt transformation: 
cat.sqrt=lm(SQRTNumberOfInjuries~Week+CategoriesRestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)
summary(cat.sqrt)
plot(cat.sqrt)
vif(catlm)

# VIF 

library(car)
vif(continuouslm)
vif(continuous.sqrt)
vif(catlm)
vif(cat.sqrt)

modelcontl = regsubsets(NumberOfInjuries~Week+RestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)
modelconts = regsubsets(SQRTNumberOfInjuries~Week+RestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)
modelcatl = regsubsets(NumberOfInjuries~Week+CategoriesRestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)
modelcats = regsubsets(SQRTNumberOfInjuries~Week+CategoriesRestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)

summaryHH(modelcontl)
# adj R2 of 0.0194, Week-PointsScored-PercentYardsRush-as.factor(Surface)Turf

contl=lm(NumberOfInjuries~Week+PointsScored+PercentYardsRush+as.factor(Surface),data=nfldata)
summary(contl)

summaryHH(modelconts)
# adj R2 of 0.167,  Week-PointsScored-PercentYardsRush

conts=lm(SQRTNumberOfInjuries~Week+PointsScored+PercentYardsRush,data=nfldata)
summary(conts)


summaryHH(modelcatl)
# adj R2 of 0.0265, Week-CategoriesRestDaysNormal-PointsScored-as.factor(Surface)Turf

catl=lm(NumberOfInjuries~Week+CategoriesRestDays+PointsScored+as.factor(Surface),data=nfldata)
summary(catl)

summaryHH(modelcats)
# adj R2 of 0.02237, Week-CategoriesRestDaysNormal-PointsScored-PercentYardsRush 

cats=lm(SQRTNumberOfInjuries~Week+CategoriesRestDays+PointsScored+PercentYardsRush,data=nfldata)
summary(cats)

# Only common variables are week and pointsScored, but it is hard ot even take that into 
# account because the adj R2 values are unbelievably small. 
# making the rest days into categories actually was the only way to include them in the model
# therefore, not taking them as numerical variables potentially overemphasized their impact,
# even though their impact was still small. 

#k fold cross val 

#number = 10
#number = 20
number = 30
kfoldedQuant <- train(NumberOfInjuries~Week+RestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),
                 data=nfldata, trControl = trainControl(method = 'cv', number = number), model = 'lm')
print(kfoldedQuant)

kfoldedCat <- train(NumberOfInjuries~Week+CategoriesRestDays+TotalYards+PointsScored+PercentYardsRush+as.factor(Surface),
                  data=nfldata,trControl = trainControl(method = 'cv', number = number), model = 'lm')
print(kfoldedCat)













