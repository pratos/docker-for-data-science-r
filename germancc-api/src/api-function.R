setwd("/Users/pratos/difference-engine/docker-for-data-science-r/germancc-api/")
source("./src/load-package.R")

flog.info("Loading the model...")
model_api <- readRDS("../assets/models/model_gbm.rds")
flog.info("Model successfully loaded")

# ================= Making the basic dataframe request work =====================
# @apiTitle Credit Card API
# @apiDescription Function to provide predictions for German Credit Scoring problem
# @post /predict
# @response 200
# function(req){
#   # `req` will contain the request body which is sent over from the client
#   # Any data present in the request body will be available in `req$postBody`
#   # Here, we are sending json encoded dataframe that is decoded using `fromJSON`
#   # function from jsonlite
#   predict_df <- jsonlite::fromJSON(req$postBody)
#   print(head(predict_df))
#   
#   return(toJSON("Working API..."))
# }

# =================== Preprocessing function =======================
preprocess <- function(){
  
}

# ==================== MAIN API ============================
#' @apiTitle Credit Card API
#' @apiDescription Function to provide predictions for German Credit Scoring problem
#' @post /predict
#' @response 200
function(req){
  predict_df <- jsonlite::fromJSON(req$postBody)
  
  predictions <- predict(model_api, newdata = predict_df, type = "prob")
  classes <- predict(model_api, newdata = predict_df)
  
  unique_id <- predict_df$uid
  
  response_df <- cbind(loan_id = unique_id, predictions, classes)
  
  return(toJSON(response_df))
}