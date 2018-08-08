setwd("/Users/pratos/difference-engine/docker-for-data-science-r/germancc-api/")

pr <- plumber::plumb("./src/api-function.R")
pr$run(port = 8080)

