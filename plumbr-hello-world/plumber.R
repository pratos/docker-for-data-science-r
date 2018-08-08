setwd("/Users/pratos/difference-engine/docker-for-data-science-r/plumbr-hello-world/")

pr <- plumber::plumb("./src/hello-world.R")
pr$run(port = 8080)