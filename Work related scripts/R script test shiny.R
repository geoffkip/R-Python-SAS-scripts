library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)

#global

colorado_data <- read.csv("D:/R/R data/Colorado_data_shiny_app.csv", stringsAsFactors = FALSE)
colorado_data1 <- na.omit(colorado_data)
colorado_data1$submitted_at <- mdy(colorado_data1$submitted_at)

colorado_data2 <- colorado_data1 %>% 
  group_by(county, submitted_at) %>%
  summarise(Applications= sum(applicants))

ui <- fluidPage(
  titlePanel("Colorado Apps by County"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("daterange1", "Date range:",
                     start = "2015-01-01",
                     end   = "2016-12-31" ,
                     min    = "2015-01-01",
                     max    = "2016-12-31",
                     format = "mm/dd/yy",
                     separator = " - "),
      
      sliderInput("appInput", "Applications", 0, 10, c(25, 40)),
      uiOutput("countyOutput")
    ),
    
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      tableOutput("results")
    )
  )
)

server <- function(input, output) {
  output$countyOutput <- renderUI({
    selectInput("countyInput", "County",
                sort(unique(colorado_data2$county)),
                selected = "ADAMS")
  })  
  
  filtered <- reactive({
    if (is.null(input$countyInput)) {
      return(NULL)
    }    
    
    colorado_data2 %>%
      filter(Applications >= input$appInput[1],
             Applications <= input$appInput[2],
             county == input$countyInput ,
             submitted_at >= input$daterange1[1] ,
             submitted_at <= input$daterange1[2] 
      )
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes_string('submitted_at', 'Applications')) +
      geom_line() +
      ggtitle(paste('Time series of', 'Applications')) +
      xlab('Time')
  })
  
  output$results <- renderTable({
    filtered()
  })
  
  #filtered$submitted_at <- format(filtered$submitted_at,'%Y-%m-%d')
 # output$results1 <- renderTable(filtered)
}

shinyApp(ui = ui, server = server)
