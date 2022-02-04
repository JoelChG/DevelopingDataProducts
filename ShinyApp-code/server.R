library(shiny)
library(data.table)
library(caret)
library(randomForest)
# Read in the RF model
model <- readRDS("C:/Users/chave/Desktop/DDP-FinalProject/Assets/OutputFiles/model.rds")
confMat <- readRDS("C:/Users/chave/Desktop/DDP-FinalProject/Assets/OutputFiles/confusionMatrix.rds")
confMat1 <- as.table(confMat)
confMat2 <- as.table(confMat$byClass)
Gender <- c("Female", "Male")
n_y <- c("No", "Yes")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    # Input Data
    datasetInput <- reactive({  
        
        df <- data.frame(Age = input$Age,
                         Gender = input$Gender,
                         Polyuria = input$Polyuria,
                         Polydipsia = input$Polydipsia, 
                         sudden.weight.loss = input$sudden.weight.loss, 
                         weakness = input$weakness, 
                         Polyphagia = input$Polyphagia, 
                         Genital.thrush = input$Genital.thrush, 
                         visual.blurring = input$visual.blurring,
                         Itching = input$Itching, 
                         Irritability = input$Irritability, 
                         delayed.healing = input$delayed.healing,
                         partial.paresis = input$partial.paresis, 
                         muscle.stiffness = input$muscle.stiffnes, 
                         Alopecia = input$Alopecia, 
                         Obesity = input$Obesity, 
                         stringsAsFactors = FALSE)
        
        df$Gender <- factor(x = df$Gender, 
                            levels = c("Female", "Male"), 
                            labels = c("Female", "Male"))
        df[, 3:16] <- lapply(df[, 3:16], function(x) factor(x = x, 
                                                            levels = n_y, 
                                                            labels = n_y))
        
        test <- df
        
        Output <- data.frame(Prediction = predict(model, test),
                             round(predict(model, test, type = "prob"), 3))
        print(Output)
        
    })
    
    # Status/Output Text Box
    output$contents <- renderPrint({
        if (input$submitbutton>0) { 
            isolate("Calculation complete.") 
        } else {
            return("Server is ready for calculation.")
        }
    })
    
    # Prediction results table
    output$tabledata <- renderTable({
        if (input$submitbutton>0) { 
            isolate(datasetInput()) 
        } 
    })
    
    # Confusion Matrix
    output$confusionMatrix <- renderTable({
        expr = confMat1
    })
    
    output$confusionMatrix2 <- renderTable({
        confMat2 
    })
})
