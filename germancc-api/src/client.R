library(httr)

r <- POST("127.0.0.1:8080/predict", body = toJSON(head(german_credit)), encode = 'json')
