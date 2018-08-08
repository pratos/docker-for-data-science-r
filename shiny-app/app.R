library(shiny)
library(ggplot2)

ui <- shinyUI(
  fluidPage(theme = "bootstrap.css",
    navbarPage("Credit Card Application",
                     tabPanel("Dashboard"),
                     tabPanel("Summary"))
        )
  )
server <- function(){
  
}

shinyApp(ui, server)