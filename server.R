
shinyServer(function(input, output) {
  
  outputtext <- reactive({
    req(input$file)
    
    img <- image_load(input$file$datapath, target_size = RESNET_50_IMAGE_FORMAT)
    x <- image_to_array(img)
    x <- array_reshape(x, c(1, dim(x)))
    x <- imagenet_preprocess_input(x)
    preds <- model %>% predict(x)
    df <- imagenet_decode_predictions(preds, top = TOP_CLASSES)[[1]][, c(2,3)]
    names(df) <- c("Object","Score")
    df$Object <- as.character(df$Object)
    df$Score <- as.numeric(as.character(df$Score))
    df
  })
  
  output$plot <- renderPlot({
    df <- outputtext()
    # Separate long categories into shorter terms, so that we can avoid "could not be fit on page. It will not be plotted" warning as much as possible
    objects <- strsplit(as.character(df$Object), ',')
    df <- data.frame(Object = unlist(objects), 
                     Score  = rep(df$Score, sapply(objects, FUN = length)))
    wordcloud(df$Object, df$Score, scale = c(4,2),
              colors = brewer.pal(6, "RdBu"), random.order = F)
  })
  
  output$outputImage <- renderImage({
    req(input$file)
    
    outfile <- input$file$datapath
    contentType <- input$file$type
    list(src = outfile,
         contentType=contentType,
         width = 400)
  }, deleteFile = TRUE)
  
  output$table <- renderDataTable({
    DT::datatable(outputtext(), 
                  rownames = FALSE,
                  options = list(pageLength = TOP_CLASSES, dom = 't'))
  })
})