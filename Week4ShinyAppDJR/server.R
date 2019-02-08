#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        #read data          
        #filePath <- "C:/DevelopingDataProducts/DDPWeek3AssignmentDJR/PWD2019Results.csv" 
        filePath <- "https://raw.githubusercontent.com/DanGitR/DDPWeek4AssignmentDJR/master/PWD2019Results.csv"  
        pwdFile<-read.csv(filePath, header=TRUE, sep=",", dec=".")
        pwdFile<-select(pwdFile,PcntOfStockChampSpeed,Class)
        pwdFile<-mutate(pwdFile, Class=as.character(Class))
        outlawCount<-dim(filter(pwdFile,Class=="Outlaw"))[1]
        stockCount<-dim(filter(pwdFile,Class=="Stock"))[1]
        maxClassCount<-max(outlawCount,stockCount)
        
        #Reactive Class Selector 
        speedsel<-reactive({
                sel <- input$SelectClass
                speeddf<-filter(pwdFile,Class == sel)
                select(speeddf,PcntOfStockChampSpeed)
        })
        
        #Reactive Car Counter 

        
        output$histPlot <- renderPlot({
                # generate bins based on input$bins from ui.R
                x<- speedsel()$PcntOfStockChampSpeed
                bins <- seq(min(x), max(x), length.out = input$bins + 1)
                # draw the histogram with the specified number of bins
                hist(x, breaks = bins, col = 'blue', border = 'white',main="2018 stock champion speed benchmarking",xlab="Percentage of 2018 stock champion speed attained [%]", ylab="Number of cars for selected class", include.lowest = TRUE, right = FALSE, xlim=c(50,100),ylim = c(0,maxClassCount) )
                output$selection <- renderText(input$SelectClass)
                
                
        })
        output$speedStats<-renderPrint({
                summary(speedsel()$PcntOfStockChampSpeed)
                
        })
})
