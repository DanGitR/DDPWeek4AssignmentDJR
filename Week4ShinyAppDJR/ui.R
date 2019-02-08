#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Pinewood Derby 2018 Results"),
        
        
        sidebarLayout(
                sidebarPanel(
                        #h2("Histrogram bins qty. (use slider to select)"),  
                        # Sidebar with a slider input for number of bins 
                        sliderInput("bins",
                                    "Number of bins (use slider to select):",
                                    min = 1,
                                    max = 30,
                                    value = 15),
                        # Radio Buttons for Car Class Selection
                        radioButtons(inputId ="SelectClass", 
                                     label = "Select Car Class:",
                                     choices = c("Stock" = "Stock","Outlaw" = "Outlaw"),
                                     selected = "Stock",
                                     inline = FALSE)
                ),
                
                # Show a plot of the generated distribution
                mainPanel(
                        plotOutput("histPlot"),
                        h5(strong("Selected Class:")),
                        em(textOutput("selection")),
                        h5(strong("Summary Statistics:")),
                        verbatimTextOutput("speedStats"),
                        br(),
                        h5(strong("Application Description and User Guide:")),
                        p("In the histogram above, x represents the percentage of the 2018 champion's speed for the selected class. Use the radio buttons to select the class."),
                        br(),
                        p("The vertical axis represent the quantity of cars within each bin. Use the slider control to select the number of bins on the histogram."),
                        br(),
                        p("Summary statistics fro x are also presented below the histogram")
                )
        )
))
