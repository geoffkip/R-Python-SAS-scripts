library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
library(shinythemes)
library(reshape)

#load data file
setwd("K:/ADMINISTRATIVE REPORTS/Daily Response Tracker")
Report_data <- read.csv("Goal_Progress_Raw_Data.csv", stringsAsFactors = FALSE)
Report_data1 <- (Report_data[,c(1,2,4,5)])
graph_data <- melt(Report_data1, id=c("goal","submitted_at"))
graph_data$submitted_at <- mdy(graph_data$submitted_at)
graph_data[,"variable"] <- ifelse(graph_data[,"variable"] == "pred_app_prog", "goal", 'cumulative apps')
names(graph_data) <- c("goal" , "submitted_at" , "Label" , "Applications")


graph_data2 <- Report_data
graph_data2$submitted_at <- mdy(graph_data2$submitted_at)


Front_page_data <- (Report_data[,c(1,6,7,8,9,10,11)])
Front_page_data <- distinct(Front_page_data)
Front_page_data2 <- na.omit(Front_page_data)


dates <- Front_page_data2[,c(1,5,6)]
dates$Start_date <- mdy(dates$Start_date)
dates$End_date <- mdy(dates$End_date)



ui <- fluidPage(theme = shinytheme("cerulean"),
                sidebarLayout(
                  sidebarPanel(
                    uiOutput("GoalOutput"), 
                    uiOutput("dates"),
                    img(src="bdtlogo.png", width=300)
                    
                  ),
                  
                  mainPanel(
                    h1("Goal Progress Report", align="center"),
                    h2("Summary of Goal Progress by Project", align="center"),
                    tableOutput("results"),
                    br(), br(),
                    fluidRow(
                      splitLayout(cellWidths = c("50%", "50%"), plotOutput("secondplot"), 
                                  plotOutput("coolplot"))))))



server <- function(input, output) {
  
  output$results <- renderTable(Front_page_data2)
  output$GoalOutput <- renderUI({
    selectInput("GoalInput", "Goal",
                sort(unique(Report_data$goal)),
                selected = "FastTrack")})  
  
  
  filtered <- reactive({
    if (is.null(input$GoalInput)) {
      return(NULL)
    }    
    
    graph_data %>%
      filter(goal== input$GoalInput ,
             submitted_at >= input$daterange1[1] ,
             submitted_at <= input$daterange1[2] ,
             Applications == Applications ,
             Label == Label 
      )
  })
  
  
  subsetdata <- reactive({
    if (is.null(input$GoalInput)) {
      return(NULL)
    }    
    
    graph_data2 %>%
      filter(goal== input$GoalInput ,
             submitted_at >= input$daterange1[1] ,
             submitted_at <= input$daterange1[2] ,
             apps == apps
      )
  })
  
  
  
  
  mydates <- reactive({if (is.null(input$GoalInput)) {
    return(NULL)
  }    
    dates %>%
      filter(goal== input$GoalInput ,
             Start_date == Start_date ,
             End_date == End_date)})
  
  
  
  output$dates <- renderUI({
    minval <- mydates()$Start_date
    maxval <- mydates()$End_date
    dateRangeInput('daterange1', label = "Choose Date Range:",
                   start = minval, end = maxval, 
                   min = minval, max = maxval,
                   separator = " - ", format = "mm/dd/yy"
    )
  })
  
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered()) + geom_line(aes(x=submitted_at, y=Applications, colour=Label)) +
      scale_colour_manual(values=c("blue","gray"))+ theme(legend.text=element_text(size=15))
  })
  
  output$secondplot <- renderPlot({
    if (is.null(subsetdata())) {
      return()
    }
    ggplot(subsetdata(), aes_string('submitted_at', 'apps')) +
      geom_smooth(method='lm') +
      geom_point()+
      geom_line()+
      ggtitle(paste('Time series of', 'Applications')) +
      xlab('Time')
  })
  
  
  
  
}

shinyApp(ui = ui, server = server)


