source("./src/load-package.R")
flog.info("Loading the German Credit Card Dataset")
# Load Dataset

german_credit <- read.table("./assets/data/german.data", fileEncoding="UTF-8" , dec = ",")
head(german_credit)

flog.info("Renaming the Columns")
colnames(german_credit) <- c('status', 'duration', 'credit_history', 'purpose', 'credit_amount', 'savings_account', 'employment', 'installment_rate','status_sex', 'guarantors', 'residence', 'property', 'age', 'other_installment', 'housing', 'existing_credits', 'job', 'maintainence_people','telephone', 'foreign', 'rating')

# The levels are presents as A* characters. Since we'll be creating a dashboard out of the dataset and models, next few steps are to convert it back to the dataset that we want to view.

flog.info("Converting the Levels for the categorical variables...")
german_credit$purpose <- ifelse(german_credit$purpose == "A40", "car_new", ifelse(german_credit$purpose == "A41", "car_used", ifelse(german_credit$purpose == "A42", "furnishing", ifelse(german_credit$purpose == "A43", "radio_tv", ifelse(german_credit$purpose == "A44", "domestic_appliances", ifelse(german_credit$purpose == "A45", "repairs", ifelse(german_credit$purpose == "A46", "education", ifelse(german_credit$purpose == "A47", "vacations", ifelse(german_credit$purpose == "A48", "retraining", ifelse(german_credit$purpose == "A49", "business", "others")))))))))) 

german_credit$savings_account <- ifelse(german_credit$savings_account == "A61", "0_99DM", ifelse(german_credit$savings_account == "A62", "100_499DM", ifelse(german_credit$savings_account == "A63", "500_999DM", ifelse(german_credit$purpose == "A64", "1000DM_Above", "Unknown_No_Savings_account"))))

german_credit$employment <- ifelse(german_credit$employment == "A71", "unemployed", ifelse(german_credit$employment == "A72", "less_than_year", ifelse(german_credit$employment == "A73", "1_to_4_years", ifelse(german_credit$employment == "A74", "4_to_7_years", "more_than_7_years")))) 

german_credit$status_sex <- ifelse(german_credit$status_sex == "A91", "male_divorced_separated", ifelse(german_credit$status_sex == "A92", "female_divorced_separated_married", ifelse(german_credit$status_sex == "A93", "male_single", ifelse(german_credit$status_sex == "A94", "male_married_widowed", "female_single"))))

german_credit$guarantors <- ifelse(german_credit$guarantors == "A101", "none", ifelse(german_credit$guarantors == "A102", "co_applicant", "guarantor")) 

german_credit$property <- ifelse(german_credit$property == "A121", "real_estate", ifelse(german_credit$property == "A122", "building_society_savings_agreement_or_life_insurance", ifelse(german_credit$property == "A123", "car_or_other", "unknown_no_property")))

german_credit$other_installment <- ifelse(german_credit$other_installment == "A141", "bank", ifelse(german_credit$other_installment == "A142", "own", "free"))

german_credit$job <- ifelse(german_credit$job == "A171", "unemployed_unskilled_non_resident", ifelse(german_credit$job == "A172", "unskilled_resident" , ifelse(german_credit$job == "A173", "skilled_employee_official", "management_self_employed_highly_qualified_officer")))

german_credit$telephone <- ifelse(german_credit$telephone == "A191", "no", "yes")

german_credit$foreign <- ifelse(german_credit$foreign == "A201", "yes", "no")

german_credit$housing <- ifelse(german_credit$housing == "A151", "rent", ifelse(german_credit$housing == "A152", "own", "for_free"))


german_credit$status <- ifelse(german_credit$status == "A11", "less_than_0DM", ifelse(german_credit$status == "A12", "less_than_200DM", ifelse(german_credit$status == "A13", "greater_than_200DM_for_a_year", "no_account")))

german_credit$credit_history <- ifelse(german_credit$credit_history == "A30","no_credits_or_all_credits_payed", ifelse(german_credit$credit_history == "A31", "all_credits_at_bank_payed", ifelse(german_credit$credit_history == "A32", "existing_credits_paid_back", ifelse(german_credit$credit_history == "A33", "delayed_payment_in_past", "critical_account"))))


# hist(german_credit$duration)
# hist(log(german_credit$duration))
# 
# hist(log(german_credit$credit_amount))
# 
# unique(german_credit$installment_rate)
# 
# unique(german_credit$residence)
# 
# unique(german_credit$age)
# hist(german_credit$age)
# 
# hist(german_credit$existing_credits)
# unique(german_credit$existing_credits)

flog.info("Saving the intermediate file on disk...")
saveRDS(german_credit, "./assets/intermediate-files/intermediate_german_data.rds")

# Next step would be creating features!