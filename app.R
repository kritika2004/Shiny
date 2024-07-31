library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  # Title
  titlePanel("Mtcars Shiny App Homework Assignment - John Boyle Ruiz, Kritika Goyal, Luke Carignan, & Holland Brown"),
  
  # Sidebar layout with input and output
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
      selectInput("var1", "Select first numerical variable:",
                  choices = names(mtcars)[sapply(mtcars, is.numeric)]),
      selectInput("var2", "Select second numerical variable:",
                  choices = names(mtcars)[sapply(mtcars, is.numeric)])
    ),
    
    # Main panel for outputs
    mainPanel(
      plotOutput("scatterPlot"),
      plotOutput("hist1"),
      plotOutput("hist2")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  output$scatterPlot <- renderPlot({
    ggplot(mtcars, aes_string(x = input$var1, y = input$var2)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE) +
      labs(title = paste("Scatterplot of", input$var1, "vs", input$var2),
           x = input$var1,
           y = input$var2)
  })
  
  output$hist1 <- renderPlot({
    ggplot(mtcars, aes_string(x = input$var1)) +
      geom_histogram(binwidth = 1, fill = "blue", color = "black") +
      labs(title = paste("Histogram of", input$var1),
           x = input$var1,
           y = "Count")
  })
  
  output$hist2 <- renderPlot({
    ggplot(mtcars, aes_string(x = input$var2)) +
      geom_histogram(binwidth = 1, fill = "green", color = "black") +
      labs(title = paste("Histogram of", input$var2),
           x = input$var2,
           y = "Count")
  })
}

# Run application 
shinyApp(ui = ui, server = server)



)
