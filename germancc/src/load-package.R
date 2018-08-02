list.of.packages <- c("ggplot2", "parallel", "gbm","tidyverse", "pROC", "caret", "corrplot", "doParallel", "dummies", "futile.logger")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

# Check whether the packages listed are installed or not
# If not then they are installed
if(length(new.packages)) {
  print("Installing new packages")
  install.packages(new.packages, repos = "http://cran.us.r-project.org")
}

# Import all the packages in the RSession
lapply(list.of.packages, library, character.only=TRUE)
flog.info("All the packages have been loaded successfully")


