library(shiny)
library(data.table)
library(randomForest)

Gender <- c("Female", "Male")
n_y <- c("No", "Yes")


# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Page header
    titlePanel(
        tags$h1(
        tags$strong('Early Type 2 Diabetes Prediction Tool') 
        ), windowTitle = "Early Type 2 Diabetes Prediction Tool"),
    
    # Input values
    sidebarPanel(id = "my_panel",
        #tags$label
        (h2(tags$strong('Input parameters'))),
        numericInput("Age", 
                     label = "What's your age? (in years)", 
                     value = 20, min = 20, max = 90),
        radioButtons("Gender", 
                     label = "Select your gender", 
                     Gender),
        radioButtons("Polyuria", 
                     label = "Do you urinate very frequently?", 
                     n_y),
        radioButtons("Polydipsia", 
                     label = "Do you feel thirsty very frequently?", 
                     n_y),
        radioButtons("Polyphagia", 
                     label = "Do you feel hungry more very frequently", 
                     n_y),
        radioButtons("sudden.weight.loss", 
                     label = "Have you had inexplicably weight loss in the past 6 months?", 
                     n_y),
        radioButtons("weakness", 
                     label = "Do you feel inexplicably weak?", 
                     n_y),
        radioButtons("Genital.thrush", 
                     label = "Have you had genital thrush frequently on the past 6 months?", 
                     n_y),
        radioButtons("visual.blurring", 
                     label = "Have you experienced inexplicable visual blurring?", 
                     n_y),
        radioButtons("Itching", 
                     label = "Have you had frequent itch for no apparent reason?", 
                     n_y),
        radioButtons("Irritability", 
                     label = "Have you felt inexplicably irritable?", 
                     n_y),
        radioButtons("delayed.healing", 
                     label = "Have you experienced delayed healing of wounds?", 
                     n_y),
        radioButtons("partial.paresis", 
                     label = "Do you have weakness or difficulty for the movement of a limb?", 
                     n_y),
        radioButtons("muscle.stiffnes", 
                     label = "Do you experience muscle stiffnes frequently?", 
                     n_y),
        radioButtons("Alopecia", 
                     label = "Are you bald or are you experiencing unexplicable hair loss?", 
                     n_y),
        radioButtons("Obesity", 
                     label = "Is your BMI equal to or greater than 30?", 
                     n_y),
        actionButton("submitbutton", "Predict", 
                     class = "btn btn-primary")
    ),
    
    mainPanel(
        tags$label(h2(tags$strong('Status/Output'))), # Status/Output Text Box
        verbatimTextOutput('contents'),
        tableOutput('tabledata'), # Prediction results table
        tags$br(), 
        tags$div(
            tags$h2("Documentation"),
            tags$p("This Shiny Web App was developed as part of the final project
                   of the course Developing Data Products, offered by Johns
                   Hopkins University."),
            tags$h3("What is this App?"), 
            tags$p("This app predicts type 2 diabetes based on user input. It
                   gives a prediction which can be either Positive or Negative 
                    and displays the probability of being classified as either
                   positive or negative, ranging from 0.00 (0%) to 1.00 (100%).
                   "),  
            tags$h3("How do I use this App?"), 
            tags$p("On the side panel are a series of questions, the first is your
                   age, which should be typed by the user, ranging from 20 to 
                   90 years (Ages outside of this range may give an incorrect
                   classification.)"),
            tags$p("The rest of the questions have two possible answers: Yes or 
                   No. The answer to this questions must be selected by the user.
                   After all answers have been selected, click the predict button
                   at the end of the side panel. You may have to scroll up manually
                   to see the results, which will be displayed below Status/Output"), 
            tags$h3("How does this App work?"),
            tags$p("This App takes the input from the user and uses a Machine
                   Learning Random Forest Model to predict a classification based
                   on the user input which can be Positive (The user has diabetes), 
                   or Negative (the user does not have diabetes), and displays 
                   the probability of being classified as either"), 
            tags$h3("How accurate is this model?"), 
            tags$p("Below is the confusion matrix for the model based on the 
                   predictions on the testing data set:"), 
            tableOutput('confusionMatrix'), 
            tags$p("And the results of the model test statistics are displayed
                   below:"), 
            tableOutput('confusionMatrix2'),
            tags$p("Even though the model apparently had an excellent sensitivity
                   and specificity on the predictions for the testing data set, 
                   it is important to note that the model is most likely  overfitted, 
                   and that the predictions for Out of Sample observations may
                   most likely not be accurate at all."),
            tags$h3("Disclaimer"), 
            tags$p("This is for demonstration purposes only, this is not a 
                   diagnostic tool and cannot be used to confirm or exclude 
                   a diagnosis."), 
            tags$h3("See more"), 
            tags$p("To see more about the development of this app, click the
                   links below"),
            tags$a(href="https://github.com/JoelChG/DevelopingDataProducts",
                   "Project GitHub Repository"), 
            tags$br(),
            tags$a(href="https://www.kaggle.com/ishandutta/early-stage-diabetes-risk-prediction-dataset",
                   "Early Stage Diabetes Risk Prediction Dataset")
        )
    )
))