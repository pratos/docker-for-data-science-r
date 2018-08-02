# setwd("~/difference-engine/docker-for-data-science-r/")
source("./src/fe-train.R")

set.seed(42)

# Parallelizing the modelling
# NOTE: Try not to use all the cores
doParallel::registerDoParallel(parallel::detectCores() - 2)

# Write the ML Code here
# Parallelization helps to use cores present in any system you use. This will scale to system having 4 cores or 32 cores (e.g. Cloud Servers having massive amount of cores, RAM)

# Train-Test Split
flog.info("Creating Train-Test Split")
trainIndex <- createDataPartition(german_credit_intermediate$rating, p = .8, 
                                  list = FALSE, 
                                  times = 1)
saveRDS(trainIndex, "./assets/intermediate-files/trainIndex.rds")

germanccTrain <- german_credit_intermediate[ trainIndex,]
germanccTest  <- german_credit_intermediate[-trainIndex,]

saveRDS(germanccTrain, "./assets/intermediate-files/train.rds")
saveRDS(germanccTest, "./assets/intermediate-files/test.rds")

# Control Parameter to specify the parameters
flog.info("Creating the control parameter...")
fitControl <- trainControl(
  ## Performing 10-fold Cross Validation
  method = "repeatedcv",
  number = 4,
  repeats = 3)

# Training Model
flog.info("Training the ML Model...")
gbmFit1 <- train(rating ~ ., data = germanccTrain, 
                 method = "gbm", 
                 trControl = fitControl,
                 verbose = TRUE)
gbmFit1
# The final values used for the model were n.trees = 50, interaction.depth = 2, shrinkage
# = 0.1 and n.minobsinnode = 10
# We can verify this in the plot (run the function below) 

# plot(gbmFit1)

# Saving the model
flog.info("Model training successful, saving the model to disk...")
saveRDS(gbmFit1, "./assets/models/model_gbm.rds")

# Generating predictions
flog.info("Generating predictions...")
gbm_train_class <- predict(gbmFit1, newdata = germanccTrain)
gbm_train_probabilities <- predict(gbmFit1, newdata = germanccTrain, type = 'prob')

gbm_test_class <- predict(gbmFit1, newdata = germanccTest)
gbm_test_probabilities <- predict(gbmFit1, newdata = germanccTest, type = 'prob')

gbm_train_cf <- confusionMatrix(table(germanccTrain$rating, gbm_train_class))
gbm_test_cf <- confusionMatrix(table(germanccTest$rating, gbm_test_class))

metrics_gbm <- list(gbm_train_cf, gbm_test_cf, gbm_train_class, gbm_train_probabilities, gbm_test_class, gbm_test_probabilities)

saveRDS(metrics_gbm, "./assets/metrics/metrics_gbm.rds")
flog.info("Saving metrics to disk...")

# Stopping the cluster usage
flog.info("Stopping the clusters")
doParallel::stopImplicitCluster()
