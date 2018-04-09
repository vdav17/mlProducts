library(shiny)
## Create list of unique species
lst.species <- as.list(unique(iris$Species))

shinyUI(fluidPage(
  titlePanel("Predict Petal Width"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderSepalLength", "Select Sepal Length:", min = 0.1, max = 8, value = 6.2, step = 0.1),
      sliderInput("sliderSepalWidth", "Select Sepal Width:", min = 0.1, max = 8, value = 4.2, step = 0.1),
      sliderInput("sliderPetalLength", "Select Petal Length:", min = 0.1, max = 8, value = 5.7, step = 0.1),
      selectInput("selectSpecies", label = h3("Select species"), 
                  choices = lst.species, 
                  selected = 'versicolor'),
      submitButton("Submit"),
      h3("This project builds two models to predict petal width, one with all the variables and the other one with just one. Just move the sliders to desired values and select a species, then select submit. The two models predictions will be displayed")
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Petal Width for model 1 (All variables):"),
      textOutput("pred1"),
      h6("Predicted Petal Width for model 2 (Only Sepal Length):"),
      textOutput("pred2")
    )
  )
))