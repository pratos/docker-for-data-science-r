setwd("~/difference-engine/docker-for-data-science-r/")
source("./src/load_package.R")

# Load Dataset

german_credit <- read.table("./data/german.data", fileEncoding="UTF-8" , dec = ",")
head(german_credit)

colnames(german_credit) <- c('status', 'duration', 'credit_history', 'purpose', 'credit_amount', 'savings_account', 'employment', 'installment_rate','status_sex', 'guarantors', 'residence', 'property', 'age', 'other_installment', 'housing', 'existing_credits', 'job', 'maintainence_people','telephone', 'foreign', 'rating')

View(german_credit)

# The levels are presents as A* characters. Since we'll be creating a dashboard out of the dataset and models, next few steps are to convert it back to the dataset that we want to view.

german_credit$purpose <- ifelse(german_credit$purpose == "A40", "car_new", ifelse(german_credit$purpose == "A41", "car_used", ifelse(german_credit$purpose == "A42", "furnishing", ifelse(german_credit$purpose == "A43", "radio_tv", ifelse(german_credit$purpose == "A44", "domestic_appliances", ifelse(german_credit$purpose == "A45", "repairs", ifelse(german_credit$purpose == "A46", "education", ifelse(german_credit$purpose == "A47", "vacations", ifelse(german_credit$purpose == "A48", "retraining", ifelse(german_credit$purpose == "A49", "business", "others")))))))))) 

german_credit$purpose