library(shiny)
shinyServer(function(input, output) {
  model1 <- lm(Petal.Width ~ ., data = iris)
  model2 <- lm(Petal.Width ~ Sepal.Length, data = iris)
  
  model1pred <- reactive({
    species <- input$selectSpecies
    sepalLength <- input$sliderSepalLength
    sepalWidth <- input$sliderSepalWidth
    petalLength <- input$sliderPetalLength
    predict(model1, newdata = data.frame(Sepal.Length = sepalLength,
                                         Sepal.Width = sepalWidth,
                                         Petal.Length = petalLength,
                                         Species = species))
  })
  
  model2pred <- reactive({
    species <- input$selectSpecies
    predict(model2, newdata = 
              data.frame(Sepal.Length = input$sliderSepalLength))
  })
  
  output$plot1 <- renderPlot({
    mpgInput <- input$sliderSepalLength
    
    plot(iris$Petal.Length, iris$Petal.Width, xlab = "Petal Length", 
         ylab = "Petal Width", bty = "n", pch = 16,
         xlim = c(0.1, 8), ylim = c(0.1, 4))
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(input$sliderPetalLength, model1pred(), col = "red", pch = 16, cex = 2)
    points(input$sliderPetalLength, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})