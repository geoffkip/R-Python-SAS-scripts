library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
library(shinythemes)

#global

Report_data <- read.csv("D:/R/R data/External Relations Grant Tracker raw data.csv", stringsAsFactors = FALSE)
str(Report_data)
Report_data <- na.omit(Report_data)
Report_data$date_month <- mdy(Report_data$date_month)



ui <- fluidPage(theme = shinytheme("spacelab"),
                titlePanel("External Relations Report"),
                sidebarLayout(
                  sidebarPanel(
                    dateRangeInput("daterange1", "Date range:",
                                   start = "2015-01-01",
                                   end   = "2016-12-31" ,
                                   min    = "2015-01-01",
                                   max    = "2016-12-31",
                                   format = "mm/dd/yy",
                                   separator = " - "),
                    
                    uiOutput("FunderOutput"),
                    uiOutput("DeliverableOutput"),
                    img(src="bdtlogo.png", width=250)
                    
                  ),
                  
                  mainPanel(
                    dataTableOutput("results")
                  )
                )
)


server <- function(input, output) {
  
  
  
  output$FunderOutput <- renderUI({
    selectInput("FunderInput", "Funder",
                sort(unique(Report_data$Funder)),
                selected = "Abell Foundation")
  })  
  
  
  output$DeliverableOutput <- renderUI({
    selectInput("DeliverableInput", "Deliverable",
                sort(unique(Report_data$Deliverable)),
                selected = 1)
  })  
  
  
  
  
  
  filtered <- reactive({
    if (is.null(input$FunderInput)) {
      return(NULL)
    }    
    
    Report_data %>%
      filter(Funder == input$FunderInput,
             Deliverable == input$DeliverableInput,
             date_month >= input$daterange1[1] ,
             date_month <= input$daterange1[2],
             deliv_count == deliv_count
      )
  })

  
  output$results <- renderDataTable({
    filtered()
  })
  

}

shinyApp(ui = ui, server = server)
