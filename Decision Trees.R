library(mosaic)
library(leaps)
library(HH)
library(car)
library(bestglm)
library(pdp)
library(ggplot2) 
# Helper packages
library(dplyr)       # for data wrangling
library(ggplot2)     # for plotting

# Modeling packages
library(rpart)       # direct engine for decision tree application
library(caret)       # meta engine for decision tree application

# Model interpretability packages
library(rpart.plot)  # for plotting decision trees
library(vip)         # for feature importance
library(pdp)     

install.packages("rpart.plot")
install.packages("randomForest")
library(rpart.plot)
library(randomForest)

model = glm(NumberOfInjuries ~ Week + RestDays + RushYards + PassYards + TotalYards + PointsScored + PercentYardsRush + Surface + CategoriesRestDays, data = NewNFLProject1Data)
summary(model)
model2 = regsubsets(SQRTNumberOfInjuries ~ Week + RushYards + PassYards + PointsScored + PercentYardsRush + Surface + RestDays, data = NewNFLProject1Data)
summary(model2)
summaryHH(model2)

# Implement a decision tree using rpart
tree_modelQUA <- rpart(NumberOfInjuries ~ Week + RestDays + RushYards + PassYards + TotalYards + PointsScored + PercentYardsRush + Surface, data = NewNFLProject1Data)
tree_modelCAT <- rpart(NumberOfInjuries ~ Week + RushYards + PassYards + TotalYards + PointsScored + PercentYardsRush + Surface + CategoriesRestDays, data = NewNFLProject1Data)

# Plot the decision tree
rpart.plot(tree_modelQUA)
rpart.plot(tree_modelCAT)

# Display feature importance using vip
vip(tree_modelQUA)
vip(tree_modelCAT)

tree_modelQUA$cptable

ames_dt3 <- train(
  NumberOfInjuries ~ .,
  data = NewNFLProject1Data,
  method = "rpart",
  trControl = trainControl(method = "cv", number = 10),
  tuneLength = 20
)

ggplot(ames_dt3)

vip(tree_modelQUA, num_features = 9, bar = FALSE)


plotcp(tree_modelQUA)
plotcp(tree_modelCAT)

p1 <- partial(tree_modelQUA, pred.var = "PointsScored") %>% autoplot()
p2 <- partial(tree_modelQUA, pred.var = "TotalYards") %>% autoplot()
p3 <- partial(tree_modelQUA, pred.var = c("PointsScored", "TotalYards")) %>% 
  plotPartial(levelplot = FALSE, zlab = "Injuries", drape = TRUE, 
              colorkey = TRUE, screen = list(z = -20, x = -60))
gridExtra::grid.arrange(p1, p2, p3, ncol =3)

# Extract variable importance for the quantitative decision tree
importance_qua <- as.data.frame(varImp(tree_modelQUA))
importance_cat <- as.data.frame(varImp(tree_modelCAT))

# Print variable importance levels for quantitative decision tree
cat("Variable Importance Levels for Quantitative Decision Tree:\n")
print(importance_qua)

# Print variable importance levels for categorical decision tree
cat("Variable Importance Levels for Categorical Decision Tree:\n")
print(importance_cat)



