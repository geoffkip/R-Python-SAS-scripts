library(shiny)

my.data <- as.data.frame(t(data.frame(White = c(as.Date("2010-01-01"), as.Date(Sys.Date())),
                                      Red = c(as.Date("1943-01-01"), as.Date("1960-05-19")),
                                      Blue = c(as.Date("1975-01-01"), as.Date("2010-03-09")))))

my.data$V1 <- as.Date(my.data$V1)
my.data$V2 <- as.Date(my.data$V2)


ui <-  (fluidPage(
  titlePanel("Default Date Range"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Problem initiating a date range default based on selected input"),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("White", "Red", "Blue"),
                  selected = "White"),
      
      
      uiOutput("inVar2")
      
    ),
    
    mainPanel(
      textOutput("text1"),
      textOutput("text2")
    ) #end of main panel
  )#end of SidebarLayout
))#end of fluid page and UI


server <- function(input, output) {
  
  
  output$inVar2 <- renderUI({
    
    my.row = match(input$var, rownames(my.data))
    
    dateRangeInput("inVar2", 
                   label = paste('Date range selection'),
                   start = my.data[my.row,1],
                   end = my.data[my.row,2], 
                   separator = " - ", 
                   weekstart = 1
                   
    )
    
  })
  
  
  output$text1 <- renderText({ 
    paste("You have selected", input$var)
  })
  
  
  
  output$text2 <- renderText({ 
    my.row = match(input$var, rownames(my.data))
    paste("You need the default date range",
          my.data[my.row,1], "to", my.data[my.row,2])
  })
  
}


shinyApp(ui = ui, server = server)