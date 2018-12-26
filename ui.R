shinyUI(
  fluidPage(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
            get_header(),          
            tabsetPanel(
              tabPanel("Image upload / Wordcloud",
                       fluidRow(
                         column(width=4, fileInput('file', '',accept = c('.jpg','.jpeg'))),
                         column(width=4, tags$label(HTML("&zwnj;")), tags$br(), tags$em("Please use the browse button to upload an image (JPG/JPEG format)"))
                       ),
                       tags$hr(),
                       fluidRow(
                         column(width=4, imageOutput('outputImage')),
                         column(width=4, plotOutput("plot"))
                       )),
              tabPanel("Predicted classes & scores", 
                       tags$p(),
                       fluidRow(column(width=8, dataTableOutput("table"))))
            )
  )
)