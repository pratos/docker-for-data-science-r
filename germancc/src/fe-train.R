source("./src/eda.R")
# Importing the intermediate data

flog.info("Loading the intermediate data")
german_credit <- readRDS("./assets/intermediate-files/intermediate_german_data.rds")

# head(german_credit)
# colnames(german_credit)
# 
# str(german_credit)

german_credit$rating <- ifelse(german_credit$rating == 1, "good", "bad")

# Checking for missing values
# unlist(lapply(german_credit, function(x) sum(is.na(x))))
# There are no missing values in the dataset

german_credit_num <- dplyr::select_if(german_credit, is.numeric)

# corr <- cor(german_credit_num[, -ncol(german_credit_num)])
# corrplot(corr)
# Correlation between numerical variables does not signal any reason to drop any variable.

# Correlation: Categorical Variable
# library(MASS)
# unique(survey$Smoke)
# unique(survey$Exer)
# tbl = table(survey$Smoke, survey$Exer) 
# chisq.test(tbl)

# checking for non-zero variance

nzv <- nearZeroVar(german_credit)
german_credit_nvz <- german_credit[, -nzv]

# colnames(german_credit_nvz)
# colnames(german_credit)

# Creating dummy variables

# sapply(dplyr::select_if(german_credit_nvz, is.character), function(x) levels(as.factor(x)))

# We'll be creating dummy variables for `status`, `credit_history`, `purpose`, `saving_account`, `employment`, `guarantors`, `property`, `other_installment`, `housing` and `job`

german_credit_dummies <- german_credit_nvz %>% select(c(status, credit_history, purpose, savings_account, employment, guarantors, property, other_installment, housing, job))

german_credit_nvz <- cbind(german_credit_nvz, as.data.frame(sapply(german_credit_dummies, function(x) dummies::dummy(x, sep = "_"))))

# print(colnames(german_credit_nvz))

colnames(german_credit_nvz)[grep('...src.fe.train.R', colnames(german_credit_nvz))] <- gsub('...src.fe.train.R', '', colnames(german_credit_nvz))

# Converting the existing credits to factor variable
german_credit_nvz$existing_credits_factors <- ifelse(german_credit_nvz$existing_credits == 1, "single_credit", "multiple_credits")

# Converting maintainance people to factor variable
german_credit_nvz$maintainence_people_factors <- ifelse(german_credit_nvz$maintainence_people == 1, "one_dependent", "multiple_dependents")


# german_credit_1 <- german_credit %>% 
#   select(-c(existing_credits, maintainence_people))
# 
# german_credit_2 <- german_credit %>% 
#   select(-c(existing_credits_factors, maintainence_people_factors))

flog.info(colnames(german_credit_nvz))

# Creating dataframes that will be used to create ML Models (TODO: Save them as rds files)

flog.info("Selecting the columns to load...")
german_credit_intermediate <- german_credit_nvz[, c("duration", "credit_amount", "installment_rate", "residence", "age", "status_greater_than_200DM_for_a_year", "status_less_than_0DM", "status_less_than_200DM", "status_no_account", "credit_history_all_credits_at_bank_payed", "credit_history_critical_account", "credit_history_delayed_payment_in_past", "credit_history_existing_credits_paid_back", "credit_history_no_credits_or_all_credits_payed", "purpose_business", "purpose_car_new", "purpose_car_used", "purpose_domestic_appliances", "purpose_education", "purpose_furnishing", "purpose_others", "purpose_radio_tv", "purpose_repairs", "purpose_retraining", "savings_account_0_99DM", "savings_account_100_499DM", "savings_account_500_999DM", "savings_account_Unknown_No_Savings_account", "employment_1_to_4_years", "employment_4_to_7_years", "maintainence_people_factors", "existing_credits_factors", "rating")]

saveRDS(german_credit_intermediate, "./assets/intermediate-files/intermediate_german_data_modelling.rds")
