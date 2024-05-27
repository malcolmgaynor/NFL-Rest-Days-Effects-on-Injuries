# NFL Rest Days Effects on Injuries

Project with Will Gibbs, as a part of the Stat 306: Multivariate Sports Analytics class with Professor Bradley A. Hartlaub at Kenyon College. February 9th, 2024

In this project, Will and I analyzed whether or not there are more injuries in NFL games when players are given less rest in between games, such as on Thursday night games, 
as compared to the normal Sunday night games. Specifically, we compared the results of considering days of rest between games as a categorical variable (as was done in the previous
research that motivated our study) and as a numeric variable. For example, treating all Thursday night games as "low rest" is potentially misleading, as a team who plays 
a game on a Thursday following a bye week will have had above average rest before the game, as compared to the normal schedule of games separated by exactly one week. 

We used best subset selection to create our linear regression models, which we tested using K fold cross validation. In these models, we not only found no evidence that days of rest 
is a significant predictor for NFL injuries, but also that treating rest days as a categorical variable (such as simply considering which day the game was played on, not the exact amount
of rest each team had before the game) had no impact on our model's accuracy or predictions. 

Next, we used decision trees to analyze potential nonlinear relationships between variables. While our decision tree model was more predictively powerful than our regression models, 
it similarly found no difference in models that considered rest days as numeric as compared to categorical, and rest days was considered a relatively unimportant predictor.

This repository includes our Google Slides presentation sharing the details behind our process and results, the code (written in R) used to create the models and do the analysis, and the data we considered. 
If you have any questions or are interested in our process, data, models, code, or analysis, please do not hesitate to reach out!
