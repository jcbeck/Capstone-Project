#--------------------------------------------------
# R UI Code for the Capstone Project Shiny App
#--------------------------------------------------

# Install the necessary packages;
suppressPackageStartupMessages(c(
  library(shinythemes),
  library(shiny),
  library(tm),
  library(stringr),
  library(markdown),
  library(stylo)))

shinyUI(fixedPage(
  
  # Application title
  titlePanel("Data Science Capstone: Final Project - Word Prediction"),
  
  fixedRow(HTML("<h4><strong>Jill Beck</strong></h4>") ),
  fixedRow(HTML("<h4><strong>April 25, 2016</strong></h4>") ),
  
  fixedRow(
    br(),
    p("This application was created in R using Shiny. It uses the NGram
      prediction model taken from the area of natural language processing.
      In a previous workstream, data was taken from blogs, news and Twitter.
      Data frames of 4-Grams, TriGrams, BiGrams and Unigrams were subsequently
      created.")),
  br(),
  br(),
  
  fluidRow(HTML("<strong>Enter a partial sentence and please press \"Next Word\" button to predict the next word.</strong>") ),
  fluidRow( p("\n") ),
  
  # Sidebar layout
  sidebarLayout(
    
    sidebarPanel(
      textInput("inputString", "Please enter a partial sentence here:",value = ""),
      submitButton("Next Word")
    ),
    
    mainPanel(
      h4("The predicted next word is:"),
      verbatimTextOutput("prediction"),
      textOutput('text1'),
      textOutput('text2')
    )
  )
    ))