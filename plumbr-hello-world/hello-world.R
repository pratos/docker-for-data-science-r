# Loading essential R packages 

list.of.packages <- c("ggplot2", "parallel", "gbm","tidyverse", "pROC", "caret", "corrplot", "doParallel", "dummies", "futile.logger", "plumber")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

# Check whether the packages listed are installed or not
# If not then they are installed
if(length(new.packages)) {
  print("Installing new packages")
  install.packages(new.packages, repos = "http://cran.us.r-project.org")
}

# Import all the packages in the RSession
lapply(list.of.packages, library, character.only=TRUE)

# Hello World function
#' @param name The message to echo back
#' @get /echo
function(name=""){
  list(name = paste0("Hello ", name, ". Welcome!"))
}

