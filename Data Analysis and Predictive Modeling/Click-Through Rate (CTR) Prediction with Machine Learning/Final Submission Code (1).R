#read trainset and testset
data = read.csv('analysis_data.csv')         #train
score = read.csv('scoring_data.csv')         #test
library(dplyr); library(tidyr)
#insert a new column to show whether the CTR os 0

data$z = ifelse(data$CTR == 0, 1, 0)

#create nonzero CTR trainset for xgboost model2
nzd = data[data$z == 0,]

#data treatment for xgboost

library(vtreat)

trt = designTreatmentsZ(dframe = data,
                        varlist = names(data)[2:28])
newvars = trt$scoreFrame[trt$scoreFrame$code%in% c('clean','lev'),'varName']

train_input = prepare(treatmentplan = trt, 
                      dframe = data,
                      varRestriction = newvars)     #for xgboost model 1 to decide whether CTR is zero

test_input = prepare(treatmentplan = trt, 
                     dframe = score,
                     varRestriction = newvars)


train_input2 = prepare(treatmentplan = trt, 
                       dframe = nzd,
                       varRestriction = newvars)   #for xgboost model2
#model1 decide whether the CTR is zero
library(xgboost)
set.seed(123)
params <- list(
  objective = "binary:logistic",
  eta = 0.1,
  max_depth = 10
)

## Cross Validation
cv_results <- xgb.cv(
  data=as.matrix(train_input), 
  label = data$z,
  params = params,
  nrounds = 10000,
  nfold = 10,
  verbose = 1,
  early_stopping_rounds = 100,
  metrics = "rmse",               
  maximize = FALSE
)
best_nrounds <- cv_results$best_iteration
## build model1
xgboost1 = xgboost(
  data = as.matrix(train_input),
  params = params,
  label = data$z,
  nrounds = best_nrounds,
  verbose = 0
)
pred_train = predict(xgboost1, 
                     newdata=as.matrix(train_input))
#test the result using trainset(these tests result shows that the error is small)
o = ifelse(pred_train>0.275, 1, 0)  #I choose 0.275 as binary value
data[o != data$z,'CTR']
pred_train[o != data$z]
sum(o != data$z)
#prediction of model1
pred = predict(xgboost1, 
               newdata=as.matrix(test_input))
table(pred)
o1 = ifelse(pred>0.275, 1, 0)
table(o1)

#model2 numeric output
set.seed(123)
params <- list(
  objective = "reg:squarederror",  
  eta = 0.1,
  max_depth = 1,
  subsample = 0.9,                 
  colsample_bytree = 0.6,
  max_delta_step = 0.6
  
)

#Cross Validation
cv_results <- xgb.cv(
  data=as.matrix(train_input2), 
  label = nzd$CTR,
  params = params,
  nrounds = 10000,
  nfold = 5,
  verbose = 1,
  early_stopping_rounds = 100,
  metrics = "rmse",                # Metric for evaluation
  maximize = FALSE
)
best_nrounds <- cv_results$best_iteration-20
#Build model2
xgboost2 = xgboost(
  data = as.matrix(train_input2),
  params = params,
  label =  nzd$CTR,
  nrounds = best_nrounds,
  verbose = 0
)
#numeric prediction
pred1 = predict(xgboost2,newdata=as.matrix(test_input))
submission_file = data.frame(id = score$id, CTR = pred1)
#overwrite the 0 CTR with our first prediction
submission_file[o1 == 1,]$CTR=0
#The negative value should not exist. Use zero instead.
submission_file[submission_file$CTR < 0,]$CTR = 0
write.csv(submission_file, 'sample_submission.csv',row.names = F)
#Show the final output
table(submission_file$CTR)

