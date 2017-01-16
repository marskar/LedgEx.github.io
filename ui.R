#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)

##install.packages("lubridate")
library(lubridate)
##install.packages("plotly")
library(plotly)
##install.packages("markdown")
library(markdown)
###################################
shinyUI(
  navbarPage(
    titlePanel("LedgEx: Ledger Explorer"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("Month", "Month:", min = 1, max = 12, value = 6),
        sliderInput("cThresh", "Credit Minimum:", min = 1, max = 10000, value = 100),
        sliderInput("dThresh", "Debit Minimum:", min = 1, max = 10000, value = 100)
      ),
      
      mainPanel(
        tabsetPanel(type="tabs",
          # Pies
          tabPanel("About", includeMarkdown("info.md")),
          tabPanel("Pie charts", br(), plotlyOutput("pc"), plotlyOutput("pd")),
          # Bars
          tabPanel("Bar charts", br(), plotlyOutput("bc"), plotlyOutput("bd"))
        )
      )
    )
  )
)
