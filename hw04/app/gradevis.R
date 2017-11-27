library(shiny)
library(ggvis)
library(ggplot2)
source("../code/functions.R")
dat<- read.csv("../data/cleandata/cleanscores.csv", stringsAsFactors = FALSE)

dat$Grade <- factor(dat$Grade,
                        levels = c('A+', 'A', 'A-',
                                   'B+', 'B', 'B-',
                                   'C+', 'C', 'C-',
                                   'D', 'F'))
grade <- dat$Grade



tabla <- data.frame(table(grade)) 
tabla$Prop <- prop.table(tabla$Freq) 
categorical <- colnames(dat[,-23])

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition = "input.tabselected==1",
                       h4("Grades Distribution"),
                       tableOutput("v1")),
      conditionalPanel(condition = "input.tabselected==2",
                       selectInput("v1", "X-axis Variable", categorical,
                                   selected = "HW1"),
                       sliderInput("width", "Bin Width",
                                   min = 1, max = 10, value = 1)),
      conditionalPanel(condition = "input.tabselected==3",
                       selectInput("v2", "X-axis Variable", categorical,
                                   selected = "Test1"),
                       selectInput("v3", "Y-axis Variable", categorical,
                                   selected = "Overall"),
                       sliderInput("opacity", "Opacity",
                                   min = 0, max = 1, value = .1))
    ),
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Barchart", value = 1, plotOutput("p1")),
        tabPanel("Histogram", value = 2, ggvisOutput("p2"), h4("Summary  Statistics"), verbatimTextOutput("summary")),
        tabPanel("Scatterplot", value = 3, plotOutput("p3"), h4("Correlation:"), verbatimTextOutput("correlation")),
        id = "tabselected"
      )
    )
  )
)
  

# Define server logic required to draw a histogram
server <- function(input, output) {
    vis_histogram <- reactive({
      v1 <- prop("x", as.symbol(input$v1))
      dat %>% 
        ggvis(x = v1, fill := "#abafb3") %>% 
        layer_histograms(stroke := 'white',width = input$width)
    })
    output$summary <- renderPrint({
      v1 <- prop("x", as.symbol(input$v1))
      print_stats(summary_stats(dat[,input$v1]))
    })
    
    vis_histogram %>% bind_shiny("p2")
    
    vis_scatterplot <- reactive({
      v2 <- prop("x", as.symbol(input$v2))
      v3 <- prop("y", as.symbol(input$v3))
 
      dat %>% 
        ggvis(x = v2, y = v3, opacity := input$opacity) %>% 
        layer_points()
    })
    output$v1 <- renderTable({
      tabla
    })
    output$p1 <- renderPlot({
      ggplot(tabla, aes(grade, Freq)) + geom_col()
    })
    
  
    vis_scatterplot %>% bind_shiny("p3")
    output$correlation <- renderPrint({
      v2 <- prop("x", as.numeric(input$v2))
      v3 <- prop("y", as.numeric(input$v3))
      print(cor(x = dat[,input$v2], y = dat[,input$v3]))
    })
}
# Run the application 
shinyApp(ui = ui, server = server)