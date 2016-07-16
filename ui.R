#ui.R
library(shiny)
shinyUI(fluidPage(
  textInput("text", label = h2("Predicting the next word"), value = "home"),
  submitButton(text = "The most likely next word is..."),
  hr(),
  fluidRow((verbatimTextOutput("value")))
  
))